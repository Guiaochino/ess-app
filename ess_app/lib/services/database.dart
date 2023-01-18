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
  Future updateUserData(String guardian_name, String patient_name) async {
    return await appCollection.doc(this.uid).set({
      'guardian' : guardian_name,
      'patient' : patient_name,
      'diaries' : [],
      'reminders' : [],
      'memories' : [],
      'schedules' : [],
    });
  }

  // get application streams
  Stream<QuerySnapshot> get account {
    return appCollection.snapshots();
  }

}