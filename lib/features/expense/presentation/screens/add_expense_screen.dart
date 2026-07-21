import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';

import '../../../../shared/widgets/category_chip_widget.dart';
import '../../../ai_insights/presentation/bloc/ai_bloc.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../receipt/presentation/bloc/receipt_bloc.dart';
import '../../data/model/expense_hive_model.dart';

import '../bloc/expense_bloc.dart';
import '../widgets/ai_reciept_scanner_widget.dart';
import '../widgets/amount_textfield_widget.dart';
import '../widgets/date_widget.dart';
import '../widgets/merchant_textfield_widget.dart';
import '../widgets/notes_widget.dart';
import '../widgets/save_expense_button.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();

  final merchantController = TextEditingController();

  final amountController = TextEditingController();

  final notesController = TextEditingController();
  @override
  void dispose() {
    merchantController.dispose();
    amountController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ReceiptBloc, ReceiptState>(
          listener: (context, state) {
            if (state is ReceiptSuccess) {
              context.read<ExpenseBloc>().add(AutoFillExpense(state.expense));
              merchantController.text = state.expense.merchant;

              amountController.text = state.expense.amount.toString();

              notesController.text = state.expense.notes;
            } else if (state is ReceiptFailure) {
              final message = state.message;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
        ),
        BlocListener<ExpenseBloc, ExpenseState>(
          listenWhen: (previous, current) {
            if (previous is ExpenseLoadedState &&
                current is ExpenseLoadedState) {
              return previous.saveSuccess != current.saveSuccess;
            }
            return false;
          },
          listener: (context, state) async {
            if (state is ExpenseLoadedState && state.saveSuccess) {
              final current = state as ExpenseLoadedState;

              if (current.saveSuccess) {
                context.read<DashboardBloc>().add(LoadDashboard());

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Expense saved successfully")),
                );

                context.read<ExpenseBloc>().add(ResetSaveSuccess());

                context.pop();
              }
            }
          },
        ),
      ],
      child: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          final current = state as ExpenseLoadedState;

          return Scaffold(
            appBar: AppBar(title: Text('Add Expense')),
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                  children: [
                    Center(
                      child: Text(
                        'AMOUNT',
                        style: GoogleFonts.roboto(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 16),
                      child: AmountTexfieldWidget(
                        amountController: amountController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "amount is required";
                          }
                          return null;
                        },
                      ),
                    ),

                    Text(
                      'MERCHANT',
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                        letterSpacing: 1.2,
                      ),
                    ),

                    MerchantTexfieldWidget(
                      merchantController: merchantController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Merchant name is required";
                        }
                        return null;
                      },
                    ),

                    Text(
                      'DATE',
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                        letterSpacing: 1.2,
                      ),
                    ),

                    DateWidget(current: current),
                    Text(
                      'CATEGORY',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: ExpenseCategory.values.map((category) {
                          return CategoryChip(
                            category: category,
                            selected: current.category == category,
                            onTap: () {
                              context.read<ExpenseBloc>().add(
                                CategoryChanged(category),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),

                    Text(
                      'NOTES',
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                        letterSpacing: 1.2,
                      ),
                    ),

                    NotesWidget(notesController: notesController),

                    AiReceiptScannerWidget(),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SaveExpenseButton(
              current: current,
              onSave: () {
                if (_formKey.currentState!.validate()) {
                  context.read<ExpenseBloc>().add(SaveExpense());
                }
              },
            ),
          );
        },
      ),
    );
  }
}
