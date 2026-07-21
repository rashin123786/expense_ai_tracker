import 'dart:io';

import '../../../expense/domain/entity/expense_entity.dart';
import '../repository/receipt_repository.dart';

class ScanReceiptUseCase {
  final ReceiptRepository repository;

  ScanReceiptUseCase(this.repository);

  Future<Expense> call(File image) {
    return repository.scanReceipt(image);
  }
}
