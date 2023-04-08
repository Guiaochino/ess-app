
class MemoryModel {

  // Model for memory. see memories.dart for references
  int memoryID;
  String memoryTitle;
  String memoryDateTime;
  String memoryImg;
  String memoryDetails;

  MemoryModel({
    required this.memoryID,
    required this.memoryTitle,
    required this.memoryDateTime,
    required this.memoryImg,
    required this.memoryDetails,
  });

  Map<String, dynamic> stringMapping() {
    return {
      'memoryID': memoryID,
      'memoryTitle': memoryTitle,
      'memoryDateTime': memoryDateTime,
      'memoryImg': memoryImg,
      'memoryDetails': memoryDetails,
    };
  }

}