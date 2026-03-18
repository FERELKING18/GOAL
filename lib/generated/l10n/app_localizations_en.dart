// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Football Matches';

  @override
  String get home => 'Home';

  @override
  String get noItemsFound => 'No items found';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Try Again';

  @override
  String get loading => 'Loading...';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'OK';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get add => 'Add';

  @override
  String get active => 'Active';

  @override
  String get inactive => 'Inactive';

  @override
  String get justNow => 'Just now';

  @override
  String minutesAgo(int count) {
    return '$count minutes ago';
  }

  @override
  String hoursAgo(int count) {
    return '$count hours ago';
  }

  @override
  String daysAgo(int count) {
    return '$count days ago';
  }

  @override
  String get emailRequired => 'Email is required';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get invalidEmail => 'Please enter a valid email address';

  @override
  String get passwordTooShort => 'Password must be at least 8 characters long';

  @override
  String fieldRequired(String fieldName) {
    return '$fieldName is required';
  }

  @override
  String get refreshList => 'Refresh list';

  @override
  String get addItem => 'Add new item';

  @override
  String get networkError => 'No internet connection';

  @override
  String get serverError => 'Server error occurred';

  @override
  String get unexpectedError => 'An unexpected error occurred';

  @override
  String get refresh => 'Refresh';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get today => 'Today';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get dayAfterTomorrow => 'Day After Tomorrow';

  @override
  String get dayBeforeYesterday => 'Day Before Yesterday';

  @override
  String daysInFuture(int count) {
    return '$count days ahead';
  }

  @override
  String daysInPast(int count) {
    return '$count days ago';
  }

  @override
  String get noMatches => 'No matches available';

  @override
  String get errorOccurred => 'Something went wrong';

  @override
  String get matches => 'Matches';

  @override
  String get liveMatches => 'Live Matches';

  @override
  String get upcomingMatches => 'Upcoming Matches';

  @override
  String get pastMatches => 'Past Matches';

  @override
  String get liveUpdates => 'Live Updates';

  @override
  String get offline => 'Offline';

  @override
  String get venue => 'Venue';

  @override
  String get matchWeek => 'Match Week';

  @override
  String get fullTime => 'Full Time';

  @override
  String get halftimeScore => 'Half Time';

  @override
  String get penalties => 'Penalties';

  @override
  String get extraTime => 'Extra Time';

  @override
  String get postponed => 'Postponed';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get scheduled => 'Scheduled';

  @override
  String get kickoff => 'Kick-off';

  @override
  String get minute => 'Minute';

  @override
  String get live => 'LIVE';

  @override
  String get versus => 'vs';

  @override
  String get matchStatusAbnormal => 'Error';

  @override
  String get matchStatusNotStarted => 'Not started';

  @override
  String get matchStatusFirstHalf => '1st Half';

  @override
  String matchStatusFirstHalfWithMinute(int minute) {
    return '1st Half $minute\'';
  }

  @override
  String get matchStatusHalfTime => 'Half-time';

  @override
  String get matchStatusSecondHalf => '2nd Half';

  @override
  String matchStatusSecondHalfWithMinute(int minute) {
    return '2nd Half $minute\'';
  }

  @override
  String get matchStatusOvertime => 'Extra Time';

  @override
  String matchStatusOvertimeWithMinute(int minute) {
    return 'ET $minute\'';
  }

  @override
  String get matchStatusPenaltyShootout => 'Penalties';

  @override
  String get matchStatusFinished => 'Full Time';

  @override
  String get matchStatusDelayed => 'Delayed';

  @override
  String get matchStatusInterrupted => 'Interrupted';

  @override
  String get matchStatusCutInHalf => 'Abandoned';

  @override
  String get matchStatusCancelled => 'Cancelled';

  @override
  String get matchStatusToBeDetermined => 'To be determined';
}
