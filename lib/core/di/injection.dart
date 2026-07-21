import 'package:dio/dio.dart';
import 'package:expense_tracker_ai/features/expense/domain/usecase/expense_usecases.dart';
import 'package:expense_tracker_ai/shared/bloc/navcontainer_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../features/ai_insights/data/datasource/ai_datasource.dart';
import '../../features/ai_insights/data/respository/ai_repositoy.dart';
import '../../features/ai_insights/domain/repository/ai_repo.dart';
import '../../features/ai_insights/domain/usecase/ai_usecases.dart';
import '../../features/ai_insights/presentation/bloc/ai_bloc.dart';
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../features/expense/data/datasource/expense_dataource.dart';
import '../../features/expense/data/model/expense_hive_model.dart';
import '../../features/expense/data/respository/expense_repository.dart';
import '../../features/expense/domain/repository/expense_repo.dart';
import '../../features/expense/presentation/bloc/expense_bloc.dart';
import '../../features/receipt/data/datasource/receipt_remote_datasource.dart';
import '../../features/receipt/data/respository/receipt_repo.dart';
import '../../features/receipt/domain/repository/receipt_repository.dart';
import '../../features/receipt/domain/usecase/receipt_usecases.dart';
import '../../features/receipt/presentation/bloc/receipt_bloc.dart';

final GetIt sl = GetIt.instance;
Future<void> setupDependencyInjection() async {
  sl.registerLazySingleton(() => Hive.box<ExpenseModel>("expenses"));

  sl.registerLazySingleton<ExpenseLocalDataSource>(
    () => ExpenseLocalDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<ExpenseUsecases>(() => ExpenseUsecases(sl()));
  sl.registerFactory<NavContainerBloc>(() => NavContainerBloc());
  sl.registerFactory<ExpenseBloc>(() => ExpenseBloc(sl<ExpenseUsecases>()));

  sl.registerLazySingleton<AiRemoteDatasource>(
    () => AiRemoteDatasource(Dio(), sl<ExpenseUsecases>()),
  );

  sl.registerLazySingleton<AiRepository>(() => AiRepositoryImpl(sl()));

  sl.registerLazySingleton(() => GenerateAiSummaryUsecase(sl()));

  sl.registerFactory(() => AiBloc(sl()));
  sl.registerLazySingleton<ReceiptRemoteDataSource>(
    () => ReceiptRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<ReceiptRepository>(
    () => ReceiptRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => ScanReceiptUseCase(sl()));

  sl.registerFactory(() => ReceiptBloc(ScanReceiptUseCase(sl())));
  sl.registerFactory(() => DashboardBloc(sl()));
}
