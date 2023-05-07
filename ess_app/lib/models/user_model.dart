
class UserModel {

  final String uid;
  String? email = "";
  String? guardianName = "Guardian";
  String? patientName = "Elderly";
  bool isDeleted = false;

  // constructor
  UserModel({ 
    required this.uid, 
    required this.email,
    this.guardianName,
    this.patientName,
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