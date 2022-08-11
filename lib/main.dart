import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fox_delivery/locale/locale.dart';
import 'package:fox_delivery/locale/localeController.dart';
import 'package:fox_delivery/modules/HomeScreen/HomeScreen.dart';
import 'package:fox_delivery/modules/LoginScreen/LoginScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fox_delivery/shared/BlocObserver/BlocObserver.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/shared/network/local/CacheHelper.dart';
import 'package:fox_delivery/shared/network/remote/Dio_Helper.dart';
import 'package:fox_delivery/styles/Themes.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'modules/BoardingScreen/BoardingScreen.dart';

////Notifications////////
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  showToast(
      msg: 'On Message Background',
      color: Colors.green,
      textColor: Colors.white);
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DioHelper.init();


  //Notifications
  /////////////////////////
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  deviceToken = await messaging.getToken();


  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

/////////////Notifications///

  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');

  if (CacheHelper.getData(key: 'language') == null) {
    CacheHelper.saveData(key: 'language', value: 'en');
  } else {
    CacheHelper.getData(key: 'language');
  }

  Widget startWidget;

  if (CacheHelper.getData(key: 'onBoarding') == null) {
    onBoarding = false;
  } else {
    onBoarding = true;
  }

  if (onBoarding == true) {
    if (uId != null) {
      startWidget = HomeScreen();
    } else {
      startWidget = LoginScreen();
    }
  } else {
    startWidget = BoardingScreen();
  }
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        startWidget: startWidget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  Widget startWidget;

  MyApp({required this.startWidget});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('Oppened');
    });

    //////Notifications//////
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              playSound: false,
              enableVibration: false,
              channel.name,
              channelDescription: channel.description,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
    super.initState();
  }

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
            home: widget.startWidget,
          );
        },
      ),
    );
  }
}
