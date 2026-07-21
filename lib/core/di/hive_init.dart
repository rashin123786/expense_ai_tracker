import 'package:hive_flutter/hive_flutter.dart';

import '../../features/expense/data/model/expense_hive_model.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ExpenseModelAdapter());

  Hive.registerAdapter(ExpenseCategoryAdapter());

  await Hive.openBox<ExpenseModel>("expenses");
}
