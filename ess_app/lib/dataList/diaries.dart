class Diary{
  final String diaryTitle;
  final String diaryDateTime;
  final String diaryRecording;
  final String diaryDetails;

  const Diary({
    required this.diaryTitle,    
    required this.diaryDateTime,
    required this.diaryRecording,
    required this.diaryDetails,    
  });
}

const diaryList = [
  Diary(
    diaryTitle: 'Team Building',
    diaryDateTime: '2022-12-22 00:00:00.000',
    diaryRecording: 'recording1.mp4',
    diaryDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Diary(
    diaryTitle: 'Standup Meeting',
    diaryDateTime: '2022-12-19 01:00:00.000',
    diaryRecording: 'recording2.mp4',
    diaryDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Diary(
    diaryTitle: 'Dinner with fam',
    diaryDateTime: '2022-12-17 00:00:00.000',
    diaryRecording: 'recording3.mp4',
    diaryDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Diary(
    diaryTitle: 'Christmas',
    diaryDateTime: '2022-12-25 00:00:00.000',
    diaryRecording: 'recording4.mp4',
    diaryDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Diary(
    diaryTitle: 'Noche Buena',
    diaryDateTime: '2022-12-24 00:00:00.000',
    diaryRecording: 'recording5.mp4',
    diaryDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
];