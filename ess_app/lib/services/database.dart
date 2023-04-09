
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ess_app/models/diary_model.dart';
import 'package:ess_app/models/memory_model.dart';
import 'package:ess_app/models/reminder_model.dart';
import 'package:ess_app/models/schedule_model.dart';
import 'package:ess_app/models/user_model.dart';

class DatabaseService {

  final String uid;
  final String diaryCollection = 'diaries';
  final String memoryCollection = 'memories';
  final String reminderCollection = 'reminders';
  final String scheduleCollection = 'schedules';

  DatabaseService({ required this.uid });


  // collection reference create if non existent or access if existing
  static FirebaseFirestore dbcon = FirebaseFirestore.instance;

  /*
    Always use this.uid to fetch, update, add, data to specific user via unique ID
  */

  final CollectionReference userCollection = dbcon.collection('users');

  // create a user data with guardian and patient anme along with List of data

  Future createUserData(UserModel user) async {
    return await userCollection.doc(this.uid).set(user.stringMapping());
  }

  // Adding Data
  // Diary Data Entry
  Future addDiary(DiaryModel diaryData) async{
    return await userCollection.doc(this.uid)
    .collection(diaryCollection)
    .doc(diaryData.uid)
    .set(diaryData.stringMapping());
  }

  // Memory Data Entry
  Future addMemory(MemoryModel memoryData) async {
    return await userCollection.doc(this.uid)
    .collection(memoryCollection)
    .doc(memoryData.uid)
    .set(memoryData.stringMapping());
  }

  // Reminder Data Entry
  Future addReminder(ReminderModel reminderData) async {
    return await userCollection.doc(this.uid)
    .collection(reminderCollection)
    .doc(reminderData.uid)
    .set(reminderData.stringMapping());
  }

  // Schedule Data Entry
  Future addSchedule(ScheduleModel scheduleData) async {
    return await userCollection.doc(this.uid)
    .collection(scheduleCollection)
    .doc(scheduleData.uid)
    .set(scheduleData.stringMapping());
  }

  // Fetching or Reading Data
  // TODO: retrieve data from firebase
  // TODO: fetch_all data per category
  // TODO: fetch data by ID per category

  // Updating Data by ID
  // Diary Update
  Future updateDiaryByID(String selected_id, DiaryModel diaryPayload) async {
    return await userCollection.doc(this.uid)
    .collection(diaryCollection)
    .doc(selected_id)
    .update(diaryPayload.stringMapping());
  }

  // Memory Update
  Future updateMemoryByID(String selected_id, MemoryModel memoryPayload) async {
    return await userCollection.doc(this.uid)
    .collection(memoryCollection)
    .doc(selected_id)
    .update(memoryPayload.stringMapping());
  }

  // Remidner Update
  Future updateRemidnerByID(String selected_id, ReminderModel reminderPayload) async {
    return await userCollection.doc(this.uid)
    .collection(reminderCollection)
    .doc(selected_id)
    .update(reminderPayload.stringMapping());
  }

  // Schedule Update
  Future updateScheduleByID(String selected_id, ScheduleModel schedulePayload) async {
    return await userCollection.doc(this.uid)
    .collection(scheduleCollection)
    .doc(selected_id)
    .update(schedulePayload.stringMapping());
  }

  // Inserting Updating for Patient and Guardian name
  // For Guardian
  Future updateGuardianName(String guardian_name) async {
    return await userCollection.doc(this.uid)
    .update({'guardianName' : guardian_name})
    .then((value) => print("Updated Successfully!"));
  }

  // For Patient
  Future updatePatientName(String patient_name) async {
    return await userCollection.doc(this.uid)
    .update({'patientName' : patient_name})
    .then((value) => print("Updated Successfully"));
  }

}