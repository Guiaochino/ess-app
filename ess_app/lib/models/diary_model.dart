
import 'package:flutter/cupertino.dart';

class DiaryModel {

  // Model for diary. see diaries.dart for references
  String uid;
  String diaryTitle;
  DateTime diaryDateTime;
  String diaryDetails;
  int emoteRate;
  bool isDeleted = false;

  DiaryModel({
    required this.uid,
    required this.diaryTitle,
    required this.diaryDateTime,
    required this.diaryDetails,
    required this.emoteRate,
  });

  Map<String, dynamic> stringMapping() {
    return {
      'diaryID': uid,
      'dairyTitle': diaryTitle,
      'diaryDateTime': diaryDateTime,
      'diaryDetails': diaryDetails,
      'emoteRate': emoteRate,
      'isDeleted': isDeleted,
    };
  }

}