import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ess_app/models/diary_model.dart';
import 'package:ess_app/models/memory_model.dart';
import 'package:ess_app/models/reminder_model.dart';
import 'package:ess_app/models/schedule_model.dart';
import 'package:ess_app/models/user_model.dart';
import 'package:ess_app/constants.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

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
    return await userCollection
        .doc(this.uid)
        .collection(collectionName)
        .doc(payload.uid)
        .set(payload.stringMapping());
  }

  // Main Function to Add Data
  void addData(String collectionReference, dynamic payload) {
    if (collectionReference == diaryCollection) {
      addDatatoCollection(collectionReference, payload);
    } else if (collectionReference == memoryCollection) {
      addDatatoCollection(collectionReference, payload);
    } else if (collectionReference == reminderCollection) {
      addDatatoCollection(collectionReference, payload);
    } else if (collectionReference == scheduleCollection) {
      addDatatoCollection(collectionReference, payload);
    }
  }

  // Collection Switcher to get data
  List<dynamic> _dataListFromSnapshot(
      String collectionCaller, QuerySnapshot snapshot) {
    switch (collectionCaller) {
      case diaryCollection:
        return snapshot.docs.map((doc) {
          return DiaryModel(
              uid: doc.get('uid'),
              diaryTitle: doc.get('diaryTitle'),
              diaryDateTime: doc.get('diaryDateTime').toDate(),
              diaryDetails: doc.get('diaryDetails'),
              emoteRate: doc.get('emoteRate'));
        }).toList();
      case memoryCollection:
        return snapshot.docs.map((doc) {
          return MemoryModel(
              uid: doc.get('uid'),
              memoryTitle: doc.get('memoryTitle'),
              memoryDateTime: doc.get('memoryDateTime').toDate(),
              memoryImg: doc.get('memoryImg'),
              memoryDetails: doc.get('memoryDetails'));
        }).toList();
      case reminderCollection:
        return snapshot.docs.map((doc) {
          return ReminderModel(
              uid: doc.get('uid'),
              reminderTitle: doc.get('reminderTitle'),
              reminderDateTime: doc.get('reminderDateTime').toDate(),
              reminderDetails: doc.get('reminderDetails'));
        }).toList();
      case scheduleCollection:
        return snapshot.docs.map((doc) {
          return ScheduleModel(
              uid: doc.get('uid'),
              schedTitle: doc.get('schedTitle'),
              schedDateTime: doc.get('schedDateTime').toDate(),
              schedDetails: doc.get('schedDetails'));
        }).toList();
      default:
        return [];
    }
  }

  Stream<UserModel> get userData => userCollection.doc(this.uid).snapshots().map((element) => UserModel(uid: element.get('uid'), email: element.get('email'), guardianName: element.get('guardianName'), patientName: element.get('patientName')));

  // Streams for data in the diary
  Stream<List<DiaryModel>> get diaryData => userCollection
      .doc(this.uid)
      .collection(diaryCollection)
      .where('isDeleted', isEqualTo: false)
      .orderBy('diaryDateTime', descending: true)
      .snapshots()
      .map((element) =>
          _dataListFromSnapshot(diaryCollection, element) as List<DiaryModel>);


  // Streams for data in the memory
  Stream<List<MemoryModel>> get memoryData => userCollection
      .doc(this.uid)
      .collection(memoryCollection)
      .where('isDeleted', isEqualTo: false)
      .orderBy('memoryDateTime', descending: true)
      .snapshots()
      .map((element) => _dataListFromSnapshot(memoryCollection, element)
          as List<MemoryModel>);

  // Streams for data in the Reminder
  Stream<List<ReminderModel>> get reminderData => userCollection
      .doc(this.uid)
      .collection(reminderCollection)
      .where('isDeleted', isEqualTo: false)
      .snapshots()
      .map((element) => _dataListFromSnapshot(reminderCollection, element)
          as List<ReminderModel>);

  // Streams for data in the Schedule
  Stream<List<ScheduleModel>> get scheduleData => userCollection
      .doc(this.uid)
      .collection(scheduleCollection)
      .where('isDeleted', isEqualTo: false)
      .snapshots()
      .map((element) => _dataListFromSnapshot(scheduleCollection, element)
          as List<ScheduleModel>);

  // Deleting a key in a collection
  Future<void> deleteKeyFromCollectionByID(
      String collectionCaller, String key) async {
    switch (collectionCaller) {
      case diaryCollection:
        await userCollection
            .doc(this.uid)
            .collection(collectionCaller)
            .doc(key)
            .update({'isDeleted': true});
        break;
      case memoryCollection:
        await userCollection
            .doc(this.uid)
            .collection(collectionCaller)
            .doc(key)
            .update({'isDeleted': true});
        break;
      case reminderCollection:
        await userCollection
            .doc(this.uid)
            .collection(collectionCaller)
            .doc(key)
            .update({'isDeleted': true});
        break;
      case scheduleCollection:
        await userCollection
            .doc(this.uid)
            .collection(collectionCaller)
            .doc(key)
            .update({'isDeleted': true});
    }
  }

  // Incoming Reminders Stream
  Stream<List<ReminderModel>> get getIncomingReminders => userCollection
    .doc(this.uid)
    .collection(reminderCollection)
    .where('isDeleted', isEqualTo: false)
    .snapshots()
    .map((querySnapshot) {
      List<ReminderModel> reminders = [];
      TimeOfDay now = TimeOfDay.now();
      for (final documentSnapshot in querySnapshot.docs) {
        DateTime dateTime = documentSnapshot['reminderDateTime'].toDate();
        TimeOfDay time = TimeOfDay.fromDateTime(dateTime);
        if ((time.hour > now.hour) || 
            ((time.hour == now.hour) && (time.minute > now.minute))) {
             ReminderModel reminderModel = ReminderModel(
              uid: documentSnapshot.get('uid'),
              reminderTitle: documentSnapshot.get('reminderTitle'),
              reminderDateTime: documentSnapshot.get('reminderDateTime').toDate(),
              reminderDetails: documentSnapshot.get('reminderDetails'));
          reminders.add(reminderModel);
        }
      }
      reminders.sort((a, b) {
        Timestamp timestampA = Timestamp.fromDate(a.reminderDateTime);
        DateTime dateTimeA = timestampA.toDate();
        Timestamp timestampB = Timestamp.fromDate(b.reminderDateTime);
        DateTime dateTimeB = timestampB.toDate();
        return dateTimeA.compareTo(dateTimeB);
      });
      return reminders;
  });
  
  Stream<List<ReminderModel>> get getPastReminders => userCollection
    .doc(this.uid)
    .collection(reminderCollection)
    .where('isDeleted', isEqualTo: false)
    .snapshots()
    .map((querySnapshot) {
      List<ReminderModel> reminders = [];
      TimeOfDay now = TimeOfDay.now();
      for (final documentSnapshot in querySnapshot.docs) {
        DateTime dateTime = documentSnapshot['reminderDateTime'].toDate();
        TimeOfDay time = TimeOfDay.fromDateTime(dateTime);
        if ((time.hour < now.hour) || 
            ((time.hour == now.hour) && (time.minute <= now.minute))) {
             ReminderModel reminderModel = ReminderModel(
              uid: documentSnapshot.get('uid'),
              reminderTitle: documentSnapshot.get('reminderTitle'),
              reminderDateTime: documentSnapshot.get('reminderDateTime').toDate(),
              reminderDetails: documentSnapshot.get('reminderDetails'));
          reminders.add(reminderModel);
        }
      }
      reminders.sort((a, b) {
        Timestamp timestampA = Timestamp.fromDate(a.reminderDateTime);
        DateTime dateTimeA = timestampA.toDate();
        Timestamp timestampB = Timestamp.fromDate(b.reminderDateTime);
        DateTime dateTimeB = timestampB.toDate();
        return dateTimeA.compareTo(dateTimeB);
      });
      return reminders;
  });

  // Stream Schedules based on selected date
  Stream<List<ScheduleModel>> scheduleOfSelectedDate(DateTime selectedDate) {
    // Set the start of the selected date
    DateTime startOfSelectedDate =
      DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
  // Set the end of the selected date
    DateTime endOfSelectedDate = startOfSelectedDate.add(Duration(days: 1));
    return userCollection
        .doc(this.uid)
        .collection(scheduleCollection)
        .where('isDeleted', isEqualTo: false)
        .where('schedDateTime', isGreaterThanOrEqualTo: startOfSelectedDate)
        .where('schedDateTime', isLessThan: endOfSelectedDate)
        .orderBy('schedDateTime', descending: false)
        .snapshots()
        .map((element) => _dataListFromSnapshot(scheduleCollection, element)
            as List<ScheduleModel>);
  }

  // Updating Data by ID
  // Diary Update
  Future updateDiaryByID(String selected_id, DiaryModel diaryPayload) async {
    await userCollection
        .doc(this.uid)
        .collection(diaryCollection)
        .doc(selected_id)
        .update(diaryPayload.stringMapping());
  }

  // Memory Update
  Future updateMemoryByID(String selected_id, MemoryModel memoryPayload) async {
    await userCollection
        .doc(this.uid)
        .collection(memoryCollection)
        .doc(selected_id)
        .update(memoryPayload.stringMapping());
  }

  // Remidner Update
  Future updateRemidnerByID(
      String selected_id, ReminderModel reminderPayload) async {
    await userCollection
        .doc(this.uid)
        .collection(reminderCollection)
        .doc(selected_id)
        .update(reminderPayload.stringMapping());
  }

  // Schedule Update
  Future updateScheduleByID(
      String selected_id, ScheduleModel schedulePayload) async {
    await userCollection
        .doc(this.uid)
        .collection(scheduleCollection)
        .doc(selected_id)
        .update(schedulePayload.stringMapping());
  }

  // Inserting Updating for Patient and Guardian name
  // For Guardian
  Future updateGuardianName(String guardian_name) async {
    await userCollection
        .doc(this.uid)
        .update({'guardianName': guardian_name}).then(
            (value) => print("Updated Successfully!"));
  }

  // For Patient
  Future updatePatientName(String patient_name) async {
    await userCollection
        .doc(this.uid)
        .update({'patientName': patient_name}).then(
            (value) => print("Updated Successfully"));
  }

  //getting the count
  Future<int> getMemoryCount() async {
    final snapshot = await userCollection
        .doc(this.uid)
        .collection(memoryCollection)
        .where('isDeleted', isEqualTo: false)
        .get();
    return snapshot.size;
  }

  Future<int> getDiaryCount() async {
    final snapshot = await userCollection
        .doc(this.uid)
        .collection(diaryCollection)
        .where('isDeleted', isEqualTo: false)
        .get();
    return snapshot.size;
  }

  Future<int> getReminderCount() async {
    final snapshot = await userCollection
        .doc(this.uid)
        .collection(reminderCollection)
        .where('isDeleted', isEqualTo: false)
        .get();
    return snapshot.size;
  }

  Future<int> getScheduleCount() async {
    final snapshot = await userCollection
        .doc(this.uid)
        .collection(scheduleCollection)
        .where('isDeleted', isEqualTo: false)
        .get();
    return snapshot.size;
  }

  //streams for the homepage
  Stream<List<MemoryModel>> get memoryDataHome => userCollection
      .doc(this.uid)
      .collection(memoryCollection)
      .limit(3)
      .where('isDeleted', isEqualTo: false)
      .orderBy('memoryDateTime', descending: true)
      .snapshots()
      .map((element) => _dataListFromSnapshot(memoryCollection, element)
          as List<MemoryModel>);

  Stream<List<DiaryModel>> get diaryDataHome => userCollection
    .doc(this.uid)
    .collection(diaryCollection)
    .limit(3)
    .where('isDeleted', isEqualTo: false)
    .orderBy('diaryDateTime', descending: true)
    .snapshots()
    .map((element) =>
        _dataListFromSnapshot(diaryCollection, element) as List<DiaryModel>);

  // Streams for data in the Reminder
  Stream<List<ReminderModel>> get reminderDataHome => userCollection
    .doc(this.uid)
    .collection(reminderCollection)
    .where('isDeleted', isEqualTo: false)
    .snapshots()
    .map((querySnapshot) {
      List<ReminderModel> reminders = [];
      TimeOfDay now = TimeOfDay.now();
      for (final documentSnapshot in querySnapshot.docs) {
        DateTime dateTime = documentSnapshot['reminderDateTime'].toDate();
        TimeOfDay time = TimeOfDay.fromDateTime(dateTime);
        if ((time.hour > now.hour) || 
            ((time.hour == now.hour) && (time.minute > now.minute))) {
             ReminderModel reminderModel = ReminderModel(
              uid: documentSnapshot.get('uid'),
              reminderTitle: documentSnapshot.get('reminderTitle'),
              reminderDateTime: documentSnapshot.get('reminderDateTime').toDate(),
              reminderDetails: documentSnapshot.get('reminderDetails'));
          reminders.add(reminderModel);
        }
      }
      reminders.sort((a, b) {
        Timestamp timestampA = Timestamp.fromDate(a.reminderDateTime);
        DateTime dateTimeA = timestampA.toDate();
        Timestamp timestampB = Timestamp.fromDate(b.reminderDateTime);
        DateTime dateTimeB = timestampB.toDate();
        return dateTimeA.compareTo(dateTimeB);
      });
      if(reminders.length > 3){
        List<ReminderModel> threeReminders = reminders.sublist(0, 3);
        return threeReminders;
      }
      else{
        return reminders;
      }
  });
  // Streams for data in the Schedule
  Stream<List<ScheduleModel>> scheduleDataHome() {
    // Set the start of the selected date
    DateTime startOfSelectedDate =DateTime.now();
  // Set the end of the selected date
    DateTime endOfSelectedDate = startOfSelectedDate.add(Duration(days: 1));
    return userCollection
        .doc(this.uid)
        .collection(scheduleCollection)
        .limit(3)
        .where('isDeleted', isEqualTo: false)
        .where('schedDateTime', isGreaterThanOrEqualTo: startOfSelectedDate)
        .where('schedDateTime', isLessThan: endOfSelectedDate)
        .orderBy('schedDateTime', descending: false)
        .snapshots()
        .map((element) => _dataListFromSnapshot(scheduleCollection, element)
            as List<ScheduleModel>);
  }
}
