import '../../domain/repository/ai_repo.dart';
import '../datasource/ai_datasource.dart';

class AiRepositoryImpl implements AiRepository {
  final AiRemoteDatasource remote;

  AiRepositoryImpl(this.remote);

  @override
  Future<String> generateSummary() {
    return remote.generateSummary();
  }
}
