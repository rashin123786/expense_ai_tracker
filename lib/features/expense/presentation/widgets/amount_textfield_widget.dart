import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../bloc/expense_bloc.dart';

class AmountTexfieldWidget extends StatelessWidget {
  const AmountTexfieldWidget({
    super.key,
    required this.amountController,
    this.validator,
  });

  final TextEditingController amountController;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        validator: validator,
        controller: amountController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: AppColors.backgroundDark,
        ),
        onChanged: (value) {
          context.read<ExpenseBloc>().add(AmountChanged(value));
        },
        decoration: InputDecoration(
          hintText: "0.00",
          hintStyle: GoogleFonts.poppins(
            fontSize: 30,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w600,
          ),

          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Center(
              widthFactor: 1,
              child: Text(
                "₹",
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),

          suffixIcon: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              widthFactor: 1,
              child: Text(
                "INR",
                style: GoogleFonts.roboto(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),

          filled: true,
          fillColor: Colors.white,

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 22,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
      ),
    );
  }
}
