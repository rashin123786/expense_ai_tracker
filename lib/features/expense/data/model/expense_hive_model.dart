import 'package:hive/hive.dart';

import '../../domain/entity/expense_entity.dart';

part 'expense_hive_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  double amount;

  @HiveField(2)
  String merchant;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  ExpenseCategory category;

  @HiveField(5)
  String notes;

  @HiveField(6)
  String? receiptPath;

  ExpenseModel({
    required this.id,
    required this.amount,
    required this.merchant,
    required this.date,
    required this.category,
    required this.notes,
    this.receiptPath,
  });

  factory ExpenseModel.fromEntity(Expense expense) {
    return ExpenseModel(
      id: expense.id,
      amount: expense.amount,
      merchant: expense.merchant,
      date: expense.date,
      category: expense.category,
      notes: expense.notes,
      receiptPath: expense.receiptPath,
    );
  }

  Expense toEntity() {
    return Expense(
      id: id,
      amount: amount,
      merchant: merchant,
      date: date,
      category: category,
      notes: notes,
      receiptPath: receiptPath,
    );
  }
}

@HiveType(typeId: 1)
enum ExpenseCategory {
  @HiveField(0)
  food,

  @HiveField(1)
  transport,

  @HiveField(2)
  shopping,

  @HiveField(3)
  health,

  @HiveField(4)
  entertainment,

  @HiveField(5)
  bills,

  @HiveField(6)
  other,
}
