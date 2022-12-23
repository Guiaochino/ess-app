class Schedule{
  final String schedTitle;
  final String schedDateTime;
  final bool schedIsDone;
  final String schedDetails;

  const Schedule({
    required this.schedTitle,    
    required this.schedDateTime,
    required this.schedIsDone,
    required this.schedDetails,    
  });
}

const scheduleList = [
  Schedule(
    schedTitle: 'Team Building',
    schedDateTime: '2022-12-22 00:00:00.000',
    schedIsDone: false,
    schedDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Schedule(
    schedTitle: 'Standup Meeting',
    schedDateTime: '2022-12-19 01:00:00.000',
    schedIsDone: false,
    schedDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Schedule(
    schedTitle: 'Dinner with fam',
    schedDateTime: '2022-12-17 00:00:00.000',
    schedIsDone: false,
    schedDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Schedule(
    schedTitle: 'Christmas',
    schedDateTime: '2022-12-25 00:00:00.000',
    schedIsDone: false,
    schedDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Schedule(
    schedTitle: 'Noche Buena',
    schedDateTime: '2022-12-24 00:00:00.000',
    schedIsDone: false,
    schedDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
];