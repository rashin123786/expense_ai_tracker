import '../../../expense/data/model/expense_hive_model.dart';
import '../../../expense/domain/entity/expense_entity.dart';

class DashboardEntity {
  final double totalExpense;
  final Map<ExpenseCategory, double> categoryTotals;
  final Map<String, double> monthlyTotals;
  final List<Expense> recentExpenses;

  final double averageExpense;
  final int totalTransactions;
  final double highestExpense;
  final double thisMonthExpense;

  DashboardEntity({
    required this.totalExpense,
    required this.categoryTotals,
    required this.monthlyTotals,
    required this.recentExpenses,
    required this.averageExpense,
    required this.totalTransactions,
    required this.highestExpense,
    required this.thisMonthExpense,
  });
}
