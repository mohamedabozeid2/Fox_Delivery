import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/locale/locale.dart';
import 'package:fox_delivery/locale/localeController.dart';
import 'package:fox_delivery/modules/FirstScreen/FirstScreen.dart';
import 'package:fox_delivery/modules/SettingsScreen/SettingsScreen.dart';
import 'package:fox_delivery/shared/BlocObserver/BlocObserver.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/shared/network/local/CacheHelper.dart';
import 'package:fox_delivery/styles/Themes.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');



  if (CacheHelper.getData(key: 'language') == null) {
    CacheHelper.saveData(key: 'language', value: 'en');
  } else {
    CacheHelper.getData(key: 'language');
  }
  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(MyLocaleController());
    return BlocProvider(
      create: (BuildContext context) => FoxCubit(),
      child: BlocConsumer<FoxCubit, FoxStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            locale: Locale(selectedLanguage),
            translations: MyLocale(),
            title: 'Fox Delivery',
            themeMode: ThemeMode.light,
            theme: lightTheme,
            home: FirstScreen(),
          );
        },
      ),
    );
  }
}
