import 'package:expense_tracker_ai/shared/bloc/navcontainer_bloc.dart';
import 'package:expense_tracker_ai/shared/widgets/main_layout_screen.dart';
import 'package:expense_tracker_ai/features/receipt/presentation/bloc/receipt_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/ai_insights/presentation/bloc/ai_bloc.dart';
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/expense/presentation/bloc/expense_bloc.dart';
import '../../features/expense/presentation/screens/add_expense_screen.dart';
import '../../features/splash/presentation/bloc/splash_bloc.dart';
import '../../features/splash/presentation/screens/splash_screens.dart';
import '../di/injection.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashPage()),
      GoRoute(path: '/home', builder: (context, state) => MainLayoutPage()),
      GoRoute(
        path: '/add-expense',
        builder: (context, state) {
          return AddExpenseScreen();
        },
      ),
    ],
  );
}
