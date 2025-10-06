import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale _currentLocale = const Locale('ar', 'SA');
  bool _isArabic = true;

  Locale get currentLocale => _currentLocale;
  bool get isArabic => _isArabic;

  void toggleLanguage() {
    _isArabic = !_isArabic;
    _currentLocale = _isArabic 
        ? const Locale('ar', 'SA') 
        : const Locale('en', 'US');
    notifyListeners();
  }

  // Company Information
  String get companyName => _isArabic 
      ? 'شركة قوة البنية العربية للمقاولات' 
      : 'Power Construction Arabia Contracting Company';

  String get companyFounded => _isArabic 
      ? 'تأسست عام ٢٠١٩' 
      : 'Founded in 2019';

  String get companyCR => 'C.R. 1010967878';

  // Navigation
  String get aboutUs => _isArabic ? 'من نحن' : 'About Us';
  String get services => _isArabic ? 'خدماتنا' : 'Our Services';
  String get projects => _isArabic ? 'مشاريعنا' : 'Our Projects';
  String get contact => _isArabic ? 'اتصل بنا' : 'Contact Us';
  String get readMore => _isArabic ? 'اقرأ المزيد' : 'Read More';
  String get vision => _isArabic ? 'رؤيتنا' : 'Our Vision';
  String get mission => _isArabic ? 'رسالتنا' : 'Our Mission';
  String get values => _isArabic ? 'قيمنا' : 'Our Values';

  // Statistics
  String get experienceYears => _isArabic ? 'سنوات الخبرة' : 'Years of Experience';
  String get clientsCount => _isArabic ? 'عملائنا' : 'Our Clients';
  String get projectsValue => _isArabic ? 'قيمة مشاريعنا' : 'Projects Value';
  String get projectsCount => _isArabic ? 'المشاريع' : 'Projects';

  // Contact Information
  Map<String, String> get contactInfo => {
    'address': _isArabic ? 'الرياض، طريق الإمام سعود، التعاون' : 'K.S.A - Riyadh, Al Taawun, Imam Saud Road',
    'phone': '+966 53 239 2878',
    'email': 'info@powercac.com',
    'working_hours': _isArabic ? 'الأحد - الخميس: ٨ صباحاً - ٥ مساءً' : 'Sun - Thu: 8:00 AM - 5:00 PM',
  };
}