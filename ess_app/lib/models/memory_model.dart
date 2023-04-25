
import 'package:flutter/cupertino.dart';

class MemoryModel {

  // Model for memory. see memories.dart for references
  String uid;
  String memoryTitle;
  DateTime memoryDateTime;
  String memoryImg;
  String memoryDetails;
  bool isDeleted = false;

  MemoryModel({
    required this.uid,
    required this.memoryTitle,
    required this.memoryDateTime,
    required this.memoryImg,
    required this.memoryDetails,
  });

  Map<String, dynamic> stringMapping() {
    return {
      'uid': uid,
      'memoryTitle': memoryTitle,
      'memoryDateTime': memoryDateTime,
      'memoryImg': memoryImg,
      'memoryDetails': memoryDetails,
      'isDeleted': isDeleted,
    };
  }

}