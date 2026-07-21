import 'dart:io';

import '../../domain/repository/receipt_repository.dart';
import '../datasource/receipt_remote_datasource.dart';

import '../../../expense/domain/entity/expense_entity.dart';

class ReceiptRepositoryImpl implements ReceiptRepository {
  final ReceiptRemoteDataSource remote;

  ReceiptRepositoryImpl(this.remote);

  @override
  Future<Expense> scanReceipt(File image) {
    return remote.scanReceipt(image);
  }
}
