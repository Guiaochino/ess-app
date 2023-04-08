
class ReminderModel {

  // Model for reminders. See reminders.dart for refenrences
  int reminderID;
  String reminderTitle;
  String reminderDateTime;
  bool reminderIsDone;
  String reminderDetails;

  ReminderModel({
    required this.reminderID,
    required this.reminderTitle,
    required this.reminderDateTime,
    required this.reminderIsDone,
    required this.reminderDetails,
  });

  Map<String, dynamic> stringMapping() {
    return {
      'reminderID': reminderID,
      'reminderTitle': reminderTitle,
      'reminderDateTime': reminderDateTime,
      'reminderIsDone': reminderIsDone,
      'reminderDetails': reminderDetails,
    };
  }

}