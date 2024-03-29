import 'package:ess_app/models/user_model.dart';
import 'package:ess_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user object for data to be passed in to models of user
  UserModel _userFromFirebase(User? user) {
    return UserModel(uid: user!.uid, email: user.email);
  }

  // Auth change user stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  // Signin with email & password
  Future SignInEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        if (user.emailVerified) {
          return _userFromFirebase(user);
        }
      }
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  // Register with email and password
  Future SignUpEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // create new document for user with uid
      if (user != null) {
        await verifyEmail(user);
        await DatabaseService(uid: user.uid)
            .createUserData(new UserModel(uid: user.uid, email: user.email, guardianName: 'guardian', patientName: 'elderly',));
      }
      return _userFromFirebase(user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  // Verify Email
  Future verifyEmail(User user) async {
    return await user.sendEmailVerification();
  }

  // Signout
  Future SignOut() async {
    try {
      return await _auth.signOut();
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  Future<bool> ResetPassword(String email,) async {
  try {
    await _auth.sendPasswordResetEmail(email: email);
    print('Success email to $email');
    return false;
  } catch (err) {
    print(err.toString());
    return true;
  }
}

  Future<void> changePassword(String newPassword) async {
    User? user = await _auth.currentUser!;
    await user.updatePassword(newPassword);
  }
}
