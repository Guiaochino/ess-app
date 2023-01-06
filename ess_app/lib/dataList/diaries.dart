class Diary{
  final String diaryTitle;
  final String diaryDateTime;
  final String diaryDetails;
  final int emoteRate;

  const Diary({
    required this.diaryTitle,    
    required this.diaryDateTime,
    required this.diaryDetails, 
    required this.emoteRate,   
  });
}

 List<Diary> diaryList = [
  Diary(
    diaryTitle: 'Team Building',
    diaryDateTime: '2022-12-22 00:00:00.000',
    diaryDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
    emoteRate: 5
  ),
  Diary(
    diaryTitle: 'Standup Meeting',
    diaryDateTime: '2022-12-19 01:00:00.000',
    diaryDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
    emoteRate: 2
  ),
  Diary(
    diaryTitle: 'Dinner with fam',
    diaryDateTime: '2022-12-17 00:00:00.000',
    diaryDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
    emoteRate: 6
  ),
  Diary(
    diaryTitle: 'Christmas',
    diaryDateTime: '2022-12-25 00:00:00.000',
    diaryDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
    emoteRate: 1
  ),
  Diary(
    diaryTitle: 'Noche Buena',
    diaryDateTime: '2022-12-24 00:00:00.000',
    diaryDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
    emoteRate: 7
  ),
];