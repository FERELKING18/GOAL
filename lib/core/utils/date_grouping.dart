import 'package:intl/intl.dart';

enum DateGroup {
  yesterday,
  today,
  tomorrow,
  thisWeek, // Next 4 days (3-7 days from today)
  nextWeek, // Following week (8-14 days from today)
  thisMonth, // Rest of the month (15+ days from today)
}

class DateGroupingUtils {
  static final _dateFormat = DateFormat('yyyy-MM-dd');

  /// Get the group for a given date
  static DateGroup getDateGroup(DateTime matchDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final matchDateOnly = DateTime(matchDate.year, matchDate.month, matchDate.day);

    final difference = matchDateOnly.difference(today).inDays;

    if (difference == -1) {
      return DateGroup.yesterday;
    } else if (difference == 0) {
      return DateGroup.today;
    } else if (difference == 1) {
      return DateGroup.tomorrow;
    } else if (difference > 1 && difference <= 6) {
      return DateGroup.thisWeek;
    } else if (difference > 6 && difference <= 13) {
      return DateGroup.nextWeek;
    } else {
      return DateGroup.thisMonth; // Or in the future
    }
  }

  /// Get display label for a date group
  static String getGroupLabel(DateGroup group) {
    switch (group) {
      case DateGroup.yesterday:
        return 'Yesterday';
      case DateGroup.today:
        return 'Today';
      case DateGroup.tomorrow:
        return 'Tomorrow';
      case DateGroup.thisWeek:
        return 'This Week';
      case DateGroup.nextWeek:
        return 'Next Week';
      case DateGroup.thisMonth:
        return 'Later';
    }
  }

  /// Sort order for date groups (for consistent ordering)
  static int getGroupOrder(DateGroup group) {
    switch (group) {
      case DateGroup.yesterday:
        return 0;
      case DateGroup.today:
        return 1;
      case DateGroup.tomorrow:
        return 2;
      case DateGroup.thisWeek:
        return 3;
      case DateGroup.nextWeek:
        return 4;
      case DateGroup.thisMonth:
        return 5;
    }
  }

  /// Group matches by intelligent date groups
  static Map<DateGroup, List<T>> groupMatchesByDate<T>(
    List<T> matches,
    DateTime Function(T) getDateTime,
  ) {
    final grouped = <DateGroup, List<T>>{};

    for (final match in matches) {
      final date = getDateTime(match);
      final group = getDateGroup(date);

      grouped.putIfAbsent(group, () => []).add(match);
    }

    return grouped;
  }

  /// Get sorted date group entries
  static List<MapEntry<DateGroup, List<T>>> getSortedGroupedMatches<T>(
    Map<DateGroup, List<T>> grouped,
  ) {
    final entries = grouped.entries.toList();
    entries.sort((a, b) =>
        getGroupOrder(a.key).compareTo(getGroupOrder(b.key)));
    return entries;
  }

  /// Format date for display (e.g., "Mon, 17 Mar")
  static String formatMatchDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final matchDateOnly = DateTime(date.year, date.month, date.day);

    final difference = matchDateOnly.difference(today).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference == -1) {
      return 'Yesterday';
    }

    // Format as "Mon, 17 Mar"
    return DateFormat('EEE, d MMM').format(date);
  }

  /// Get all date groups with their labels
  static List<(DateGroup, String)> getAllDateGroups() {
    return [
      (DateGroup.yesterday, getGroupLabel(DateGroup.yesterday)),
      (DateGroup.today, getGroupLabel(DateGroup.today)),
      (DateGroup.tomorrow, getGroupLabel(DateGroup.tomorrow)),
      (DateGroup.thisWeek, getGroupLabel(DateGroup.thisWeek)),
      (DateGroup.nextWeek, getGroupLabel(DateGroup.nextWeek)),
      (DateGroup.thisMonth, getGroupLabel(DateGroup.thisMonth)),
    ];
  }
}
