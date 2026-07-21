part of 'receipt_bloc.dart';

@immutable
sealed class ReceiptState {}

final class ReceiptInitial extends ReceiptState {}

class ReceiptLoading extends ReceiptState {}

class ReceiptSuccess extends ReceiptState {
  final Expense expense;

  ReceiptSuccess(this.expense);
}

class ReceiptFailure extends ReceiptState {
  final String message;

  ReceiptFailure(this.message);
}
