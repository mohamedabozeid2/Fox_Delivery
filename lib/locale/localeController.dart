import 'package:flutter/cupertino.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/network/local/CacheHelper.dart';
import 'package:get/get.dart';

class MyLocaleController extends GetxController{

  Locale initialLanguage = CacheHelper.getData(key: 'language') == 'en'? const Locale('en') : const Locale('ar');


  void changeLanguage({required String language}){
    Locale locale = Locale(language);
    selectedLanguage = language;
    CacheHelper.saveData(key: 'language', value: language);
    Get.updateLocale(locale);
  }
}