class Diary{
  int diaryID;
  String diaryTitle;
  String diaryDateTime;
  String diaryDetails;
  int emoteRate;

  Diary({
    required this.diaryID,
    required this.diaryTitle,    
    required this.diaryDateTime,
    required this.diaryDetails, 
    required this.emoteRate,   
  });
}

 List<Diary> diaryList = [
  Diary(
    diaryID: 000,
    diaryTitle: 'Team Building',
    diaryDateTime: '2022-12-22 00:00:00.000',
    diaryDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
    emoteRate: 5
  ),
  Diary(
    diaryID: 001,
    diaryTitle: 'Standup Meeting',
    diaryDateTime: '2022-12-19 01:00:00.000',
    diaryDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
    emoteRate: 2
  ),
  Diary(
    diaryID: 002,
    diaryTitle: 'Dinner with fam',
    diaryDateTime: '2022-12-17 00:00:00.000',
    diaryDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
    emoteRate: 6
  ),
  Diary(
    diaryID: 003,
    diaryTitle: 'Christmas',
    diaryDateTime: '2022-12-25 00:00:00.000',
    diaryDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
    emoteRate: 1
  ),
  Diary(
    diaryID: 004,
    diaryTitle: 'Noche Buena',
    diaryDateTime: '2022-12-24 00:00:00.000',
    diaryDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
    emoteRate: 7
  ),
];