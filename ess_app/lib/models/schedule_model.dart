
import 'package:flutter/cupertino.dart';

class ScheduleModel {

  // model for schedule. see schedules.dart for references
  String uid;
  String schedTitle;
  DateTime schedDateTime;
  bool schedIsDone;
  String schedDetails;
  bool isDeleted = false;

  ScheduleModel({
    required this.uid,
    required this.schedTitle,
    required this.schedDateTime,
    required this.schedIsDone,
    required this.schedDetails,
  });

  Map<String, dynamic> stringMapping() {
    return {
      'uid': uid,
      'schedTitle': schedTitle,
      'schedDateTime': schedDateTime,
      'schedIsDone': schedIsDone,
      'schedDetails': schedDetails,
      'isDeleted': isDeleted,
    };
  }

}