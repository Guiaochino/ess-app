import 'dart:async';

import 'package:ess_app/constants.dart';
import 'package:ess_app/guardian/home/patient_home.dart';
import 'package:ess_app/guardian/settings/change_password/change_password.dart';
import 'package:ess_app/guardian/settings/change_password/email_verification_sent.dart';
import 'package:ess_app/login/login_page.dart';
import 'package:ess_app/models/user_model.dart';
import 'package:ess_app/services/auth.dart';
import 'package:ess_app/services/database.dart';
import 'package:ess_app/services/notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../home/guardian_home.dart';

class SettingsHomePage extends StatefulWidget {
  const SettingsHomePage({super.key});

  @override
  State<SettingsHomePage> createState() => _SettingsHomePageState();
}

class _SettingsHomePageState extends State<SettingsHomePage> {
  UserModel user = UserModel(uid: '', email: '');
  late TextEditingController guardianController;
  late TextEditingController patientController;
  late StreamSubscription<UserModel> _userStream;

  String guardianName = '';
  String patientName = '';

  final dbconn = DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);

  
  @override
  void initState(){
    
    super.initState();
    _subscribeToStreams();
    guardianController = TextEditingController();
    patientController = TextEditingController();
  }

  void _subscribeToStreams() {
    _userStream = dbconn.userData.listen((data) {
      setState(() {
        user = data;
        guardianName = data.guardianName!;
        patientName = data.patientName!;
      });
    });
  }

  @override
  void dispose(){
    guardianController.dispose();
    patientController.dispose();
    _userStream.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE86166),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            if (userPreference == guardianPreference) {
              Navigator.of(context).push(
                PageTransition(
                  child: guardianHomePage(),
                  type: PageTransitionType.leftToRight,
                ),
              );
            } else {
              Navigator.of(context).push(
                PageTransition(
                  child: patientHomePage(),
                  type: PageTransitionType.leftToRight,
                ),
              );
            }
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          'SETTINGS',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                //profile
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Guardian',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                //guardian container
                GestureDetector(
                  onTap: () async{
                    final guardianName = await openGuardianDialog();
                    if(guardianName == null || guardianName.isEmpty) {
                      setState(() {
                        this.guardianName = 'Guardian';
                      });
                    } else {
                      setState(() {
                        this.guardianName = user.guardianName!;
                      });
                    };
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.sports_kabaddi,
                        size: 50,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                guardianName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                'Edit personal details',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Patient',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                //patient container
                GestureDetector(
                  onTap: () async{
                    final patientName = await openPatientDialog();
                    if(patientName == null || patientName.isEmpty) {
                      setState(() {
                        this.patientName = 'Patient';
                      });
                    } else {
                      setState(() {
                        this.patientName = user.patientName!;
                      });
                    };
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.elderly_woman,
                        size: 50,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                patientName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                'Edit personal details',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                //change password container
                GestureDetector(
                  onTap:(){
                    NotificationService.syncNotifications(FirebaseAuth.instance.currentUser!.uid);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.sync,
                        size: 40,
                        color: Colors.black,
                      ),
                      SizedBox(width: 30.0),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Sync Notifications',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Account',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                //change password container
                GestureDetector(
                  onTap:(){
                    Navigator.of(context).push(
                      PageTransition(
                        child: ChangePassword(),
                        type: PageTransitionType.leftToRight,
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock_reset_rounded,
                        size: 40,
                        color: Colors.black,
                      ),
                      SizedBox(width: 30.0),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Change Password',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                //logout button
                GestureDetector(
                  onTap: () async {
                    
                    openLogoutDialog();
                  },
                  child: Container(
                    height: 80,
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout_outlined,
                          size: 40,
                          color: Colors.black,
                        ),
                        SizedBox(width: 30.0),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              'Logout',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<String?> openGuardianDialog() => showDialog<String>(
    context: context, 
    builder: (context)=> AlertDialog(
      title: Text('Guardian Name'),
      content: TextField(
        decoration: InputDecoration(
          hintText: guardianName,
        ),
        controller: guardianController,
      ),
      actions: [
        TextButton(
          onPressed: submitGuardian, 
          child: Text(
            'SUBMIT',
            style: TextStyle(
              color: Color(0xFFE86166),
            ),
          )
        )
      ],
    )
  );
  Future<String?> openPatientDialog() => showDialog<String>(
    context: context, 
    builder: (context)=> AlertDialog(
      title: Text('Patient Name'),
      content: TextField(
        decoration: InputDecoration(
          hintText: patientName,
        ),
        controller: patientController,
      ),
      actions: [
        TextButton(
          onPressed: submitPatient, 
          child: Text(
            'SUBMIT',
            style: TextStyle(
              color: Color(0xFFE86166),
            ),
          )
        )
      ],
    )
  );

  //submit names
  Future<void> submitGuardian() async {
    dbconn.updateGuardianName(guardianController.text);
    Navigator.of(context).pop(guardianController.text);
    guardianController.clear();
  }
  Future <void> submitPatient() async {
    dbconn.updatePatientName(patientController.text);
    Navigator.of(context).pop(patientController.text);
    patientController.clear();
  }
  
  //log out
  Future openLogoutDialog() => showDialog(
    context: context, 
    builder: (context)=> AlertDialog(
      title: Text('Logout'),
      content: Text(
        'Are you sure you want to logout?'
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await AuthServices().SignOut();
            Navigator.of(context).push(
                PageTransition(
                  child: LoginPage(),
                  type: PageTransitionType.rightToLeft,
                ),
              );
          }, 
          child: Text(
            'Logout',
            style: TextStyle(
              color: Color(0xFFE86166),
            ),
          )
        ),
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Color(0xFFE86166),
            ),
          )
        )
      ],
    )
  );

}