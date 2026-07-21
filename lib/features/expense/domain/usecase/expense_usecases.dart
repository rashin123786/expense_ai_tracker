import '../../data/respository/expense_repository.dart';
import '../entity/expense_entity.dart';

class ExpenseUsecases {
  final ExpenseRepository repository;

  ExpenseUsecases(this.repository);

  Future<void> addExpense(Expense expense) {
    return repository.addExpense(expense);
  }

  Future<List<Expense>> getExpenses() {
    return repository.getExpenses();
  }

  Future<void> updateExpense(Expense expense) {
    return repository.updateExpense(expense);
  }

  Future<void> deleteExpense(String id) {
    return repository.deleteExpense(id);
  }
}
