part of 'ai_bloc.dart';

@immutable
class AiState {
  final bool loading;
  final String summary;
  final String? error;

  const AiState({this.loading = false, this.summary = "", this.error});

  AiState copyWith({bool? loading, String? summary, String? error}) {
    return AiState(
      loading: loading ?? this.loading,
      summary: summary ?? this.summary,
      error: error,
    );
  }
}
