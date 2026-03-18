import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/date_grouping.dart';

class GroupedMatchesList<T> extends StatelessWidget {
  final List<T> matches;
  final DateTime Function(T) getDateTime;
  final Widget Function(T, int) matchItemBuilder;
  final Widget Function(DateGroup, String)? sectionHeaderBuilder;
  final ScrollController? scrollController;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;

  const GroupedMatchesList({
    super.key,
    required this.matches,
    required this.getDateTime,
    required this.matchItemBuilder,
    this.sectionHeaderBuilder,
    this.scrollController,
    this.shrinkWrap = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    // Group matches by intelligent date groups
    final grouped = DateGroupingUtils.groupMatchesByDate<T>(
      matches,
      getDateTime,
    );

    if (grouped.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            'No matches found',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    }

    // Get sorted group entries
    final sortedGroups = DateGroupingUtils.getSortedGroupedMatches(grouped);

    return ListView.builder(
      controller: scrollController,
      shrinkWrap: shrinkWrap,
      padding: padding ?? const EdgeInsets.only(bottom: 20),
      itemCount: sortedGroups.length * 2, // Groups + items
      itemBuilder: (context, index) {
        final groupIndex = index ~/ 2;
        final isHeader = index % 2 == 0;

        if (groupIndex >= sortedGroups.length) {
          return const SizedBox.shrink();
        }

        final group = sortedGroups[groupIndex].key;
        final matchesInGroup = sortedGroups[groupIndex].value;

        if (isHeader) {
          final label = DateGroupingUtils.getGroupLabel(group);
          return sectionHeaderBuilder?.call(group, label) ??
              _defaultSectionHeader(context, group, label);
        }

        return _buildGroupContent(context, matchesInGroup);
      },
    );
  }

  Widget _defaultSectionHeader(BuildContext context, DateGroup group, String label) {
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
        ],
      ),
    ).animate().slideX(begin: -0.2, duration: 300.ms).fadeIn();
  }

  Widget _buildGroupContent(BuildContext context, List<T> matchesInGroup) {
    return Column(
      children: List.generate(
        matchesInGroup.length,
        (index) => matchItemBuilder(matchesInGroup[index], index),
      ),
    );
  }

  Widget _getGroupIcon(DateGroup group) {
    switch (group) {
      case DateGroup.yesterday:
        return const Icon(Icons.history, size: 20);
      case DateGroup.today:
        return const Icon(Icons.today, size: 20);
      case DateGroup.tomorrow:
        return const Icon(Icons.calendar_today, size: 20);
      case DateGroup.thisWeek:
        return const Icon(Icons.calendar_month, size: 20);
      case DateGroup.nextWeek:
        return const Icon(Icons.date_range, size: 20);
      case DateGroup.thisMonth:
        return const Icon(Icons.event_available, size: 20);
    }
  }

  Color _getGroupColor(DateGroup group) {
    switch (group) {
      case DateGroup.yesterday:
        return Colors.grey;
      case DateGroup.today:
        return Colors.green;
      case DateGroup.tomorrow:
        return Colors.blue;
      case DateGroup.thisWeek:
        return Colors.orange;
      case DateGroup.nextWeek:
        return Colors.deepOrange;
      case DateGroup.thisMonth:
        return Colors.purple;
    }
  }
}
