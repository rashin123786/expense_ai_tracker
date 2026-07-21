import 'dart:io';

import '../../../expense/domain/entity/expense_entity.dart';

abstract class ReceiptRepository {
  Future<Expense> scanReceipt(File image);
}
