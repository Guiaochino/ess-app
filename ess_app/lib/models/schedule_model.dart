
class ScheduleModel {

  // model for schedule. see schedules.dart for references
  int schedID;
  String schedTitle;
  String schedDateTime;
  bool schedIsDone;
  String schedDetails;

  ScheduleModel({
    required this.schedID,
    required this.schedTitle,
    required this.schedDateTime,
    required this.schedIsDone,
    required this.schedDetails,
  });

  Map<String, dynamic> stringMapping() {
    return {
      'schedID': schedID,
      'schedTitle': schedTitle,
      'schedDateTime': schedDateTime,
      'schedIsDone': schedIsDone,
      'schedDetails': schedDetails,
    };
  }

}