import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        importance: Importance.max,
      ),
    );
  }

  //scheduled notification
  static Future scheduleNotification({
    int id = 0,
    //id from firestore db
    String? notificationId,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async {
    print('Scheduling notification for $scheduledDate');
    final location = tz.getLocation('Asia/Manila');
    final scheduledDateTime = tz.TZDateTime.from(scheduledDate, location);
    final notificationDetails = await _notificationDetails();
    await _notifications.zonedSchedule(
      id,
      title,
      body,
      scheduledDateTime,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  //reminder daily notification
  static Future reminderNotification({
    int id = 0,
    //id from firestore db
    String? notificationId,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async {
    print('Scheduling daily notification for $scheduledDate');
    final location = tz.getLocation('Asia/Manila');
    final scheduledDateTime = tz.TZDateTime.from(scheduledDate, location);
    final notificationDetails = await _notificationDetails();
    await _notifications.zonedSchedule(
      id,
      title,
      body,
      scheduledDateTime,
      notificationDetails,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  //get list of notif
  static Future<List<PendingNotificationRequest>> getAllScheduledNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }

  // Print all scheduled notifications
  static void printAllScheduledNotifications() async {
    final pendingNotifications = await getAllScheduledNotifications();
      print('Number of Pending Notifications: ${pendingNotifications.length}');
  for (PendingNotificationRequest pendingNotification in pendingNotifications) {
    print('Notification ID: ${pendingNotification.id}');
    print('Title: ${pendingNotification.title}');
    print('Body: ${pendingNotification.body}');
    print('Payload: ${pendingNotification.payload}');
  }

  }
}