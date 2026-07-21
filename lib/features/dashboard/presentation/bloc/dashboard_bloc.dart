import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../expense/data/model/expense_hive_model.dart';
import '../../../expense/domain/usecase/expense_usecases.dart';
import '../../domain/entity/dashboard_entity.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final ExpenseUsecases usecases;

  DashboardBloc(this.usecases) : super(DashboardInitial()) {
    on<LoadDashboard>(_load);
  }
  Future<void> _load(LoadDashboard event, Emitter<DashboardState> emit) async {
    final expenses = await usecases.getExpenses();

    // Total
    final total = expenses.fold<double>(0, (sum, e) => sum + e.amount);

    // Category
    final Map<ExpenseCategory, double> categoryMap = {};

    for (final e in expenses) {
      categoryMap[e.category] = (categoryMap[e.category] ?? 0) + e.amount;
    }

    // Monthly
    final Map<String, double> monthly = {};

    for (final e in expenses) {
      final month = DateFormat('MMM').format(e.date);

      monthly[month] = (monthly[month] ?? 0) + e.amount;
    }

    // Recent
    expenses.sort((a, b) => b.date.compareTo(a.date));

    final recent = expenses.take(5).toList();

    // Analytics

    final averageExpense = expenses.isEmpty ? 0 : total / expenses.length;

    final totalTransactions = expenses.length;

    final highestExpense = expenses.isEmpty
        ? 0
        : expenses.map((e) => e.amount).reduce((a, b) => a > b ? a : b);

    final now = DateTime.now();

    final thisMonthExpense = expenses
        .where((e) => e.date.month == now.month && e.date.year == now.year)
        .fold<double>(0, (sum, e) => sum + e.amount);

    emit(
      DashboardLoaded(
        DashboardEntity(
          totalExpense: total,
          categoryTotals: categoryMap,
          monthlyTotals: monthly,
          recentExpenses: recent,
          averageExpense: averageExpense.toDouble(),
          totalTransactions: totalTransactions,
          highestExpense: highestExpense.toDouble(),
          thisMonthExpense: thisMonthExpense,
        ),
      ),
    );
  }
}
