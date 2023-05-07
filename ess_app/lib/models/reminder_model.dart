
import 'package:flutter/cupertino.dart';

class ReminderModel {

  // Model for reminders. See reminders.dart for refenrences
  String uid;
  String reminderTitle;
  DateTime reminderDateTime;
  String reminderDetails;
  bool isDeleted = false;

  ReminderModel({
    required this.uid,
    required this.reminderTitle,
    required this.reminderDateTime,
    required this.reminderDetails,
  });

  Map<String, dynamic> stringMapping() {
    return {
      'uid': uid,
      'reminderTitle': reminderTitle,
      'reminderDateTime': reminderDateTime,
      'reminderDetails': reminderDetails,
      'isDeleted': isDeleted,
    };
  }
}