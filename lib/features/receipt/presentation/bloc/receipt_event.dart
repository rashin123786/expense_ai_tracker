part of 'receipt_bloc.dart';

@immutable
sealed class ReceiptEvent {}

class ScanReceipt extends ReceiptEvent {
  final File image;

  ScanReceipt(this.image);
}

class PickFromGallery extends ReceiptEvent {}

class CaptureFromCamera extends ReceiptEvent {}
