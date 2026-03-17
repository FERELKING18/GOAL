import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import '../../../../core/errors/failure.dart';
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

    // End date: daysAhead from today
    final endDate = today.add(Duration(days: params.daysAhead));

    // Fetch all matches in the range
    final matches = <Match>[];

    try {
      // Get matches for the date range
      for (int i = 0; i <= params.daysAhead + (params.includePast ? 1 : 0); i++) {
        final date = params.includePast 
            ? startDate.add(Duration(days: i))
            : today.add(Duration(days: i - 1));

        final dateString = DateFormat('yyyy-MM-dd').format(date);

        // You might need to implement a method in repository that fetches by date
        // For now, we'll assume getMatchesByDate exists
        try {
          // This would be a new method in the repository
          // final result = await repository.getMatchesByDate(dateString);
          // matches.addAll(result);
        } catch (e) {
          // Continue if a day has no matches
          continue;
        }
      }

      // Sort matches by date
      matches.sort((a, b) => a.utcDate.compareTo(b.utcDate));

      return Right(matches);
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
