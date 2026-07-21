import 'package:dio/dio.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../expense/domain/usecase/expense_usecases.dart';

class AiRemoteDatasource {
  final Dio dio;
  final ExpenseUsecases expenseUsecases;

  AiRemoteDatasource(this.dio, this.expenseUsecases);

  final String apiKey = dotenv.env['GEMINI_API_KEY']!;
  Future<String> generateSummary() async {
    try {
      final expenses = await expenseUsecases.getExpenses();

      if (expenses.isEmpty) {
        return "No expenses found. Add some transactions to generate AI insights.";
      }

      final transactions = expenses
          .map(
            (e) =>
                "${e.date.toIso8601String()} | ${e.category.name} | ${e.merchant} | ₹${e.amount.toStringAsFixed(2)}",
          )
          .join("\n");

      final response = await dio.post(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey",
        data: {
          "contents": [
            {
              "parts": [
                {
                  "text":
                      """
$prompt

Transactions:

$transactions
""",
                },
              ],
            },
          ],
        },
      );

      return response.data["candidates"][0]["content"]["parts"][0]["text"]
          .toString()
          .trim();
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 400:
          throw Exception("Invalid request sent to Gemini.");

        case 401:
          throw Exception("Invalid Gemini API key.");

        case 403:
          throw Exception("Gemini API access denied.");

        case 429:
          throw Exception(
            "Gemini API rate limit exceeded. Please wait a few minutes and try again.",
          );

        case 500:
        case 503:
          throw Exception("Gemini server is temporarily unavailable.");

        default:
          throw Exception("Network error (${e.response?.statusCode}).");
      }
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
