import 'package:hive/hive.dart';

import '../model/expense_hive_model.dart';

abstract class ExpenseLocalDataSource {
  Future<void> addExpense(ExpenseModel expense);

  Future<List<ExpenseModel>> getExpenses();

  Future<void> updateExpense(ExpenseModel expense);

  Future<void> deleteExpense(String id);
}

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  final Box<ExpenseModel> box;

  ExpenseLocalDataSourceImpl(this.box);

  @override
  Future<void> addExpense(ExpenseModel expense) async {
    await box.put(expense.id, expense);
  }

  @override
  Future<List<ExpenseModel>> getExpenses() async {
    return box.values.toList();
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    await box.put(expense.id, expense);
  }

  @override
  Future<void> deleteExpense(String id) async {
    await box.delete(id);
  }
}
