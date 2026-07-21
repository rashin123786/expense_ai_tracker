import 'package:expense_tracker_ai/features/ai_insights/presentation/screens/ai_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/expense/presentation/screens/expense_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../bloc/navcontainer_bloc.dart';

class MainLayoutPage extends StatelessWidget {
  const MainLayoutPage({super.key});

  static const List<Widget> _screens = [
    DashboardScreen(),
    ExpenseScreen(),
    AiScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavContainerBloc, NavContainerState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(index: state.selectedIndex, children: _screens),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.selectedIndex,
            onTap: (index) {
              context.read<NavContainerBloc>().add(TabChanged(index));
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long),
                label: 'Expenses',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.auto_awesome),
                label: 'AI',
              ),
            ],
          ),
        );
      },
    );
  }
}
