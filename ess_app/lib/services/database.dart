
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ess_app/models/diary_model.dart';
import 'package:ess_app/models/memory_model.dart';
import 'package:ess_app/models/reminder_model.dart';
import 'package:ess_app/models/schedule_model.dart';
import 'package:ess_app/models/user_model.dart';
import 'package:ess_app/constants.dart';

class DatabaseService {

  final String uid;

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
  // Single Function to Add Data on different collection
  Future addDatatoCollection(String collectionName, dynamic payload) async {
    return await userCollection.doc(this.uid)
      .collection(collectionName)
      .doc(payload.uid)
      .set(payload.stringMapping());
  }

  // Main Function to Add Data
  void addData(String collectionReference, dynamic payload) {
    if (collectionReference == diaryCollection) {
      addDatatoCollection(collectionReference, payload);
    }
    else if (collectionReference == memoryCollection) {
      addDatatoCollection(collectionReference, payload);
    }
    else if (collectionReference == reminderCollection) {
      addDatatoCollection(collectionReference, payload);
    }
    else if (collectionReference == scheduleCollection) {
      addDatatoCollection(collectionReference, payload);
    }
  }

  // Retrive all by category
  Future<List> getAllData(String collectionCaller) async {

    // Check what data to be fetched if diary, memory, reminder, or schedule
    if (collectionCaller == diaryCollection) {

      List<DiaryModel> diaryList = [];

      await userCollection
        .doc(this.uid)
        .collection(diaryCollection)
        .get()
        .then((QuerySnapshot snapshot) => {
          for (var docSnap in snapshot.docs)
            {diaryList.add(new DiaryModel(
              diaryTitle: docSnap.get('diaryTitle'), 
              diaryDateTime: docSnap.get('diaryDateTime'), 
              diaryDetails: docSnap.get('diaryDetails'), 
              emoteRate: docSnap.get('emoteRate'),
              ))}
        });

      return diaryList;
    }
    else if (collectionCaller == memoryCollection) {

      List<MemoryModel> memoryList = [];

      await userCollection
        .doc(this.uid)
        .collection(memoryCollection)
        .get()
        .then((QuerySnapshot snapshot) => {
          for (var docSnap in snapshot.docs)
            {memoryList.add(new MemoryModel(
              memoryTitle: docSnap.get('memoryTitle'), 
              memoryDateTime: docSnap.get('memoryDateTime'), 
              memoryImg: docSnap.get('memoryImg'), 
              memoryDetails: docSnap.get('memoryDetails')))}
        });

      return memoryList;
    }
    else if (collectionCaller == reminderCollection) {

      List<ReminderModel> reminderList = [];

      await userCollection
        .doc(this.uid)
        .collection(reminderCollection)
        .get()
        .then((QuerySnapshot snapshot) => {
          for (var docSnap in snapshot.docs)
            {reminderList.add(new ReminderModel(
              reminderTitle: docSnap.get('reminderTitle'), 
              reminderDateTime: docSnap.get('reminderDateTime'), 
              reminderIsDone: docSnap.get('reminderIsDone'), 
              reminderDetails: docSnap.get('reminderDetails')))}
        });
      
      return reminderList;
    }
    else if (collectionCaller == scheduleCollection) {

      List<ScheduleModel> scheduleList = [];

      await userCollection
        .doc(this.uid)
        .collection(scheduleCollection)
        .get()
        .then((QuerySnapshot snapshot) => {
          for (var docSnap in snapshot.docs)
            {scheduleList.add(new ScheduleModel(
              schedTitle: docSnap.get('schedTitle'), 
              schedDateTime: docSnap.get('schedDateTime'), 
              schedIsDone: docSnap.get('schedIsDone'), 
              schedDetails: docSnap.get('schedDetails')))}
        });

      return scheduleList;
    } else {
      return throw Exception();
    }
  }

  // Retrieve Data by ID
  Future getDataByID(String collectionCaller, String selected_id) async {
    if (collectionCaller == diaryCollection) {
      var data =  await userCollection.doc(this.uid)
        .collection(diaryCollection)
        .doc(selected_id)
        .get().then((value) => {
          new DiaryModel(
            diaryTitle: value.get('diaryTitle'), 
            diaryDateTime: value.get('diaryDateTime'), 
            diaryDetails: value.get('diaryDetails'), 
            emoteRate: value.get('emoteRate'))
        });

      return data;
    }
  }

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