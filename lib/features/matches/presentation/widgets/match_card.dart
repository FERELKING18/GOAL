import 'package:flutter/material.dart';
import '../../domain/entities/match.dart';
import '../../domain/entities/team.dart';
import '../../../../core/theme/theme_exports.dart';

class MatchCard extends StatelessWidget {
  final Match match;
  final VoidCallback? onTap;

  const MatchCard({
    super.key,
    required this.match,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [

              
              // Main match row
              Row(
                children: [
                  // Home team name (left side)
                  Expanded(
                    flex: 3,
                    child:                   Text(
                    match.homeTeam.name,
                    style: AppTextStyles.teamName,
                    textAlign: TextAlign.left,
                   softWrap: true,
                    overflow: TextOverflow.clip,
                  ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Home team shirt
                  _buildTeamShirt(match.homeTeam),
                  
                  const SizedBox(width: 16),
                  
                  // Time/Score (center)
                  SizedBox(
                    width: 60,
                    child: _buildCenterContent(),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Away team shirt
                  _buildTeamShirt(match.awayTeam),
                  
                  const SizedBox(width: 12),
                  
                  // Away team name (right side)
                  Expanded(
                    flex: 3,
                    child:                   Text(
                    match.awayTeam.name,
                    style: AppTextStyles.teamName,
                    textAlign: TextAlign.right,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                  ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamShirt(Team team) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: team.logo.isNotEmpty
            ? Image.network(
                team.shirt,
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildFallbackShirt(team);
                },
              )
            : _buildFallbackShirt(team),
      ),
    );
  }

  Widget _buildFallbackShirt(Team team) {
    // If shirt image fails or is empty, use team logo or fallback design
    if (team.logo.isNotEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: _getJerseyColor(team),
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Image.network(
              team.logo,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Text(
                  _getTeamAbbreviation(team.name),
                  style: AppTextStyles.overline.copyWith(
                    fontSize: 10,
                    letterSpacing: 0,
                  ),
                );
              },
            ),
          ),
        ),
      );
    } else {
      // Ultimate fallback - colored container with abbreviation
      return Container(
        decoration: BoxDecoration(
          color: _getJerseyColor(team),
        ),
        child: Center(
          child: Text(
            _getTeamAbbreviation(team.name),
            style: AppTextStyles.overline.copyWith(
              fontSize: 10,
              letterSpacing: 0,
            ),
          ),
        ),
      );
    }
  }

  Widget _buildCenterContent() {
    if (match.isFinished) {
      // Show final score
      return Text(
        '${match.homeScore} - ${match.awayScore}',
        style: AppTextStyles.matchScore,
        textAlign: TextAlign.center,
      );
    } else if (match.isLive) {
      // Show live score
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${match.homeScore} - ${match.awayScore}',
            style: AppTextStyles.matchScore,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'LIVE',
              style: AppTextStyles.liveIndicator,
            ),
          ),
        ],
      );
    } else {
      // Show match time
      return Text(
        _formatMatchTime(),
        style: AppTextStyles.matchTime,
        textAlign: TextAlign.center,
      );
    }
  }

  Color _getJerseyColor(Team team) {
    // Create different colors based on team name hash for variety
    final hash = team.name.hashCode;
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
      Colors.brown,
    ];
    
    return colors[hash.abs() % colors.length];
  }

  String _getTeamAbbreviation(String teamName) {
    // Create 2-3 letter abbreviations
    final words = teamName.split(' ');
    if (words.length >= 2) {
      return (words[0].substring(0, 1) + words[1].substring(0, 1)).toUpperCase();
    } else if (teamName.length >= 3) {
      return teamName.substring(0, 3).toUpperCase();
    } else {
      return teamName.toUpperCase();
    }
  }

  String _formatMatchTime() {
    final hour = match.matchDate.hour.toString().padLeft(2, '0');
    final minute = match.matchDate.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
} 