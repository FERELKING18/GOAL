import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Football Matches'**
  String get appTitle;

  /// Home screen title
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Message shown when there are no items to display
  ///
  /// In en, this message translates to:
  /// **'No items found'**
  String get noItemsFound;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Button text to retry an action
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get retry;

  /// Loading indicator text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// OK button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Edit button text
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Add button text
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// Active status
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// Inactive status
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// Time indicator for very recent activity
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// Time indicator for activity that happened minutes ago
  ///
  /// In en, this message translates to:
  /// **'{count} minutes ago'**
  String minutesAgo(int count);

  /// Time indicator for activity that happened hours ago
  ///
  /// In en, this message translates to:
  /// **'{count} hours ago'**
  String hoursAgo(int count);

  /// Time indicator for activity that happened days ago
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String daysAgo(int count);

  /// Validation message for required email field
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// Validation message for required password field
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// Validation message for invalid email format
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalidEmail;

  /// Validation message for password length
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long'**
  String get passwordTooShort;

  /// Generic validation message for required fields
  ///
  /// In en, this message translates to:
  /// **'{fieldName} is required'**
  String fieldRequired(String fieldName);

  /// Tooltip for refresh button
  ///
  /// In en, this message translates to:
  /// **'Refresh list'**
  String get refreshList;

  /// Tooltip for add button
  ///
  /// In en, this message translates to:
  /// **'Add new item'**
  String get addItem;

  /// Error message for network connectivity issues
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get networkError;

  /// Error message for server issues
  ///
  /// In en, this message translates to:
  /// **'Server error occurred'**
  String get serverError;

  /// Generic error message for unexpected errors
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get unexpectedError;

  /// Refresh button text
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// Yesterday tab label
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// Today tab label
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Tomorrow tab label
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// Day after tomorrow tab label
  ///
  /// In en, this message translates to:
  /// **'Day After Tomorrow'**
  String get dayAfterTomorrow;

  /// Day before yesterday tab label
  ///
  /// In en, this message translates to:
  /// **'Day Before Yesterday'**
  String get dayBeforeYesterday;

  /// Label for days in the future
  ///
  /// In en, this message translates to:
  /// **'{count} days ahead'**
  String daysInFuture(int count);

  /// Label for days in the past
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String daysInPast(int count);

  /// Message shown when there are no matches to display
  ///
  /// In en, this message translates to:
  /// **'No matches available'**
  String get noMatches;

  /// Generic error title
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorOccurred;

  /// Matches page title
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get matches;

  /// Live matches section title
  ///
  /// In en, this message translates to:
  /// **'Live Matches'**
  String get liveMatches;

  /// Upcoming matches section title
  ///
  /// In en, this message translates to:
  /// **'Upcoming Matches'**
  String get upcomingMatches;

  /// Past matches section title
  ///
  /// In en, this message translates to:
  /// **'Past Matches'**
  String get pastMatches;

  /// Live updates section title
  ///
  /// In en, this message translates to:
  /// **'Live Updates'**
  String get liveUpdates;

  /// Offline status
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// Venue field label
  ///
  /// In en, this message translates to:
  /// **'Venue'**
  String get venue;

  /// Match week field label
  ///
  /// In en, this message translates to:
  /// **'Match Week'**
  String get matchWeek;

  /// Full time field label
  ///
  /// In en, this message translates to:
  /// **'Full Time'**
  String get fullTime;

  /// Half time field label
  ///
  /// In en, this message translates to:
  /// **'Half Time'**
  String get halftimeScore;

  /// Penalties field label
  ///
  /// In en, this message translates to:
  /// **'Penalties'**
  String get penalties;

  /// Extra time field label
  ///
  /// In en, this message translates to:
  /// **'Extra Time'**
  String get extraTime;

  /// Postponed status
  ///
  /// In en, this message translates to:
  /// **'Postponed'**
  String get postponed;

  /// Cancelled status
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// Scheduled status
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduled;

  /// Kick-off field label
  ///
  /// In en, this message translates to:
  /// **'Kick-off'**
  String get kickoff;

  /// Minute field label
  ///
  /// In en, this message translates to:
  /// **'Minute'**
  String get minute;

  /// LIVE status
  ///
  /// In en, this message translates to:
  /// **'LIVE'**
  String get live;

  /// Versus field label
  ///
  /// In en, this message translates to:
  /// **'vs'**
  String get versus;

  /// Match status: Abnormal (suggest hiding)
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get matchStatusAbnormal;

  /// Match status: Not started
  ///
  /// In en, this message translates to:
  /// **'Not started'**
  String get matchStatusNotStarted;

  /// Match status: First half
  ///
  /// In en, this message translates to:
  /// **'1st Half'**
  String get matchStatusFirstHalf;

  /// Match status: First half with minute
  ///
  /// In en, this message translates to:
  /// **'1st Half {minute}\''**
  String matchStatusFirstHalfWithMinute(int minute);

  /// Match status: Half-time
  ///
  /// In en, this message translates to:
  /// **'Half-time'**
  String get matchStatusHalfTime;

  /// Match status: Second half
  ///
  /// In en, this message translates to:
  /// **'2nd Half'**
  String get matchStatusSecondHalf;

  /// Match status: Second half with minute
  ///
  /// In en, this message translates to:
  /// **'2nd Half {minute}\''**
  String matchStatusSecondHalfWithMinute(int minute);

  /// Match status: Overtime
  ///
  /// In en, this message translates to:
  /// **'Extra Time'**
  String get matchStatusOvertime;

  /// Match status: Overtime with minute
  ///
  /// In en, this message translates to:
  /// **'ET {minute}\''**
  String matchStatusOvertimeWithMinute(int minute);

  /// Match status: Penalty Shoot-out
  ///
  /// In en, this message translates to:
  /// **'Penalties'**
  String get matchStatusPenaltyShootout;

  /// Match status: Finished
  ///
  /// In en, this message translates to:
  /// **'Full Time'**
  String get matchStatusFinished;

  /// Match status: Delayed
  ///
  /// In en, this message translates to:
  /// **'Delayed'**
  String get matchStatusDelayed;

  /// Match status: Interrupted
  ///
  /// In en, this message translates to:
  /// **'Interrupted'**
  String get matchStatusInterrupted;

  /// Match status: Cut in half
  ///
  /// In en, this message translates to:
  /// **'Abandoned'**
  String get matchStatusCutInHalf;

  /// Match status: Cancelled
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get matchStatusCancelled;

  /// Match status: To be determined
  ///
  /// In en, this message translates to:
  /// **'To be determined'**
  String get matchStatusToBeDetermined;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
