import 'package:ess_app/guardian/settings/change_password/email_verification.dart';
import 'package:flutter/material.dart';

import '../home/home_page.dart';

class SettingsHomePage extends StatefulWidget {
  const SettingsHomePage({super.key});

  @override
  State<SettingsHomePage> createState() => _SettingsHomePageState();
}

class _SettingsHomePageState extends State<SettingsHomePage> {
  late TextEditingController guardianController;
  late TextEditingController patientController;

  String guardianName = 'sampleGuardianName';
  String patientName = 'samplePatientName';

  @override
  void initState(){
    super.initState();

    guardianController = TextEditingController();
    patientController = TextEditingController();
  }

  @override
  void dispose(){
    guardianController.dispose();
    patientController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE86166),
        elevation: 0,
        leading: (IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => guardianHomePage()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 30,
            ))),
        title: Text(
          'SETTINGS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Expanded(
          child: Container(
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  //profile
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Guardian',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  //guardian container
                  GestureDetector(
                    onTap: () async{
                      final guardianName = await openGuardianDialog();
                      if(guardianName == null || guardianName.isEmpty) return;

                      setState(() {
                        this.guardianName = guardianName;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.sports_kabaddi,
                          size: 75,
                          color: Colors.black,
                        ),
                        SizedBox(width: 5.0),
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  'Edit personal details',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 30,
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
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  //patient container
                  GestureDetector(
                    onTap: () async{
                      final patientName = await openPatientDialog();
                      if(patientName == null || patientName.isEmpty) return;

                      setState(() {
                        this.patientName = patientName;
                      });
                    },
                    child: Container(
                      height: 100,
                      child: Row(
                        children: [
                          Icon(
                            Icons.elderly_woman,
                            size: 75,
                            color: Colors.black,
                          ),
                          SizedBox(width: 5.0),
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
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    'Edit personal details',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 30,
                            color: Colors.black,
                          ),
                        ],
                      ),
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
                        fontSize: 20,
                      ),
                    ),
                  ),
                  //change password container
                  GestureDetector(
                    onTap:(){
                      Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EmailVerificationChangePass()));
                    },
                    child: Container(
                      height: 80,
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
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 30,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //logiut button
                  GestureDetector(
                    onTap: openLogoutDialog,
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
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 30,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
  void submitGuardian(){
    Navigator.of(context).pop(guardianController.text);
    guardianController.clear();
  }
  void submitPatient(){
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
          onPressed: (){}, 
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