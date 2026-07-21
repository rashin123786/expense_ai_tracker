import '../repository/ai_repo.dart';

class GenerateAiSummaryUsecase {
  final AiRepository repository;

  GenerateAiSummaryUsecase(this.repository);

  Future<String> call() {
    return repository.generateSummary();
  }
}
