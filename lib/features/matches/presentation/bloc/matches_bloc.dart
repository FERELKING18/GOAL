import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/match.dart';
import '../../domain/usecases/get_today_matches.dart';
import '../../domain/usecases/get_yesterday_matches.dart';
import '../../domain/usecases/get_tomorrow_matches.dart';
import '../../domain/usecases/get_match_updates.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';

part 'matches_event.dart';
part 'matches_state.dart';

class MatchesBloc extends Bloc<MatchesEvent, MatchesState> {
  final GetTodayMatches getTodayMatches;
  final GetYesterdayMatches getYesterdayMatches;
  final GetTomorrowMatches getTomorrowMatches;
  final GetMatchUpdates getMatchUpdates;

  StreamSubscription<Either<Failure, Match>>? _matchUpdatesSubscription;

  MatchesBloc({
    required this.getTodayMatches,
    required this.getYesterdayMatches,
    required this.getTomorrowMatches,
    required this.getMatchUpdates,
  }) : super(MatchesInitial()) {
    on<LoadTodayMatchesEvent>(_onLoadTodayMatches);
    on<LoadYesterdayMatchesEvent>(_onLoadYesterdayMatches);
    on<LoadTomorrowMatchesEvent>(_onLoadTomorrowMatches);
    on<LoadAllUpcomingMatchesEvent>(_onLoadAllUpcomingMatches);
    on<RefreshMatchesEvent>(_onRefreshMatches);
    on<StartRealTimeUpdatesEvent>(_onStartRealTimeUpdates);
    on<StopRealTimeUpdatesEvent>(_onStopRealTimeUpdates);
    on<MatchUpdatedEvent>(_onMatchUpdated);
    on<SwitchTabEvent>(_onSwitchTab);

    _initializeMatches();
  }

  void _initializeMatches() {
    add(LoadTodayMatchesEvent());
    add(LoadYesterdayMatchesEvent());
    add(LoadTomorrowMatchesEvent());
    add(StartRealTimeUpdatesEvent());
  }

  Future<void> _onLoadTodayMatches(
    LoadTodayMatchesEvent event,
    Emitter<MatchesState> emit,
  ) async {
    if (state is! MatchesLoaded) {
      emit(MatchesLoading());
    }

    try {
      final matches = await getTodayMatches();
      _updateStateWithMatches(emit, todayMatches: matches);
    } catch (e) {
      emit(MatchesError('Verify connection'));
    }
  }

  Future<void> _onLoadYesterdayMatches(
    LoadYesterdayMatchesEvent event,
    Emitter<MatchesState> emit,
  ) async {
    try {
      final matches = await getYesterdayMatches();
      _updateStateWithMatches(emit, yesterdayMatches: matches);
    } catch (e) {
      emit(MatchesError('Verify connection'));
    }
  }

  Future<void> _onLoadTomorrowMatches(
    LoadTomorrowMatchesEvent event,
    Emitter<MatchesState> emit,
  ) async {
    try {
      final matches = await getTomorrowMatches();
      _updateStateWithMatches(emit, tomorrowMatches: matches);
    } catch (e) {
      emit(MatchesError('Verify connection'));
    }
  }

