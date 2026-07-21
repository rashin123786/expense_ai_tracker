import 'package:flutter/material.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "Good Morning 👋",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              Text(
                "Track your spending wisely",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),

          CircleAvatar(
            backgroundColor: Colors.deepPurple.shade50,

            child: Icon(Icons.notifications_none, color: Colors.deepPurple),
          ),
        ],
      ),
    );
  }
}
