
import 'package:flutter/cupertino.dart';

class ReminderModel {

  // Model for reminders. See reminders.dart for refenrences
  String uid = UniqueKey().toString();
  String reminderTitle;
  String reminderDateTime;
  bool reminderIsDone;
  String reminderDetails;

  ReminderModel({
    required this.reminderTitle,
    required this.reminderDateTime,
    required this.reminderIsDone,
    required this.reminderDetails,
  });

  Map<String, dynamic> stringMapping() {
    return {
      'reminderTitle': reminderTitle,
      'reminderDateTime': reminderDateTime,
      'reminderIsDone': reminderIsDone,
      'reminderDetails': reminderDetails,
    };
  }

}