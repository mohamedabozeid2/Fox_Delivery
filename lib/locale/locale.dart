import 'package:get/get.dart';

class MyLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': {
          'language': 'اللغة',
          'ar': 'العربية',
          'en': 'الانجليزية',
          'welcome': 'مرحبا',
          'settings': 'الاعدادات',
          'login': 'تسحيل الدخول',
          'register': 'انشاء حساب',
          'phone number': 'رقم الهاتف',
          'password': 'كلمة السر',
          'forgot_password': 'هل نسيت كلمة السر؟',
          'location': 'العنوان',
          'email': 'البريد الالكتروني',
          'email_validator': 'من فضلك ادخل البريد الالكتروني',
          'password_validator': 'من فضلك ادخل كلمة السر',
        },
        'en': {
          'language': 'Language',
          'ar': 'Arabic',
          'en': 'English',
          'welcome': 'Welcome',
          'settings': 'Settings',
          'login': 'Login',
          'register': 'Register',
          'phone number': 'Phone number',
          'password': 'Password',
          'forgot_password': 'Forgot your password?',
          'location': 'Address',
          'email': 'Email address',
          'email_validator': 'Please enter your email address',
          'password_validator': 'Please enter your password',
        }
      };
}
