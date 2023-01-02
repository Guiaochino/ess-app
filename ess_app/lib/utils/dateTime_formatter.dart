//return todays date formatted as mmddyyyy
import 'package:intl/intl.dart';

String todaysDateFormatted() {
  var dateTimeObject = DateTime.now();

  //month in format mm
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }
  //year in format yyyy
  String year = dateTimeObject.year.toString();

  String yyyymmdd = year + month + day;
  return yyyymmdd;
}

// convert string mmddyyyy to DateTime object
DateTime createDateTimeObject(String yyyymmdd) {
  int mm = int.parse(yyyymmdd.substring(0, 2));
  int dd = int.parse(yyyymmdd.substring(2, 4));
  int yyyy = int.parse(yyyymmdd.substring(4, 8));

  DateTime dateTimeObject = DateTime(yyyy, mm, dd);
  return dateTimeObject;
}

//convert DateTime object to string mmddyyyy
String convertDateTimeToString(DateTime dateTime) {
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }
  //year in format yyyy
  String year = dateTime.year.toString();

  String yyyymmdd = year + month + day;

  return yyyymmdd;
}





//datetime converter using parse
//string to dateTime
DateTime parseStringToDate(String dateTime) {
  DateTime tempDate = DateFormat("dd-MM-yyyy H:mm:ss").parse(dateTime);
  return tempDate;
}

//dateTime to string
//sample format - 12-12-2022 23:58:44
String parseDateToString(DateTime dateTime) {
  String tempDate = DateFormat("dd-MM-yyyy H:mm:ss").format(dateTime);

  return tempDate;
}

// extract String date from String dateTime
//from 12-15-2022 22:58:44 => Dec 12, 2022
String extractDatefromDTString(String dateTime) {
  DateTime tempDate = DateFormat("yyyy-MM-dd").parse(dateTime);
  String formattedDate = DateFormat.yMMMd().format(tempDate);
  return formattedDate;
}
// extract String date from String dateTime
//from 12-15-2022 22:58:44 => 12-15-2022
String extractDatefromDTString2(String dateTime) {
  DateTime tempDate = DateFormat("dd-MM-yyyy").parse(dateTime);
  String formattedDate = DateFormat.yMMMd().format(tempDate);
  return formattedDate;
}

// extract String time from String dateTime
//from 12-15-2022 22:58:44 => 12:58 PM
String extractTimefromDTString(String dateTime) {
  DateTime tempTime = DateFormat("dd-MM-yyyy H:mm:ss").parse(dateTime);
  String formattedTime = DateFormat.jm().format(tempTime);
  return formattedTime;
}

String extractDayNamefromDTString(String dateTime) {
  DateTime tempTime = DateFormat("dd-MM-yyyy H:mm:ss").parse(dateTime);
  String formattedTime = DateFormat.EEEE().format(tempTime);
  print (formattedTime);
  return formattedTime;
}

// in case you forgot, just use dateformat if its dateTime-dateTime data type
// extracted string time from DateTime
String extractTime(DateTime dateTime) {
  String extractedTime = DateFormat("H:mm:ss").format(dateTime);
  return extractedTime;
}

// extracted string date from DateTime
String extractDate(DateTime dateTime) {
  String extractedDate = DateFormat("dd-MM-yyyy ").format(dateTime);
  return extractedDate;
}
