import '../../data/datasource/expense_dataource.dart';
import '../../data/model/expense_hive_model.dart';
import '../../data/respository/expense_repository.dart';
import '../entity/expense_entity.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource local;

  ExpenseRepositoryImpl(this.local);

  @override
  Future<void> addExpense(Expense expense) {
    return local.addExpense(ExpenseModel.fromEntity(expense));
  }

  @override
  Future<List<Expense>> getExpenses() async {
    final result = await local.getExpenses();

    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> updateExpense(Expense expense) {
    return local.updateExpense(ExpenseModel.fromEntity(expense));
  }

  @override
  Future<void> deleteExpense(String id) {
    return local.deleteExpense(id);
  }
}
