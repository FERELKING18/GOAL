part of 'matches_bloc.dart';

abstract class MatchesState {
  const MatchesState();
}

class MatchesInitial extends MatchesState {}

class MatchesLoading extends MatchesState {}

class MatchesLoaded extends MatchesState {
  final List<Match> todayMatches;
  final List<Match> yesterdayMatches;
  final List<Match> tomorrowMatches;
  final int currentTabIndex;
  final bool isRefreshing;
  final bool isRealTimeConnected;

  const MatchesLoaded({
    required this.todayMatches,
    required this.yesterdayMatches,
    required this.tomorrowMatches,
    this.currentTabIndex = 0,
    this.isRefreshing = false,
    this.isRealTimeConnected = false,
  });

  MatchesLoaded copyWith({
    List<Match>? todayMatches,
    List<Match>? yesterdayMatches,
    List<Match>? tomorrowMatches,
    int? currentTabIndex,
    bool? isRefreshing,
    bool? isRealTimeConnected,
  }) {
    return MatchesLoaded(
      todayMatches: todayMatches ?? this.todayMatches,
      yesterdayMatches: yesterdayMatches ?? this.yesterdayMatches,
      tomorrowMatches: tomorrowMatches ?? this.tomorrowMatches,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isRealTimeConnected: isRealTimeConnected ?? this.isRealTimeConnected,
    );
  }

  List<Match> get currentMatches {
    switch (currentTabIndex) {
      case 0:
        return yesterdayMatches;
      case 1:
        return todayMatches;
      case 2:
        return tomorrowMatches;
      default:
        return todayMatches;
    }
  }
}

class AllMatchesLoaded extends MatchesState {
  final List<Match> allMatches; // All matches grouped intelligently
  final bool isRefreshing;
  final bool isRealTimeConnected;

  const AllMatchesLoaded({
    required this.allMatches,
    this.isRefreshing = false,
    this.isRealTimeConnected = false,
  });

  AllMatchesLoaded copyWith({
    List<Match>? allMatches,
    bool? isRefreshing,
    bool? isRealTimeConnected,
  }) {
    return AllMatchesLoaded(
      allMatches: allMatches ?? this.allMatches,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isRealTimeConnected: isRealTimeConnected ?? this.isRealTimeConnected,
    );
  }
}

class MatchesError extends MatchesState {
  final String message;

  const MatchesError(this.message);
} 