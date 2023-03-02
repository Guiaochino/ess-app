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
    diaryTitle: 'Rest Day',
    diaryDateTime: '2022-12-22 00:00:00.000',
    diaryDetails: 'Ahhhh, what a peaceful day. This rest day is an opportunity to take a break from work, responsibilities, and daily stress, and to focus on self-care and relaxation. ',
    emoteRate: 5
  ),
  Diary(
    diaryID: 001,
    diaryTitle: 'Sad day',
    diaryDateTime: '2022-12-19 01:00:00.000',
    diaryDetails: 'This is a sad day for me. Im alone in this house for the day. They all went to Korea without me.',
    emoteRate: 2
  ),
  Diary(
    diaryID: 002,
    diaryTitle: 'Dinner with familyyy',
    diaryDateTime: '2022-12-17 00:00:00.000',
    diaryDetails: 'We had dinner at Morayta. The food was so good, i want to eat there again',
    emoteRate: 6
  ),
  Diary(
    diaryID: 003,
    diaryTitle: 'Christmas',
    diaryDateTime: '2022-12-25 00:00:00.000',
    diaryDetails: 'We spend our christmas here at Bulacan. Our whole family is here and Im so happy to spend my christmas with them',
    emoteRate: 6
  ),
  Diary(
    diaryID: 004,
    diaryTitle: 'New Year',
    diaryDateTime: '2023-01-01 00:00:00.000',
    diaryDetails: 'This new year is the most memorable day in my 2023 so far. My whole family is here, the new year is not as noisy as the previous ones, we had fun talking to each other.',
    emoteRate: 7
  ),
];