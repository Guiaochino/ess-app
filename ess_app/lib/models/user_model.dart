
import 'package:ess_app/models/diary_model.dart';
import 'package:ess_app/models/memory_model.dart';
import 'package:ess_app/models/reminder_model.dart';
import 'package:ess_app/models/schedule_model.dart';

class UserModel {

  final String uid;
  final String? email;
  String guardianName = "";
  String patientName = "";
  
  // Initialize empty collections
  List<DiaryModel> diaryList = <DiaryModel>[];
  List<MemoryModel> memoryList = <MemoryModel>[];
  List<ReminderModel> reminderList = <ReminderModel>[];
  List<ScheduleModel> scheduleList = <ScheduleModel>[];

  // Getters & Setters
  // Set Guardian
  void set guardian_name(String guardian_name) {
    this.guardianName = guardian_name;
  }

  // Set Patient
  void set patient_name(String patient_name) {
    this.patientName = patient_name;
  }

  // constructor
  UserModel({ required this.uid, this.email});
  
}