
import 'package:flutter/cupertino.dart';

class MemoryModel {

  // Model for memory. see memories.dart for references
  String uid = UniqueKey().toString();
  String memoryTitle;
  String memoryDateTime;
  String memoryImg;
  String memoryDetails;

  MemoryModel({
    required this.memoryTitle,
    required this.memoryDateTime,
    required this.memoryImg,
    required this.memoryDetails,
  });

  Map<String, dynamic> stringMapping() {
    return {
      'memoryTitle': memoryTitle,
      'memoryDateTime': memoryDateTime,
      'memoryImg': memoryImg,
      'memoryDetails': memoryDetails,
    };
  }

}