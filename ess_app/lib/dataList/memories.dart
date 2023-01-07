class Memory{
  int memoryID;
  String memoryTitle;
  String memoryDateTime;
  String memoryImg;
  String memoryDetails;

  Memory({
    required this.memoryID,
    required this.memoryTitle,    
    required this.memoryDateTime,
    required this.memoryImg,
    required this.memoryDetails,    
  });
}

 List<Memory> memoryList = [
  Memory(
    memoryID: 000,
    memoryTitle: 'Team Building',
    memoryDateTime: '2022-12-22 00:00:00.000',
    memoryImg: 'images/001.png',
    memoryDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Memory(
    memoryID: 001,
    memoryTitle: 'Standup Meeting',
    memoryDateTime: '2022-12-19 01:00:00.000',
    memoryImg: 'images/002-1.png',
    memoryDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Memory(
    memoryID: 002,
    memoryTitle: 'Dinner with fam',
    memoryDateTime: '2022-12-17 00:00:00.000',
    memoryImg: 'images/003.png',
    memoryDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Memory(
    memoryID: 003,
    memoryTitle: 'Christmas',
    memoryDateTime: '2022-12-25 00:00:00.000',
    memoryImg: 'images/004.png',
    memoryDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
  Memory(
    memoryID: 004,
    memoryTitle: 'Noche Buena',
    memoryDateTime: '2022-12-24 00:00:00.000',
    memoryImg: 'images/005.png',
    memoryDetails: '4Sit sint mollit enim cillum exercitation officia est pariatur. Proident ex id eu nostrud laborum incididunt ad sit est. Minim adipisicing nostrud enim consectetur. Veniam consectetur officia veniam est elit ullamco. Sunt ut ullamco magna incididunt dolor deserunt dolore',
  ),
];