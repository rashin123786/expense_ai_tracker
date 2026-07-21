part of 'expense_bloc.dart';

abstract class ExpenseEvent {}

class SaveExpense extends ExpenseEvent {}

class DeleteExpense extends ExpenseEvent {
  final String id;

  DeleteExpense(this.id);
}

class DateChanged extends ExpenseEvent {
  final DateTime date;

  DateChanged(this.date);
}

class ReceiptSelected extends ExpenseEvent {
  final String receiptPath;

  ReceiptSelected(this.receiptPath);
}

class ScanReceiptPressed extends ExpenseEvent {}

class UploadReceiptPressed extends ExpenseEvent {}

class CategoryChanged extends ExpenseEvent {
  final ExpenseCategory category;

  CategoryChanged(this.category);
}

class AmountChanged extends ExpenseEvent {
  final String amount;

  AmountChanged(this.amount);
}

class MerchantChanged extends ExpenseEvent {
  final String merchant;

  MerchantChanged(this.merchant);
}

class NotesChanged extends ExpenseEvent {
  final String notes;

  NotesChanged(this.notes);
}

class LoadExpenses extends ExpenseEvent {}

class FilterExpenses extends ExpenseEvent {
  final ExpenseCategory? category;

  FilterExpenses(this.category);
}

class AutoFillExpense extends ExpenseEvent {
  final Expense expense;

  AutoFillExpense(this.expense);
}

class ResetSaveSuccess extends ExpenseEvent {}
