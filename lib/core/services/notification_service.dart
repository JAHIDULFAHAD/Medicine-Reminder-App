import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'dart:typed_data';

@lazySingleton
class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // Initialize notifications
  Future<void> initialize() async {
    tz.initializeTimeZones();
    final timezone = await FlutterTimezone.getLocalTimezone();

    try {
      tz.setLocalLocation(
        tz.getLocation(
          timezone.toString().replaceAll(RegExp(r'.*?\('), '').split(',')[0],
        ),
      );
    } catch (_) {
      tz.setLocalLocation(tz.getLocation('Asia/Dhaka'));
    }

    // Android initialization settings
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    // iOS initialization settings
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );
    // Combined initialization settings
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);
    // Initialize the plugin
    await _notificationsPlugin.initialize(settings: initializationSettings);

    // permission
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  // Show a simple notification
  Future<void> showNotification({
    int id = 0,
    String title = 'Notification',
    String body = 'This is a notification message',
  }) async {
    // Show the notification
    await _notificationsPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: _notificationDetails(),
    );
  }

  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final now = tz.TZDateTime.now(tz.local);

    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    await _notificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time, // daily repeat
    );
  }

  // Cancel a specific notification
  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id: id);
  }

  // Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  NotificationDetails _notificationDetails() {
    final AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'medicine_channel',
          'Medicine Reminder',
          channelDescription: 'Reminds you to take medicine',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
          playSound: true,
          enableVibration: true,
          enableLights: true,
          vibrationPattern: Int64List.fromList(const [
            0,
            800,
            300,
            800,
            300,
            800,
            300,
            800,
            300,
            800,
          ]),
        );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    return NotificationDetails(android: androidDetails, iOS: iosDetails);
  }

  Future<void> scheduleTestNotification() async {
    await cancelAllNotifications();

    final now = tz.TZDateTime.now(tz.local);
    final scheduled = now.add(const Duration(minutes: 1));

    await _notificationsPlugin.zonedSchedule(
      id: 222,
      title: 'Test Notification',
      body: 'This is a test notification',
      scheduledDate: scheduled,
      notificationDetails: _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: null,
    );
  }
}
