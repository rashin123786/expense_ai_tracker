part of 'expense_bloc.dart';

@immutable
sealed class ExpenseState {}

class ExpenseLoadedState extends ExpenseState {
  final double amount;
  final String merchant;
  final ExpenseCategory category;
  final DateTime date;
  final String notes;
  final String? receiptPath;

  final List<Expense> expenses;

  final ExpenseCategory? selectedCategory;

  final bool isSaving;
  final bool saveSuccess;
  final String? error;

  ExpenseLoadedState({
    this.amount = 0,
    this.merchant = '',
    this.category = ExpenseCategory.food,
    DateTime? date,
    this.notes = '',
    this.receiptPath,
    this.expenses = const [],
    this.selectedCategory,
    this.isSaving = false,
    this.saveSuccess = false,
    this.error,
  }) : date = date ?? DateTime.now();

  List<Expense> get filteredExpenses {
    if (selectedCategory == null) {
      return expenses;
    }

    return expenses.where((e) => e.category == selectedCategory).toList();
  }

  ExpenseLoadedState copyWith({
    double? amount,
    String? merchant,
    ExpenseCategory? category,
    DateTime? date,
    String? notes,
    String? receiptPath,
    List<Expense>? expenses,
    ExpenseCategory? selectedCategory,
    bool clearCategory = false,
    bool? isSaving,
    bool? saveSuccess,
    String? error,
  }) {
    return ExpenseLoadedState(
      amount: amount ?? this.amount,
      merchant: merchant ?? this.merchant,
      category: category ?? this.category,
      date: date ?? this.date,
      notes: notes ?? this.notes,
      receiptPath: receiptPath ?? this.receiptPath,
      expenses: expenses ?? this.expenses,
      selectedCategory: clearCategory
          ? null
          : selectedCategory ?? this.selectedCategory,
      isSaving: isSaving ?? this.isSaving,
      saveSuccess: saveSuccess ?? this.saveSuccess,
      error: error,
    );
  }
}
