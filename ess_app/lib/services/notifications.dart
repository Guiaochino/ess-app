import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ess_app/models/reminder_model.dart';
import 'package:ess_app/models/schedule_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails('channel id', 'channel name',
          importance: Importance.max,
          enableLights: true,
          enableVibration: true,
          playSound: true,
          priority: Priority.high),
    );
  }

  static Future testNotification({
    int id = 0, // id is from the firestore document
    String? title,
    String? body,
    String? payload,
  }) async {
    await _notifications.show(id, title, body, await _notificationDetails());
  }

  static Future removeAllNotification() async {
    print('removed all notifications');
    await _notifications.cancelAll();
  }

  static Future removeNotificationWithId(int docId) async {
    print('removed notification with id $docId');
    await _notifications.cancel(docId);
  }

  //scheduled notification
  static Future scheduleNotification(
      {int id = 0, // id is from the firestore document
      String? title,
      String? body,
      String? payload,
      required DateTime scheduledDate,
      AndroidScheduleMode? androidScheduleMode}) async {
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
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  //reminder daily notification
  static Future reminderNotification(
      {int id = 0, // id is from the firestore document
      String? title,
      String? body,
      String? payload,
      required DateTime scheduledDate,
      AndroidScheduleMode? androidScheduleMode}) async {
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
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  //get list of notifications
  static Future<List<PendingNotificationRequest>>
      getAllScheduledNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }

  // Print all scheduled notifications
  static void printAllScheduledNotifications() async {
    final pendingNotifications = await getAllScheduledNotifications();
    print('Number of Pending Notifications: ${pendingNotifications.length}');
    for (PendingNotificationRequest pendingNotification
        in pendingNotifications) {
      print('Notification ID: ${pendingNotification.id}');
      print('Title: ${pendingNotification.title}');
      print('Body: ${pendingNotification.body}');
      print('Payload: ${pendingNotification.payload}');
      print('-----------------------------------');
    }
  }

  // this function is for syncing documents that arent in the notification
  // downsides is that edited notification from the other side arent updated
  static Future<void> syncNotifications(String user) async {
    // fetching
    final notifications =
        await FlutterLocalNotificationsPlugin().pendingNotificationRequests();
    final reminderDocs = await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('reminders')
        .where('isDeleted', isEqualTo: false)
        .get();
    final scheduleDocs = await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('schedules')
        .where('isDeleted', isEqualTo: false)
        .get();

    // getting the ids of the current notifications in the database
    final notificationIds = Set<int>();
    final reminderIds =
        Set<String>.from(reminderDocs.docs.map((doc) => doc.id));
    final scheduleIds =
        Set<String>.from(scheduleDocs.docs.map((doc) => doc.id));
    print(reminderIds);
    print(scheduleIds);

    // the goal of this for loop is to delete any running notifs that arent in the database
    // for every notification in notification list
    for (final notification in notifications) {
      //getting the id of notification into id
      final id = notification.id.toString();
      // checking if any of id of notification is in any of the schedule and reminder ids
      if (reminderIds.contains(id) || scheduleIds.contains(id)) {
        // add the notification id into the reminder
        notificationIds.add(int.parse(id));
      } else {
        // delete notif
        // await FlutterLocalNotificationsPlugin().cancel(id);
      }
    }

    print('Notification Ids');
    print(notificationIds);

    // the goal of this is to add any docus that arent in the notif list
    final reminderNotifications = reminderIds
        .difference(notificationIds.map((id) => id.toString()).toSet());
    final scheduleNotifications = scheduleIds
        .difference(notificationIds.map((id) => id.toString()).toSet());

    print(reminderNotifications);
    print(scheduleNotifications);

    if (reminderNotifications.isNotEmpty) {
      for (final id in reminderNotifications) {
        final reminderDoc =
            reminderDocs.docs.where((doc) => doc.id == id.toString()).first;
        ReminderModel reminderEntry = new ReminderModel(
          uid: reminderDoc['uid'],
          reminderTitle: reminderDoc['reminderTitle'],
          reminderDateTime: DateTime.fromMillisecondsSinceEpoch(
              reminderDoc['reminderDateTime'].millisecondsSinceEpoch),
          reminderDetails: reminderDoc['reminderDetails'],
        );

        NotificationService.reminderNotification(
          id: int.parse(reminderEntry.uid),
          title: "Here's a reminder!",
          body:
              '${reminderEntry.reminderTitle} \n${reminderEntry.reminderDetails}',
          scheduledDate: reminderEntry.reminderDateTime,
        );
      }
    } else {
      print('Reminders are updated');
    }

    if (scheduleNotifications.isNotEmpty) {
      for (final id in scheduleNotifications) {
        final scheduleDoc =
            scheduleDocs.docs.where((doc) => doc.id == id.toString()).first;
        ScheduleModel scheduleEntry = new ScheduleModel(
          uid: scheduleDoc['uid'],
          schedTitle: scheduleDoc['schedTitle'],
          schedDateTime: DateTime.fromMillisecondsSinceEpoch(
              scheduleDoc['schedDateTime'].millisecondsSinceEpoch),
          schedDetails: scheduleDoc['schedDetails'],
        );

        if (scheduleEntry.schedDateTime.isAfter(DateTime.now())) {
          NotificationService.scheduleNotification(
            id: int.parse(scheduleEntry.uid),
            title: "Here's a reminder!",
            body: '${scheduleEntry.schedTitle} \n${scheduleEntry.schedDetails}',
            scheduledDate: scheduleEntry.schedDateTime,
          );
        } else {
          print(
              'Cant add schedule with id ${scheduleEntry.uid} since the datetime has passed');
        }
      }
    } else {
      print('Schedules are updated');
    }

    // for (final id in reminderNotifications.union(scheduleNotifications)) {
    //   final doc = await FirebaseFirestore.instance.doc('reminder/$id').get();
    //   final title = doc['title'];
    //   final body = doc['body'];
    //   final scheduledTime = DateTime.parse(doc['scheduledTime']);
    //   final androidDetails = AndroidNotificationDetails(
    //     'channel id',
    //     'channel name',
    //     'channel description',
    //     importance: Importance.max,
    //     priority: Priority.high,
    //     styleInformation: BigTextStyleInformation(''),
    //   );
    //   final iOSDetails = IOSNotificationDetails();
    //   final platformDetails = NotificationDetails(android: androidDetails, iOS: iOSDetails);

    //   await FlutterLocalNotificationsPlugin().schedule(
    //     id,
    //     title,
    //     body,
    //     scheduledTime,
    //     platformDetails,
    //     payload: '',
    //     androidAllowWhileIdle: true,
    //   );
    // }
  }
}