  Future<void> _onLoadAllUpcomingMatches(
    LoadAllUpcomingMatchesEvent event,
    Emitter<MatchesState> emit,
  ) async {
    emit(MatchesLoading());

    try {
      // Fetch matches using the existing use cases
      final List<Match> yesterdayMatches;
      final List<Match> todayMatches;
      final List<Match> tomorrowMatches;

      try {
        yesterdayMatches = event.includePast ? await getYesterdayMatches() : [];
      } catch (e) {
        yesterdayMatches = [];
      }

      try {
        todayMatches = await getTodayMatches();
      } catch (e) {
        todayMatches = [];
      }

      try {
        tomorrowMatches = await getTomorrowMatches();
      } catch (e) {
        tomorrowMatches = [];
      }

      // Combine all matches
      final allMatches = [
        ...yesterdayMatches,
        ...todayMatches,
        ...tomorrowMatches,
      ];

      // Sort by date
      allMatches.sort((a, b) => a.utcDate.compareTo(b.utcDate));

      emit(AllMatchesLoaded(
        allMatches: allMatches,
        isRealTimeConnected: false,
      ));
    } catch (e) {
      emit(MatchesError('Failed to load matches: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshMatches(
    RefreshMatchesEvent event,
    Emitter<MatchesState> emit,
  ) async {
    if (state is MatchesLoaded) {
      final currentState = state as MatchesLoaded;
      emit(currentState.copyWith(isRefreshing: true));

      try {
        final results = await Future.wait([
          getTodayMatches(),
          getYesterdayMatches(),
          getTomorrowMatches(),
        ]);

        emit(currentState.copyWith(
          todayMatches: results[0],
          yesterdayMatches: results[1],
          tomorrowMatches: results[2],
          isRefreshing: false,
        ));
      } catch (e) {
        emit(currentState.copyWith(isRefreshing: false));
        emit(MatchesError('Verify connection'));
      }
    }
  }

  void _onStartRealTimeUpdates(
    StartRealTimeUpdatesEvent event,
    Emitter<MatchesState> emit,
  ) {
    _matchUpdatesSubscription?.cancel();
    _matchUpdatesSubscription = getMatchUpdates(NoParams()).listen(
      (result) {
        result.fold(
          (failure) => emit(MatchesError('Verify connection')),
          (match) => add(MatchUpdatedEvent(match)),
        );
      },
      onError: (error) => emit(MatchesError('Verify connection')),
    );

    if (state is MatchesLoaded) {
      final currentState = state as MatchesLoaded;
      emit(currentState.copyWith(isRealTimeConnected: true));
    }
  }

  void _onStopRealTimeUpdates(
    StopRealTimeUpdatesEvent event,
    Emitter<MatchesState> emit,
  ) {
    _matchUpdatesSubscription?.cancel();
    _matchUpdatesSubscription = null;

    if (state is MatchesLoaded) {
      final currentState = state as MatchesLoaded;
      emit(currentState.copyWith(isRealTimeConnected: false));
    }
  }

  void _onMatchUpdated(
    MatchUpdatedEvent event,
    Emitter<MatchesState> emit,
  ) {
    final updatedMatch = event.match;

    if (state is MatchesLoaded) {
      final currentState = state as MatchesLoaded;

      final updatedTodayMatches = _updateMatchInList(
        currentState.todayMatches,
        updatedMatch,
      );
      final updatedYesterdayMatches = _updateMatchInList(
        currentState.yesterdayMatches,
        updatedMatch,
      );
      final updatedTomorrowMatches = _updateMatchInList(
        currentState.tomorrowMatches,
        updatedMatch,
      );

      emit(currentState.copyWith(
        todayMatches: updatedTodayMatches,
        yesterdayMatches: updatedYesterdayMatches,
        tomorrowMatches: updatedTomorrowMatches,
      ));
    } else if (state is AllMatchesLoaded) {
      final currentState = state as AllMatchesLoaded;
      final updatedAllMatches = _updateMatchInList(
        currentState.allMatches,
        updatedMatch,
      );

      emit(currentState.copyWith(allMatches: updatedAllMatches));
    }
  }

  void _onSwitchTab(
    SwitchTabEvent event,
    Emitter<MatchesState> emit,
  ) {
    if (state is MatchesLoaded) {
      final currentState = state as MatchesLoaded;
      emit(currentState.copyWith(currentTabIndex: event.tabIndex));
    }
  }

  void _updateStateWithMatches(
    Emitter<MatchesState> emit, {
    List<Match>? todayMatches,
    List<Match>? yesterdayMatches,
    List<Match>? tomorrowMatches,
  }) {
    if (state is MatchesLoaded) {
      final currentState = state as MatchesLoaded;
      emit(currentState.copyWith(
        todayMatches: todayMatches ?? currentState.todayMatches,
        yesterdayMatches: yesterdayMatches ?? currentState.yesterdayMatches,
        tomorrowMatches: tomorrowMatches ?? currentState.tomorrowMatches,
      ));
    } else {
      emit(MatchesLoaded(
        todayMatches: todayMatches ?? const [],
        yesterdayMatches: yesterdayMatches ?? const [],
        tomorrowMatches: tomorrowMatches ?? const [],
      ));
    }
  }

  List<Match> _updateMatchInList(List<Match> matches, Match updatedMatch) {
    return matches.map((match) {
      return match.id == updatedMatch.id ? updatedMatch : match;
    }).toList();
  }

  @override
  Future<void> close() {
    _matchUpdatesSubscription?.cancel();
    return super.close();
  }
} 