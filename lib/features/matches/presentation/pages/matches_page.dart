import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import '../bloc/matches_bloc.dart';
import '../widgets/match_card.dart';
import '../widgets/collapsible_competition_card.dart';
import '../../domain/entities/match.dart';
import '../../../../generated/l10n/app_localizations.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/websocket_status_indicator.dart';
import '../../../../core/services/websocket_service.dart';
import '../../../../core/di/injection_container.dart';


class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 1; // Start with "Today"
  bool _isRefreshing = false; // Track refresh loading state

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    
    // Load data for all tabs
    context.read<MatchesBloc>().add(LoadYesterdayMatchesEvent());
    context.read<MatchesBloc>().add(LoadTodayMatchesEvent());
    context.read<MatchesBloc>().add(LoadTomorrowMatchesEvent());
    context.read<MatchesBloc>().add(StartRealTimeUpdatesEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF2E3236).withValues(alpha: 1), // Custom dark background
      body: Stack(
        children: [
          _buildBackgroundShapes(),
          
                      SafeArea(
                      child: Column(
                        children: [
                _buildHeader(context, l10n),
                _buildTabBar(context, l10n, theme),
                
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                                children: [
                      _buildMatchesTab(context, 'yesterday'),
                      _buildMatchesTab(context, 'today'),
                      _buildMatchesTab(context, 'tomorrow'),
                    ],
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
      child:  Positioned(
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
          ),  );
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

  Widget _buildTabBar(BuildContext context, AppLocalizations l10n, ThemeData theme) {
              return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
                  border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
      child: TabBar(
        controller: _tabController,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        indicator: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF86F14D), Color(0xFFE6FF48)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF86F14D).withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
                    ),
                  ],
                ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: AppColors.buttonText,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: AppTextStyles.tabLabel,
        unselectedLabelStyle: AppTextStyles.tabLabelInactive,
        tabs: [
          Tab(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(l10n.yesterday),
          ),
        ),
          Tab(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(l10n.today),
            ),
      ),
          Tab(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(l10n.tomorrow),
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: -0.3, duration: 500.ms).fadeIn();
  }

  Widget _buildMatchesTab(BuildContext context, String tabType) {
    return BlocBuilder<MatchesBloc, MatchesState>(
      builder: (context, state) {
        // Reset refreshing state when request completes (success or error)
        if (_isRefreshing && (state is MatchesLoaded || state is MatchesError)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                _isRefreshing = false;
              });
            }
          });
        }
        
        if (state is MatchesLoading) {
          return _buildLoadingState();
        } else if (state is MatchesError) {
          return _buildErrorState(context, state.message);
        } else if (state is MatchesLoaded) {
          List<Match> matches;
          switch (tabType) {
            case 'yesterday':
              matches = state.yesterdayMatches;
              break;
            case 'tomorrow':
              matches = state.tomorrowMatches;
        break;
            case 'today':
            default:
              matches = state.todayMatches;
        break;
          }
          
          // Filter out abnormal matches
          matches = matches.where((match) => !match.shouldHide).toList();
          
          if (matches.isEmpty) {
            return _buildEmptyState(context);
          }
          
          return _buildMatchesList(matches, tabType);
    }

        return _buildLoadingState();
      },
    );
  }

  Widget _buildMatchesList(List<Match> matches, String tabType) {
    final groupedMatches = <String, List<Match>>{};
    for (final match in matches) {
      final competition = match.competition?.name ?? match.league ?? 'Other';
      groupedMatches.putIfAbsent(competition, () => []).add(match);
    }
    
  
    
    return RefreshIndicator(
      onRefresh: () => _refreshCurrentTab(),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          // Live matches section (only for today)
          if (tabType == 'today') ..._buildLiveMatchesSection(matches),
          
          // Competition sections
          ...groupedMatches.entries.map((entry) => 
            CollapsibleCompetitionCard(
              competitionName: entry.key,
              matches: entry.value,
            )
          ),
          
          // Bottom padding
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  List<Widget> _buildLiveMatchesSection(List<Match> matches) {
    final liveMatches = matches.where((match) => match.isLive).toList();
    
    if (liveMatches.isEmpty) return [];
    
    return [
      Padding(
        padding: const EdgeInsets.fromLTRB(4, 16, 4, 12),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ).animate(onPlay: (controller) => controller.repeat())
              .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2), duration: 1000.ms)
              .then()
              .scale(begin: const Offset(1.2, 1.2), end: const Offset(0.8, 0.8), duration: 1000.ms),
            const SizedBox(width: 8),
            Text(
              AppLocalizations.of(context)!.liveMatches,
              style: AppTextStyles.headlineSmall.copyWith(
                color: AppColors.live,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${liveMatches.length}',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.live,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
          ],
        ),
      ).animate().slideX(begin: -0.3, duration: 400.ms).fadeIn(),
      
      Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red.withValues(alpha: 0.08),
              Colors.red.withValues(alpha: 0.03),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.red.withValues(alpha: 0.3),
            width: 1,
              ),
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         
            const SizedBox(height: 12),
            ...liveMatches.asMap().entries.map((entry) {
              final index = entry.key;
              final match = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: index < liveMatches.length - 1 ? 12 : 0),
                child: MatchCard(
                  match: match,
                ).animate(delay: (index * 100).ms)
                  .slideX(begin: 0.3, duration: 500.ms)
                  .fadeIn(),
              );
            }),
          ],
        ),
      ),
    ];
  }



  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF86F14D)),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading matches...',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildErrorState(BuildContext context, String message) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.white54,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.errorOccurred,
              style: AppTextStyles.headlineMedium,
              textAlign: TextAlign.center,
              ),
            const SizedBox(height: 8),
            Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _isRefreshing ? null : _refreshCurrentTab,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF86F14D),
                foregroundColor: const Color(0xFF2E3236),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              icon: _isRefreshing 
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E3236)),
              ),
                    )
                  : const Icon(Icons.refresh),
              label: Text(l10n.refresh),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1);
  }

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const Icon(
              Icons.sports_soccer_outlined,
              size: 64,
              color: Colors.white54,
              ),
            const SizedBox(height: 16),
              Text(
              l10n.noMatches,
              style: AppTextStyles.headlineMedium,
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 24),
              ElevatedButton.icon(
              onPressed: _isRefreshing ? null : _refreshCurrentTab,
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF86F14D),
                foregroundColor: const Color(0xFF2E3236),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
              icon: _isRefreshing 
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E3236)),
                  ),
                    )
                  : const Icon(Icons.refresh),
              label: Text(l10n.refresh),
              ),
            ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).scale(begin: const Offset(0.8, 0.8));
  }

  Future<void> _refreshCurrentTab() async {
    setState(() {
      _isRefreshing = true;
    });
    
    switch (_selectedIndex) {
      case 0:
        context.read<MatchesBloc>().add(LoadYesterdayMatchesEvent());
        break;
      case 1:
        context.read<MatchesBloc>().add(LoadTodayMatchesEvent());
        break;
      case 2:
        context.read<MatchesBloc>().add(LoadTomorrowMatchesEvent());
        break;
    }
  }

 
} 