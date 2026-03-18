import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../domain/entities/match.dart';
import 'match_card.dart';
import '../../../../core/theme/theme_exports.dart';

class CollapsibleCompetitionCard extends StatefulWidget {
  final String competitionName;
  final List<Match> matches;

  const CollapsibleCompetitionCard({
    super.key,
    required this.competitionName,
    required this.matches,
  });

  @override
  State<CollapsibleCompetitionCard> createState() => _CollapsibleCompetitionCardState();
}

class _CollapsibleCompetitionCardState extends State<CollapsibleCompetitionCard> {
  bool _isExpanded = true; // Default to expanded

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2E3236),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Competition header (clickable)
          InkWell(
            onTap: _toggleExpansion,
            borderRadius: BorderRadius.vertical(
              top: const Radius.circular(16),
              bottom: _isExpanded ? Radius.zero : const Radius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF43484C),
                borderRadius: BorderRadius.vertical(
                  top: const Radius.circular(14),
                  bottom: _isExpanded ? Radius.zero : const Radius.circular(14),
                ),
              ),
              child: Row(
                children: [
                  // Competition flag/logo
                  _buildCompetitionLogo(),
                  const SizedBox(width: 12),
                  
                  // Competition name
                  Expanded(
                                      child: Text(
                    widget.competitionName,
                    style: AppTextStyles.competitionName,
                  ),
                  ),
                  
                  // Expand/collapse icon
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Matches list (collapsible)
          AnimatedCrossFade(
            firstChild: Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: const BoxDecoration(
                color: Color(0xFF2E3236),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(14),
                ),
              ),
              child: Column(
                children: widget.matches.asMap().entries.map((entry) {
                  final index = entry.key;
                  final match = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(bottom: index < widget.matches.length - 1 ? 12 : 0),
                    child: MatchCard(
                      match: match,
                    ).animate(delay: (index * 50).ms)
                      .slideX(begin: 0.2, duration: 400.ms)
                      .fadeIn(),
                  );
                }).toList(),
              ),
            ),
            secondChild: const SizedBox.shrink(),
            crossFadeState: _isExpanded 
                ? CrossFadeState.showFirst 
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    ).animate().slideY(begin: 0.1, duration: 400.ms).fadeIn();
  }

  Widget _buildCompetitionLogo() {
    // Try to get the competition logo from the first match
    final firstMatch = widget.matches.isNotEmpty ? widget.matches.first : null;
    final competition = firstMatch?.competition;
    
    if (competition != null && competition.logo.isNotEmpty) {
      return Container(
        width: 32,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
            competition.logo,
            width: 32,
            height: 24,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildFallbackLogo();
            },
          ),
        ),
      );
    }
    
    return _buildFallbackLogo();
  }

  Widget _buildFallbackLogo() {
    return Container(
      width: 32,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.yellow],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }
} 