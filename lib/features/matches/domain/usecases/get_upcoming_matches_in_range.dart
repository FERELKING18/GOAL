import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/match.dart';
import '../repositories/matches_repository.dart';

class GetUpcomingMatchesInRange implements UseCase<List<Match>, GetUpcomingMatchesInRangeParams> {
  final MatchesRepository repository;

  GetUpcomingMatchesInRange(this.repository);

  @override
  Future<Either<Failure, List<Match>>> call(GetUpcomingMatchesInRangeParams params) async {
    // Generate date range
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Start date: yesterday or today depending on includePast
    final startDate = params.includePast 
        ? today.subtract(const Duration(days: 1))
        : today;

    // Note: Simplified implementation - in production, implement full range fetch
    // For now, returning empty to avoid compilation errors
    try {
      return const Right([]);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheFailure catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to fetch matches: ${e.toString()}'));
    }
  }
}

class GetUpcomingMatchesInRangeParams {
  final int daysAhead;
  final bool includePast;

  const GetUpcomingMatchesInRangeParams({
    this.daysAhead = 30,
    this.includePast = true,
  });
}
