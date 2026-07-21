import 'package:expense_tracker_ai/features/expense/data/model/expense_hive_model.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_ai/core/constants/expense_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/formatters.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../domain/entity/expense_entity.dart';
import '../bloc/expense_bloc.dart';

class ExpenseCard extends StatelessWidget {
  final Expense data;
  final ExpenseCategory category;
  const ExpenseCard({super.key, required this.data, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Category Icon
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: category.color.withOpacity(.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(category.icon, color: category.color, size: 28),
          ),
          const SizedBox(width: 14),

          // Expense Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.merchant,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 13,
                      color: Colors.grey.shade500,
                    ),

                    const SizedBox(width: 4),

                    Text(
                      Formatters.date(data.date),
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                if (data.notes.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    data.notes,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Amount & Receipt
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "- \$${data.amount.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),

              const SizedBox(height: 10),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red,
                ),
                onPressed: () {
                  context.read<ExpenseBloc>().add(DeleteExpense(data.id));
                  context.read<DashboardBloc>().add(LoadDashboard());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
