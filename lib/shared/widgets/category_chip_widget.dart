import 'package:expense_tracker_ai/core/constants/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/expense/data/model/expense_hive_model.dart';
import '../../features/expense/presentation/bloc/expense_bloc.dart';

class CategoryFilter extends StatelessWidget {
  final ExpenseCategory? selected;

  const CategoryFilter({super.key, this.selected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        children: [
          FilterChip(
            label: const Text("All"),
            selected: selected == null,
            onSelected: (_) {
              context.read<ExpenseBloc>().add(FilterExpenses(null));
            },
          ),

          const SizedBox(width: 8),

          ...ExpenseCategory.values.map(
            (e) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryChip(
                      category: e,
                      selected: selected == e,
                      onTap: () {
                        context.read<ExpenseBloc>().add(FilterExpenses(e));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final ExpenseCategory category;
  final bool selected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.category,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: selected
              ? category.color.withValues(alpha: 0.15)
              : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: selected ? category.color : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(category.icon, color: category.color, size: 18),
            const SizedBox(width: 8),
            Text(category.shortLabel),
          ],
        ),
      ),
    );
  }
}
