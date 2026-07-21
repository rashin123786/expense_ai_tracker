import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../expense/presentation/bloc/expense_bloc.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/analytics_card.dart';
import '../widgets/greeting_header.dart';
import '../widgets/pie_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is! DashboardLoaded) {
                return const Center(child: CircularProgressIndicator());
              }
              final dashboard = state.dashboard;

              final totalExpense = dashboard.totalExpense;

              final categoryTotals = dashboard.categoryTotals;

              final averageExpense = dashboard.averageExpense;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    GreetingHeader(),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          colors: [Color(0xff6C63FF), Color(0xff8F7CFF)],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total Spending",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            "₹${totalExpense.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 34,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            "${state.dashboard.recentExpenses.length} Transactions",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (categoryTotals.isNotEmpty || totalExpense != 0)
                      PieChartWidget(
                        categoryTotals: categoryTotals,
                        totalExpense: totalExpense,
                      ),
                    const SizedBox(height: 24),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Quick Analytics",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 1.45,
                      children: [
                        AnalyticsCard(
                          title: "Average",
                          value: "₹${averageExpense.toStringAsFixed(0)}",
                          icon: Icons.auto_graph,
                          color: Colors.deepPurple,
                        ),

                        AnalyticsCard(
                          title: "Transactions",
                          value: "${dashboard.recentExpenses.length}",
                          icon: Icons.receipt_long,
                          color: Colors.blue,
                        ),

                        AnalyticsCard(
                          title: "Highest",
                          value:
                              "₹${dashboard.highestExpense.toStringAsFixed(0)}",
                          icon: Icons.trending_up,
                          color: Colors.redAccent,
                        ),

                        AnalyticsCard(
                          title: "This Month",
                          value:
                              "₹${dashboard.thisMonthExpense.toStringAsFixed(0)}",
                          icon: Icons.calendar_month,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add-expense', extra: context.read<ExpenseBloc>());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
