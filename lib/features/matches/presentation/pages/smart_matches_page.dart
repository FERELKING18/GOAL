import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import '../bloc/matches_bloc.dart';
import '../widgets/match_card.dart';
import '../widgets/grouped_matches_list.dart';
import '../../domain/entities/match.dart';
import '../../../../generated/l10n/app_localizations.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/websocket_status_indicator.dart';
import '../../../../core/services/websocket_service.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/date_grouping.dart';

class SmartMatchesPage extends StatefulWidget {
  const SmartMatchesPage({super.key});

  @override
  State<SmartMatchesPage> createState() => _SmartMatchesPageState();
}

class _SmartMatchesPageState extends State<SmartMatchesPage> {
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    // Load all upcoming matches intelligently
    context.read<MatchesBloc>().add(
      const LoadAllUpcomingMatchesEvent(
        daysAhead: 30,
        includePast: true,
      ),
    );
    context.read<MatchesBloc>().add(StartRealTimeUpdatesEvent());
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isRefreshing = true;
    });
    context.read<MatchesBloc>().add(RefreshMatchesEvent());
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFF2E3236),
      body: Stack(
        children: [
          _buildBackgroundShapes(),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context, l10n),
                Expanded(
                  child: BlocBuilder<MatchesBloc, MatchesState>(
                    builder: (context, state) {
                      if (state is MatchesLoading && state is! AllMatchesLoaded) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state is MatchesError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error_outline, size: 48),
                              const SizedBox(height: 16),
                              Text(state.message),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _onRefresh,
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      }

                      if (state is AllMatchesLoaded) {
                        return RefreshIndicator(
                          onRefresh: _onRefresh,
                          child: state.allMatches.isEmpty
                              ? _buildEmptyState()
                              : GroupedMatchesList<Match>(
                                  matches: state.allMatches,
                                  getDateTime: (match) => match.utcDate,
                                  matchItemBuilder: (match, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      child: MatchCard(match: match),
                                    ).animate().slideY(
                                      begin: 0.1,
                                      duration: (200 + index * 50).ms,
                                    ).fadeIn();
                                  },
                                  sectionHeaderBuilder: (group, label) {
                                    return _buildCustomSectionHeader(
                                      context,
                                      group,
                                      label,
                                    );
                                  },
                                  padding: const EdgeInsets.only(bottom: 20),
                                ),
                        );
                      }

                      return const Center(
                        child: Text('No data available'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundShapes() {
    return Positioned.fill(
      child: Positioned(
        bottom: 100,
        right: 0,
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                const Color(0xff86F14D),
                const Color(0xffE6FF48)
              ],
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            l10n.appTitle,
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          WebSocketStatusIndicator(
            webSocketService: sl<WebSocketService>(),
            showLabel: true,
          ),
        ],
      ),
    ).animate().slideY(begin: -0.5, duration: 400.ms).fadeIn();
  }

  Widget _buildCustomSectionHeader(
    BuildContext context,
    DateGroup group,
    String label,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Row(
        children: [
          _getGroupIcon(group),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: _getGroupColor(group),
            ),
          ),
          const Spacer(),
          // You can add match count here if needed
        ],
      ),
    ).animate().slideX(begin: -0.2, duration: 300.ms).fadeIn();
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sports_soccer,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No matches found',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Check back soon for updates',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getGroupIcon(DateGroup group) {
    switch (group) {
      case DateGroup.yesterday:
        return const Icon(Icons.history, size: 20);
      case DateGroup.today:
        return const Icon(Icons.today, size: 20, color: Colors.greenAccent);
      case DateGroup.tomorrow:
        return const Icon(Icons.calendar_today, size: 20, color: Colors.blueAccent);
      case DateGroup.thisWeek:
        return const Icon(Icons.calendar_month, size: 20, color: Colors.orangeAccent);
      case DateGroup.nextWeek:
        return const Icon(Icons.date_range, size: 20, color: Colors.deepOrangeAccent);
      case DateGroup.thisMonth:
        return const Icon(Icons.event_available, size: 20, color: Colors.purpleAccent);
    }
  }

  Color _getGroupColor(DateGroup group) {
    switch (group) {
      case DateGroup.yesterday:
        return Colors.grey;
      case DateGroup.today:
        return Colors.greenAccent;
      case DateGroup.tomorrow:
        return Colors.blueAccent;
      case DateGroup.thisWeek:
        return Colors.orangeAccent;
      case DateGroup.nextWeek:
        return Colors.deepOrangeAccent;
      case DateGroup.thisMonth:
        return Colors.purpleAccent;
    }
  }
}
