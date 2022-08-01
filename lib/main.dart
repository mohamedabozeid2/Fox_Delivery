import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/locale/locale.dart';
import 'package:fox_delivery/locale/localeController.dart';
import 'package:fox_delivery/modules/FirstScreen/FirstScreen.dart';
import 'package:fox_delivery/modules/HomeScreen/HomeScreen.dart';
import 'package:fox_delivery/modules/LoginScreen/LoginScreen.dart';
import 'package:fox_delivery/modules/SettingsScreen/SettingsScreen.dart';
import 'package:fox_delivery/shared/BlocObserver/BlocObserver.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/shared/network/local/CacheHelper.dart';
import 'package:fox_delivery/styles/Themes.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'modules/BoardingScreen/BoardingScreen.dart';

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


  Widget startWidget;

  if(CacheHelper.getData(key: 'onBoarding') == null){
    onBoarding = false;
  }else{
    onBoarding = true;
  }

  if(onBoarding == true){
    if(uId != null){
      startWidget = HomeScreen();
    }else{
      startWidget = LoginScreen();
    }
  }else{
    startWidget = BoardingScreen();
  }
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(startWidget: startWidget,));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {

  Widget startWidget;
  MyApp({
    required this.startWidget
});

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
            home: startWidget,
          );
        },
      ),
    );
  }
}
