import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ess_app/models/diary_model.dart';
import 'package:ess_app/models/memory_model.dart';
import 'package:ess_app/models/reminder_model.dart';
import 'package:ess_app/models/schedule_model.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ required this.uid });

  // collection reference create if non existent or access if existing
  final CollectionReference appCollection = FirebaseFirestore.instance.collection('geriassis');

  // create a user data with guardian and patient anme along with List of data
  Future createUserData(String guardian_name, String patient_name) async {
    return await appCollection.doc(this.uid).set({
      'guardian' : guardian_name,
      'patient' : patient_name,
      'diaries' : <DiaryModel>[],
      'reminders' : <ReminderModel>[],
      'memories' : <MemoryModel>[],
      'schedules' : <ScheduleModel>[],
    });
  }

  // Inserting Updating for Patient and Guardian name
  // For Guardian
  Future updateGuardianName(String guardian_name) async {
    return await appCollection.doc(this.uid).update({'guardian' : guardian_name}).then((value) => print("Updated Successfully!"));
  }

  // For Patient
  Future updatePatientName(String patient_name) async {
    return await appCollection.doc(this.uid).update({'patient' : patient_name}).then((value) => print("Updated Successfully"));
  }

  // For Diaries
  // DONE: Insert Diary Entry
  // TODO: Delete Diary Entry
  // TODO: Update Diary Entry
  // Insertion of Diary in a list
  Future insertDiaries(DiaryModel diary_entry) async {
    // Inserting a class in a list
    return await appCollection.doc(this.uid).update({'diaries' : FieldValue.arrayUnion([diary_entry])});
  }

  // Approach 1: Rewriting whole list instead of arrayRemove Status: (pending)

  // Deleting diary in a list
  Future deleteDiaries(int diary_ID) async {
    // Code for deleting diary here
    final diaries = appCollection.doc(this.uid).get().then((value) => value.data() as Map<DiaryModel, dynamic>, onError: (e) => print("Error getting document: $e"));

    // For debugging purposes, shows all list of diaries
    print(diaries);
  }

  // Updating diary in a list
  Future updateDiary() async {
    // Code for updating diary here
  }

  // For Reminders
  // DONE: Insert Reminder
  // TODO: Delete Reminder
  // TODO: Update Reminder
  // Insertion of Reminder in a list
  Future insertReminder(ReminderModel reminder_entry) async {
    // Inserting a class in a list
    return await appCollection.doc(this.uid).update({'reminders' : FieldValue.arrayUnion([reminder_entry])});
  }

  // Deleting reminder in a list
  // Updating reminder in a list

  // For Schedules
  // DONE: Insert Schedules
  // TODO: Delete Schedules
  // TODO: Update Schedules
  // Insertion of Schedules in a list
  Future insertSchedule(ScheduleModel schedule_entry) async {
    return await appCollection.doc(this.uid).update({'schedules' : FieldValue.arrayUnion([schedule_entry])});
  }

  // Deleting schedule in a list
  // Updating schedule in a list

  // get application streams
  Stream<QuerySnapshot> get account {
    return appCollection.snapshots();
  }

}