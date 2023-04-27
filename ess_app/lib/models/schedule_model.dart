
import 'package:flutter/cupertino.dart';

class ScheduleModel {

  // model for schedule. see schedules.dart for references
  String uid;
  String schedTitle;
  DateTime schedDateTime;
  String schedDetails;
  bool isDeleted = false;

  ScheduleModel({
    required this.uid,
    required this.schedTitle,
    required this.schedDateTime,
    required this.schedDetails,
  });

  Map<String, dynamic> stringMapping() {
    return {
      'uid': uid,
      'schedTitle': schedTitle,
      'schedDateTime': schedDateTime,
      'schedDetails': schedDetails,
      'isDeleted': isDeleted,
    };
  }

}