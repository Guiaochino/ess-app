class UserModel {
  final String uid;
  String? email = "";
  String guardianName;
  String patientName;
  bool isDeleted = false;

  // constructor
  UserModel({
    required this.uid,
    required this.email,
    String? guardianName,
    String? patientName,
  })  : this.guardianName = guardianName ?? "Guardian",
        this.patientName = patientName ?? "Elderly";

  Map<String, dynamic> stringMapping() {
    return {
      "uid": uid,
      if (email != null) "email": email,
      "guardianName": guardianName,
      "patientName": patientName,
      "isDeleted": isDeleted,
    };
  }
}
