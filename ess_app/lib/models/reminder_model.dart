
import 'package:flutter/cupertino.dart';

class ReminderModel {

  // Model for reminders. See reminders.dart for refenrences
  String uid;
  String reminderTitle;
  DateTime reminderDateTime;
  bool reminderIsDone;
  String reminderDetails;
  bool isDeleted = false;

  ReminderModel({
    required this.uid,
    required this.reminderTitle,
    required this.reminderDateTime,
    required this.reminderIsDone,
    required this.reminderDetails,
  });

  Map<String, dynamic> stringMapping() {
    return {
      'reminderID': uid,
      'reminderTitle': reminderTitle,
      'reminderDateTime': reminderDateTime,
      'reminderIsDone': reminderIsDone,
      'reminderDetails': reminderDetails,
      'isDeleted': isDeleted,
    };
  }
}