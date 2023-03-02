class Schedule{
  int schedID;
  String schedTitle;
  String schedDateTime;
  bool schedIsDone;
  String schedDetails;

  Schedule({
    required this.schedID,
    required this.schedTitle,    
    required this.schedDateTime,
    required this.schedIsDone,
    required this.schedDetails,    
  });
}

List<Schedule> scheduleList = [
  Schedule(
    schedID: 000,
    schedTitle: 'T1 vs HLE match',
    schedDateTime: '2023-02-16 14:52:00.000',
    schedIsDone: false,
    schedDetails: 'Banger matchup',
  ),
  Schedule(
    schedID: 001,
    schedTitle: 'Standup Meeting',
    schedDateTime: '2022-12-19 01:00:00.000',
    schedIsDone: true,
    schedDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Schedule(
    schedID: 002,
    schedTitle: 'Dinner with fam',
    schedDateTime: '2022-12-17 00:00:00.000',
    schedIsDone: true,
    schedDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Schedule(
    schedID: 003,
    schedTitle: 'Christmas',
    schedDateTime: '2022-12-25 00:00:00.000',
    schedIsDone: false,
    schedDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Schedule(
    schedID: 004,
    schedTitle: 'Noche Buena',
    schedDateTime: '2022-12-24 00:00:00.000',
    schedIsDone: false,
    schedDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Schedule(
    schedID: 005,
    schedTitle: 'Fiesta',
    schedDateTime: '2023-01-12 07:22:00.000',
    schedIsDone: true,
    schedDetails: 'Sto. Nino fiesta in Bago Bantay, Quezon City',
  ),
  Schedule(
    schedID: 006,
    schedTitle: 'Team Building',
    schedDateTime: '2022-12-22 12:20:00.000',
    schedIsDone: true,
    schedDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Schedule(
    schedID: 007,
    schedTitle: 'Dinner Date',
    schedDateTime: '2023-02-16 14:30:00.000',
    schedIsDone: false,
    schedDetails: 'Date with ____, belated valentine celebration',
  ),
  Schedule(
    schedID: 008,
    schedTitle: 'asidoawudadad',
    schedDateTime: '2023-02-16 05:52:00.000',
    schedIsDone: false,
    schedDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
];