import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../receipt/presentation/bloc/receipt_bloc.dart';
import '../bloc/expense_bloc.dart';

class SaveExpenseButton extends StatelessWidget {
  const SaveExpenseButton({
    super.key,
    required this.current,
    required this.onSave,
  });

  final ExpenseLoadedState current;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, receiptState) {
        final isScanning = receiptState is ReceiptLoading;

        return SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  blurRadius: 18,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SizedBox(
              height: 58,
              child: ElevatedButton(
                onPressed: (current.isSaving || isScanning) ? null : onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isScanning
                      ? Colors.orange
                      : current.isSaving
                      ? Colors.green
                      : Theme.of(context).primaryColor,
                  disabledBackgroundColor: isScanning
                      ? Colors.orange
                      : Colors.grey.shade400,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),

                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: isScanning
                      ? const Row(
                          key: ValueKey("scan"),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 14),
                            Text(
                              "Scanning Receipt...",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        )
                      : current.isSaving
                      ? const Row(
                          key: ValueKey("save"),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 14),
                            Text(
                              "Saving Expense...",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        )
                      : const Text(
                          "Save Expense",
                          key: ValueKey("normal"),
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
