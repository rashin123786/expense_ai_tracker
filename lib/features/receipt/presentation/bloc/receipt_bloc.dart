import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../expense/domain/entity/expense_entity.dart';
import '../../domain/usecase/receipt_usecases.dart';

part 'receipt_event.dart';
part 'receipt_state.dart';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  final ScanReceiptUseCase scanReceiptUsecase;
  ReceiptBloc(this.scanReceiptUsecase) : super(ReceiptInitial()) {
    on<ScanReceipt>(_scanReceipt);
  }
  Future<void> _scanReceipt(
    ScanReceipt event,
    Emitter<ReceiptState> emit,
  ) async {
    emit(ReceiptLoading());

    try {
      final expense = await scanReceiptUsecase.call(event.image);

      emit(ReceiptSuccess(expense));
    } catch (e) {
      emit(ReceiptFailure(e.toString()));
    }
  }
}
