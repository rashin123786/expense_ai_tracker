import 'package:bloc/bloc.dart';
import 'package:expense_tracker_ai/features/expense/domain/usecase/expense_usecases.dart';
import 'package:meta/meta.dart';

import '../../data/model/expense_hive_model.dart';
import '../../domain/entity/expense_entity.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseUsecases expenseUsecases;

  ExpenseBloc(this.expenseUsecases) : super(ExpenseLoadedState()) {
    on<ResetSaveSuccess>((event, emit) {
      final current = state as ExpenseLoadedState;

      emit(current.copyWith(saveSuccess: false));
    });
    on<AmountChanged>(_onAmountChanged);

    on<MerchantChanged>(_onMerchantChanged);

    on<CategoryChanged>(_onCategoryChanged);

    on<DateChanged>(_onDateChanged);

    on<NotesChanged>(_onNotesChanged);

    on<ReceiptSelected>(_onReceiptSelected);

    on<SaveExpense>(_onSaveExpense);
    on<LoadExpenses>(_onLoadExpenses);
    on<FilterExpenses>(_onFilterExpenses);
    on<DeleteExpense>(_onDeleteExpense);
    on<AutoFillExpense>(_onAutoFillExpense);
  }

  Future<void> _onAmountChanged(
    AmountChanged event,
    Emitter<ExpenseState> emit,
  ) async {
    final current = state as ExpenseLoadedState;

    emit(current.copyWith(amount: double.tryParse(event.amount) ?? 0));
  }

  Future<void> _onMerchantChanged(
    MerchantChanged event,
    Emitter<ExpenseState> emit,
  ) async {
    final current = state as ExpenseLoadedState;

    emit(current.copyWith(merchant: event.merchant));
  }

  Future<void> _onCategoryChanged(
    CategoryChanged event,
    Emitter<ExpenseState> emit,
  ) async {
    final current = state as ExpenseLoadedState;

    emit(current.copyWith(category: event.category));
  }

  Future<void> _onDateChanged(
    DateChanged event,
    Emitter<ExpenseState> emit,
  ) async {
    final current = state as ExpenseLoadedState;

    emit(current.copyWith(date: event.date));
  }

  Future<void> _onNotesChanged(
    NotesChanged event,
    Emitter<ExpenseState> emit,
  ) async {
    final current = state as ExpenseLoadedState;

    emit(current.copyWith(notes: event.notes));
  }

  Future<void> _onReceiptSelected(
    ReceiptSelected event,
    Emitter<ExpenseState> emit,
  ) async {
    final current = state as ExpenseLoadedState;

    emit(current.copyWith(receiptPath: event.receiptPath));
  }

  Future<void> _onSaveExpense(
    SaveExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    final current = state as ExpenseLoadedState;

    emit(current.copyWith(isSaving: true));

    final expense = Expense(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: current.amount,
      merchant: current.merchant,
      date: current.date,
      category: current.category,
      notes: current.notes,
      receiptPath: current.receiptPath,
    );

    await expenseUsecases.addExpense(expense);

    final expenses = await expenseUsecases.getExpenses();

    emit(
      current.copyWith(expenses: expenses, isSaving: false, saveSuccess: true),
    );
  }

  Future<void> _onLoadExpenses(
    LoadExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    final current = state as ExpenseLoadedState;

    final expenses = await expenseUsecases.getExpenses();

    emit(current.copyWith(expenses: expenses));
  }

  Future<void> _onFilterExpenses(
    FilterExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    final current = state as ExpenseLoadedState;

    emit(
      current.copyWith(
        selectedCategory: event.category,
        clearCategory: event.category == null,
      ),
    );
  }

  Future<void> _onDeleteExpense(
    DeleteExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    final current = state as ExpenseLoadedState;

    await expenseUsecases.deleteExpense(event.id);
    final expenses = await expenseUsecases.getExpenses();

    emit(
      current.copyWith(expenses: expenses, isSaving: false, saveSuccess: false),
    );
  }

  Future<void> _onAutoFillExpense(
    AutoFillExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    final current = state as ExpenseLoadedState;

    emit(
      current.copyWith(
        amount: event.expense.amount,
        merchant: event.expense.merchant,
        category: event.expense.category,
        date: event.expense.date,
        notes: event.expense.notes,
        receiptPath: event.expense.receiptPath,
        saveSuccess: false,
      ),
    );
  }
}
