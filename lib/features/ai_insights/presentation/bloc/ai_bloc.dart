import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/ai_usecases.dart';

part 'ai_event.dart';
part 'ai_state.dart';

class AiBloc extends Bloc<AiEvent, AiState> {
  final GenerateAiSummaryUsecase usecase;

  AiBloc(this.usecase) : super(AiState()) {
    on<GenerateSummaryPressed>(_generate);
  }
  Future<void> _generate(
    GenerateSummaryPressed event,

    Emitter<AiState> emit,
  ) async {
    emit(state.copyWith(loading: true));

    final result = await usecase.call();

    emit(state.copyWith(loading: false, summary: result));
  }
}
