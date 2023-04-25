
class UserModel {

  final String uid;
  String? email = "";
  String guardianName = "";
  String patientName = "";
  bool isDeleted = false;

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
  UserModel({ 
    required this.uid, 
    required this.email,
  });

  Map<String, dynamic> stringMapping() {
    return {
      if (uid != null) "uid": uid,
      if (email != null) "email": email,
      if (guardianName != null) "guardianName": guardianName,
      if (patientName != null) "patientName": patientName,
      "isDeleted": isDeleted,
    };
  }
  
}