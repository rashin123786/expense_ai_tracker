import '../../data/model/expense_hive_model.dart';

class Expense {
  final String id;

  final double amount;

  final String merchant;

  final DateTime date;

  final ExpenseCategory category;

  final String notes;

  final String? receiptPath;

  Expense({
    required this.id,
    required this.amount,
    required this.merchant,
    required this.date,
    required this.category,
    required this.notes,
    this.receiptPath,
  });
}
