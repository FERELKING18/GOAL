// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'مباريات كرة القدم';

  @override
  String get home => 'الرئيسية';

  @override
  String get noItemsFound => 'لا توجد عناصر';

  @override
  String get error => 'خطأ';

  @override
  String get retry => 'أعد المحاولة';

  @override
  String get loading => 'جارٍ التحميل...';

  @override
  String get cancel => 'إلغاء';

  @override
  String get ok => 'موافق';

  @override
  String get save => 'حفظ';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get add => 'إضافة';

  @override
  String get active => 'نشط';

  @override
  String get inactive => 'غير نشط';

  @override
  String get justNow => 'الآن';

  @override
  String minutesAgo(int count) {
    return 'منذ $count دقائق';
  }

  @override
  String hoursAgo(int count) {
    return 'منذ $count ساعات';
  }

  @override
  String daysAgo(int count) {
    return 'منذ $count أيام';
  }

  @override
  String get emailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';

  @override
  String get invalidEmail => 'يرجى إدخال بريد إلكتروني صالح';

  @override
  String get passwordTooShort => 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';

  @override
  String fieldRequired(String fieldName) {
    return '$fieldName مطلوب';
  }

  @override
  String get refreshList => 'تحديث القائمة';

  @override
  String get addItem => 'إضافة عنصر جديد';

  @override
  String get networkError => 'لا يوجد اتصال بالإنترنت';

  @override
  String get serverError => 'حدث خطأ في الخادم';

  @override
  String get unexpectedError => 'حدث خطأ غير متوقع';

  @override
  String get refresh => 'تحديث';

  @override
  String get yesterday => 'أمس';

  @override
  String get today => 'اليوم';

  @override
  String get tomorrow => 'غداً';

  @override
  String get dayAfterTomorrow => 'بعد غداً';

  @override
  String get dayBeforeYesterday => 'أول أمس';

  @override
  String daysInFuture(int count) {
    return 'بعد $count أيام';
  }

  @override
  String daysInPast(int count) {
    return 'منذ $count أيام';
  }

  @override
  String get noMatches => 'لا توجد مباريات متاحة';

  @override
  String get errorOccurred => 'حدث خطأ ما';

  @override
  String get matches => 'المباريات';

  @override
  String get liveMatches => 'المباريات المباشرة';

  @override
  String get upcomingMatches => 'المباريات القادمة';

  @override
  String get pastMatches => 'المباريات السابقة';

  @override
  String get liveUpdates => 'التحديثات المباشرة';

  @override
  String get offline => 'غير متصل';

  @override
  String get venue => 'الملعب';

  @override
  String get matchWeek => 'جولة المباراة';

  @override
  String get fullTime => 'الوقت الكامل';

  @override
  String get halftimeScore => 'الشوط الأول';

  @override
  String get penalties => 'ركلات الترجيح';

  @override
  String get extraTime => 'الوقت الإضافي';

  @override
  String get postponed => 'مؤجلة';

  @override
  String get cancelled => 'ملغية';

  @override
  String get scheduled => 'مجدولة';

  @override
  String get kickoff => 'انطلاق المباراة';

  @override
  String get minute => 'دقيقة';

  @override
  String get live => 'LIVE';

  @override
  String get versus => 'ضـد';

  @override
  String get matchStatusAbnormal => 'خطأ';

  @override
  String get matchStatusNotStarted => 'لم تبدأ';

  @override
  String get matchStatusFirstHalf => 'الشوط الأول';

  @override
  String matchStatusFirstHalfWithMinute(int minute) {
    return 'الشوط الأول $minute\'';
  }

  @override
  String get matchStatusHalfTime => 'فترة الراحة';

  @override
  String get matchStatusSecondHalf => 'الشوط الثاني';

  @override
  String matchStatusSecondHalfWithMinute(int minute) {
    return 'الشوط الثاني $minute\'';
  }

  @override
  String get matchStatusOvertime => 'الوقت الإضافي';

  @override
  String matchStatusOvertimeWithMinute(int minute) {
    return 'وإ $minute\'';
  }

  @override
  String get matchStatusPenaltyShootout => 'ضربات ترجيح';

  @override
  String get matchStatusFinished => 'انتهت';

  @override
  String get matchStatusDelayed => 'مؤجلة';

  @override
  String get matchStatusInterrupted => 'متوقفة';

  @override
  String get matchStatusCutInHalf => 'مُلغاة';

  @override
  String get matchStatusCancelled => 'ملغية';

  @override
  String get matchStatusToBeDetermined => 'لم تحدد بعد';
}
