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
    reminderDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Reminder(
    reminderID: 001,
    reminderTitle: 'Breakfast',
    reminderDateTime: '2022-12-19 08:00:00.000',
    reminderIsDone: false,
    reminderDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Reminder(
    reminderID: 002,
    reminderTitle: 'Dinner with fam',
    reminderDateTime: '2022-12-17 06:00:00.000',
    reminderIsDone: false,
    reminderDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Reminder(
    reminderID: 003,
    reminderTitle: 'Maria Clara at Ibarra',
    reminderDateTime: '2022-12-25 20:15:00.000',
    reminderIsDone: false,
    reminderDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Reminder(
    reminderID: 004,
    reminderTitle: 'Sleep',
    reminderDateTime: '2022-12-24 22:00:00.000',
    reminderIsDone: false,
    reminderDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
];