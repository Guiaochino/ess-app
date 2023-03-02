class Reminder{
  int reminderID;
  String reminderTitle;
  String reminderDateTime;
  bool reminderIsDone;
  String reminderDetails;

  Reminder({
    required this.reminderID,
    required this.reminderTitle,    
    required this.reminderDateTime,
    required this.reminderIsDone,
    required this.reminderDetails,    
  });
}

 List<Reminder> reminderList = [
  Reminder(
    reminderID: 000,
    reminderTitle: 'Lunch',
    reminderDateTime: '2022-12-22 12:24:00.000',
    reminderIsDone: true,
    reminderDetails: 'With family',
  ),
  Reminder(
    reminderID: 001,
    reminderTitle: 'Breakfast',
    reminderDateTime: '2022-12-19 08:00:00.000',
    reminderIsDone: true,
    reminderDetails: 'No coffee.',
  ),
  Reminder(
    reminderID: 002,
    reminderTitle: 'Rosary',
    reminderDateTime: '2022-12-17 16:00:00.000',
    reminderIsDone: false,
    reminderDetails: 'For the death anniversary of May',
  ),
  Reminder(
    reminderID: 003,
    reminderTitle: 'Maria Clara at Ibarra',
    reminderDateTime: '2022-12-25 20:15:00.000',
    reminderIsDone: false,
    reminderDetails: 'Finale episode',
  ),
  Reminder(
    reminderID: 004,
    reminderTitle: 'Sleep',
    reminderDateTime: '2022-12-24 22:00:00.000',
    reminderIsDone: false,
    reminderDetails: 'Need to have early sleep',
  ),
];