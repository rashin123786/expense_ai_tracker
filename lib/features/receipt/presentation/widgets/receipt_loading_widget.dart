import 'package:flutter/material.dart';

class ReceiptLoadingWidget extends StatelessWidget {
  const ReceiptLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 55,
            height: 55,
            child: CircularProgressIndicator(strokeWidth: 4),
          ),

          const SizedBox(height: 24),

          const Text(
            "Scanning Receipt",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text(
            "Our AI is extracting\nmerchant, amount and date.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600),
          ),

          const SizedBox(height: 18),

          const LinearProgressIndicator(),
        ],
      ),
    );
  }
}
