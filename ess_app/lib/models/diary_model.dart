
import 'package:flutter/cupertino.dart';

class DiaryModel {

  // Model for diary. see diaries.dart for references
  String uid = UniqueKey().toString();
  String diaryTitle;
  String diaryDateTime;
  String diaryDetails;
  int emoteRate;

  DiaryModel({
    required this.diaryTitle,
    required this.diaryDateTime,
    required this.diaryDetails,
    required this.emoteRate,
  });

  Map<String, dynamic> stringMapping() {
    return {
      'dairyTitle': diaryTitle,
      'diaryDateTime': diaryDateTime,
      'diaryDetails': diaryDetails,
      'emoteRate': emoteRate,
    };
  }

}