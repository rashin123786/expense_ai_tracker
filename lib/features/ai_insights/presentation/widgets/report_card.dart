import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({super.key, required this.report});
  final String report;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(blurRadius: 15, color: Colors.black.withValues(alpha: .05)),
        ],
      ),
      child: MarkdownBody(data: report, selectable: true),
    );
  }
}
