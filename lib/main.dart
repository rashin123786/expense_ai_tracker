import 'package:expense_tracker_ai/core/di/hive_init.dart';
import 'package:expense_tracker_ai/core/di/injection.dart';
import 'package:expense_tracker_ai/core/routing/app_route.dart';
import 'package:expense_tracker_ai/core/theme/app_theme.dart';
import 'package:expense_tracker_ai/features/ai_insights/presentation/bloc/ai_bloc.dart';
import 'package:expense_tracker_ai/features/receipt/presentation/bloc/receipt_bloc.dart';
import 'package:expense_tracker_ai/shared/bloc/navcontainer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/expense/presentation/bloc/expense_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await setupDependencyInjection();
  await initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavContainerBloc>(create: (_) => sl<NavContainerBloc>()),
        BlocProvider(create: (_) => sl<ExpenseBloc>()..add(LoadExpenses())),
        BlocProvider(create: (_) => sl<DashboardBloc>()..add(LoadDashboard())),
        BlocProvider(create: (_) => sl<AiBloc>()),
        BlocProvider(create: (_) => sl<ReceiptBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
