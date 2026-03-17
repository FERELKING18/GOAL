part of 'matches_bloc.dart';

abstract class MatchesEvent {
  const MatchesEvent();
}

class LoadTodayMatchesEvent extends MatchesEvent {}

class LoadYesterdayMatchesEvent extends MatchesEvent {}

class LoadTomorrowMatchesEvent extends MatchesEvent {}

class LoadAllUpcomingMatchesEvent extends MatchesEvent {
  /// Days to look ahead (default 30 days)
  final int daysAhead;
  final bool includePast;

  const LoadAllUpcomingMatchesEvent({
    this.daysAhead = 30,
    this.includePast = true,
  });
}

class RefreshMatchesEvent extends MatchesEvent {}

class StartRealTimeUpdatesEvent extends MatchesEvent {}

class StopRealTimeUpdatesEvent extends MatchesEvent {}

class MatchUpdatedEvent extends MatchesEvent {
  final Match match;

  const MatchUpdatedEvent(this.match);
}

class SwitchTabEvent extends MatchesEvent {
  final int tabIndex;

  const SwitchTabEvent(this.tabIndex);
} 