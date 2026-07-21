import 'package:expense_tracker_ai/features/ai_insights/presentation/widgets/empty_card.dart';
import 'package:expense_tracker_ai/features/ai_insights/presentation/widgets/header_widget.dart';
import 'package:expense_tracker_ai/features/ai_insights/presentation/widgets/report_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/ai_bloc.dart';

class AiScreen extends StatelessWidget {
  const AiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("AI Spending Insights"),
        centerTitle: true,
      ),
      body: BlocBuilder<AiBloc, AiState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeaderWidget(),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 58),
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: state.loading
                      ? null
                      : () {
                          context.read<AiBloc>().add(GenerateSummaryPressed());
                        },
                  icon: state.loading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.auto_awesome),

                  label: Text(
                    state.loading ? "Generating..." : "Generate AI Report",
                  ),
                ),

                const SizedBox(height: 28),

                if (state.summary.isEmpty && !state.loading) EmptyCard(),

                if (state.summary.isNotEmpty) ReportCard(report: state.summary),
              ],
            ),
          );
        },
      ),
    );
  }
}
