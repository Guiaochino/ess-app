import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
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

  static Future testNotification({
    int id = 0,   // id is from the firestore document
    String? title,
    String? body,
    String? payload,
  }) async{
    await _notifications.show(
      id, 
      title, 
      body, 
      await _notificationDetails()
    );
  }

  static Future removeAllNotification() async{
    print('removed all notifications');
    await _notifications.cancelAll();
  }
  
  static Future removeNotificationWithId(int docId) async{
    print('removed notification with id $docId');
    await _notifications.cancel(docId);
  }

  //scheduled notification
  static Future scheduleNotification({
    int id = 0,   // id is from the firestore document
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async {
    print('Scheduling notification for id $id at $scheduledDate');
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
    int id = 0,   // id is from the firestore document
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async {
    print('Scheduling daily notification with id $id for $scheduledDate');
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

  //get list of notifications
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
    print('-----------------------------------');
  }

  }
}