import '../../domain/entity/expense_entity.dart';

abstract class ExpenseRepository {
  Future<void> addExpense(Expense expense);

  Future<List<Expense>> getExpenses();

  Future<void> updateExpense(Expense expense);

  Future<void> deleteExpense(String id);
}
