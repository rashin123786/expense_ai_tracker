import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        children: [
          Icon(Icons.auto_awesome, size: 70, color: Colors.deepPurple),

          SizedBox(height: 16),

          Text(
            "Generate your first AI report",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 8),

          Text(
            "AI will analyze your spending habits, trends and provide smart saving recommendations.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
