import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  LocalNotificationService();

  final localNotificationService = FlutterLocalNotificationsPlugin();


  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('ic_launcher');
    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings settings = InitializationSettings(
        iOS: iosInitializationSettings, android: androidInitializationSettings);
    await localNotificationService.initialize(settings,
        onSelectNotification: onSelectedNotification);
  }

  Future<NotificationDetails> notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel Id', 'channel Name',
            channelDescription: 'description',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);
    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails();

    return const NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    final details = await notificationDetails();
    await localNotificationService.show(id, title, body, details,payload: payload);
  }


  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('ID onDidReceiveNotification $id');
  }

  void onSelectedNotification(String? payload) {
    print('Payload $payload');
  }
}
