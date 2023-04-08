
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ess_app/models/diary_model.dart';
import 'package:ess_app/models/user_model.dart';

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

  // Dairy, Memory, Reminder, Schedule will be added as a subCollection to the User Collection
  Future addDiary(DiaryModel diaryData) async{
    return await userCollection.doc(this.uid)
    .collection('diaries')
    .doc(diaryData.uid)
    .set(diaryData.stringMapping());
  }

  // Inserting Updating for Patient and Guardian name
  // For Guardian
  Future updateGuardianName(String guardian_name) async {
    return await userCollection.doc(this.uid).update({'guardianName' : guardian_name}).then((value) => print("Updated Successfully!"));
  }

  // For Patient
  Future updatePatientName(String patient_name) async {
    return await userCollection.doc(this.uid).update({'patientName' : patient_name}).then((value) => print("Updated Successfully"));
  }

}