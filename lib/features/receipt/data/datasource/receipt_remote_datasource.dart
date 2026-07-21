import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../expense/data/model/expense_hive_model.dart';
import '../../../expense/domain/entity/expense_entity.dart';

abstract class ReceiptRemoteDataSource {
  Future<Expense> scanReceipt(File image);
}

class ReceiptRemoteDataSourceImpl implements ReceiptRemoteDataSource {
  final Dio dio = Dio();

  static String apiKey = dotenv.env['GEMINI_API_KEY']!;

  @override
  Future<Expense> scanReceipt(File image) async {
    final bytes = await image.readAsBytes();
    final base64Image = base64Encode(bytes);
    final ext = image.path.split('.').last.toLowerCase();
    final mimeType = switch (ext) {
      'png' => 'image/png',
      'webp' => 'image/webp',
      _ => 'image/jpeg',
    };
    final response = await dio.post(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey",
      data: {
        "contents": [
          {
            "parts": [
              {"text": receiptPrompt},
              {
                "inline_data": {"mime_type": mimeType, "data": base64Image},
              },
            ],
          },
        ],
      },
    );

    try {
      final text =
          response.data["candidates"][0]["content"]["parts"][0]["text"];

      final cleaned = text
          .replaceAll("```json", "")
          .replaceAll("```", "")
          .trim();

      final json = jsonDecode(cleaned);

      return Expense(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        merchant: json["merchant"] ?? "",
        amount: (json["amount"] as num).toDouble(),
        date: DateTime.parse(json["date"]),
        category: _category(json["category"]),
        notes: json["notes"] ?? "",
        receiptPath: image.path,
      );
    } catch (e) {
      throw Exception("Failed to parse Gemini response: $e");
    }
  }

  ExpenseCategory _category(String? value) {
    switch (value?.toLowerCase()) {
      case "food":
        return ExpenseCategory.food;
      case "shopping":
        return ExpenseCategory.shopping;
      case "transport":
        return ExpenseCategory.transport;
      case "health":
        return ExpenseCategory.health;
      case "entertainment":
        return ExpenseCategory.entertainment;
      case "bills":
        return ExpenseCategory.bills;
      default:
        return ExpenseCategory.other;
    }
  }

  Future<String?> callGeminiWithRetry(
    Function apiCall, {
    int maxRetries = 4,
  }) async {
    int retryCount = 0;
    final random = Random();

    while (retryCount < maxRetries) {
      try {
        // Execute your Gemini API call logic here
        return await apiCall();
      } catch (e) {
        if (e.toString().contains("rate limit exceeded") ||
            e.toString().contains("429")) {
          retryCount++;
          if (retryCount >= maxRetries)
            throw Exception("Max retries reached. Rate limit persistent.");

          // Calculate delay: 2^retryCount + random milliseconds (Jitter)
          int delaySeconds = pow(2, retryCount).toInt();
          int jitter = random.nextInt(1000);

          print("Rate limit hit. Retrying in ${delaySeconds}s...");
          await Future.delayed(
            Duration(seconds: delaySeconds, milliseconds: jitter),
          );
        } else {
          rethrow; // Rethrow other unexpected exceptions
        }
      }
    }
    return null;
  }
}
