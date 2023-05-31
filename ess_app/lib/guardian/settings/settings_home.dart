import 'dart:async';
import 'package:ess_app/constants.dart';
import 'package:ess_app/guardian/home/patient_home.dart';
import 'package:ess_app/guardian/settings/change_password/change_password.dart';
import 'package:ess_app/guardian/settings/change_password/email_verification_sent.dart';
import 'package:ess_app/guardian/settings/how_to_use/how_to_use_home.dart';
import 'package:ess_app/login/login_page.dart';
import 'package:ess_app/models/user_model.dart';
import 'package:ess_app/services/auth.dart';
import 'package:ess_app/services/database.dart';
import 'package:ess_app/services/notifications.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ess_app/guardian/home/guardian_home.dart';

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
          color: AppColors.backColor,
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
                //sync notifications
                settingButton(
                  title: 'Sync Notifications', 
                  icon: Icons.sync,
                  onTap: () {
                    showLoadingDialog(context);
                    NotificationService.syncNotifications(FirebaseAuth.instance.currentUser!.uid);
                  },
                ),
                
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'About',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                settingButton(
                  title: 'How to Use', 
                  icon: Icons.info_outline_rounded,
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: HowToUseHome(),
                        type: PageTransitionType.rightToLeft,
                      ),
                    );
                  },
                ),
                SizedBox(height: 10.0),
                settingButton(
                  title: 'About Us', 
                  icon: Icons.logo_dev_rounded,
                  onTap: () {
                    _showAboutDialog(context);
                  },
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
                //change password
                settingButton(
                  title: 'Change Password', 
                  icon: Icons.lock_reset_outlined,
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: ChangePassword(),
                        type: PageTransitionType.rightToLeft,
                      ),
                    );
                  },
                ),
                SizedBox(height: 10.0),
                //logout button
                settingButton(
                  title: 'Logout', 
                  icon: Icons.logout,
                  onTap: () async {
                    openLogoutDialog();
                  },
                ),
                
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
  void showLoadingDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16.0),
                Text('Syncing all notifications'),
              ],
            ),
          ),
        );
      },
    );

    await Future.delayed(Duration(seconds: 4));

    Navigator.pop(context); // Close the dialog after 4 seconds
    // Show the Snackbar message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notifications are synced'),
      ),
    );
  }

}

class settingButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onTap;
  const settingButton({
    super.key, required this.title, required this.icon, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.black,
              ),
              SizedBox(width: 30.0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    title,
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
      ],
    );
  }
}

void _showAboutDialog(BuildContext context) {
  final _imagePageController = PageController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logo_dev),
                      Text(
                        'Developers of GeriAssis',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: PageView.builder(
                      controller: _imagePageController,
                      itemCount: 3, // Replace with the number of pages you want
                      itemBuilder: (BuildContext context, int index) {
                        final _devsName = ['Guiaochino Tiamzon', 'Mychal Esureña', 'Lester Ecaldre'];
                        final _devsRole = ['Back-end', 'Front-end', 'Back-end'];
                        final _devsEmail = ['chinotiamzon@gmail.com', 'tsmmychaalll@gmail.com', 'jlberdlace@gmail.com'];
                        final _devsGithub = ['github.com/Guiaochino', 'github.com/mychaalll', 'github.com/jlbecaldre'];
                        final _devsImg = ['assets/images/chinoTiamzon.jpg', 'assets/images/mychalEsurena.png', 'assets/images/lesterEcaldre.jpg'];
                        return devCard(
                          name: _devsName[index], 
                          role: _devsRole[index], 
                          email: _devsEmail[index], 
                          github: _devsGithub[index], 
                          imgPath: _devsImg[index],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  SmoothPageIndicator(
                    controller: _imagePageController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      activeDotColor:AppColors.secondColor,
                      dotHeight: 8.0,
                      dotWidth: 8.0,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

class devCard extends StatefulWidget {
  final String name, role, email, github, imgPath;
   devCard({
    super.key, required this.name, required this.role, required this.email, required this.github, required this.imgPath,
  });

  @override
  State<devCard> createState() => _devCardState(name: name, role: role, email: email, github: github, imgPath: imgPath,);
}

class _devCardState extends State<devCard> {
  final String name, role, email, github, imgPath;
  bool isPressed = false;
  AlignmentGeometry _alignment = Alignment.bottomLeft;

  _devCardState({
    required this.name, required this.role, required this.email, required this.github, required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          isPressed = true;
        });
      },
      onLongPressEnd: (_){
        setState(() {
          isPressed = false;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration:BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.backColor,
          ),
          child:  Stack(
            fit: StackFit.expand, 
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), 
                  color: Colors.black
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Opacity(
                    opacity: isPressed? 0.2 : 1,
                    child: Image.asset(
                      imgPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: isPressed ? MainAxisAlignment.center: MainAxisAlignment.end,
                  children: [
                    Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    isPressed? Column(
                      children: [
                        SizedBox(height:15),
                        Text(
                          '$role Developer',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              email,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.code,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              github,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                              ),
                            )
                          ],
                        )
                      ],
                    ):Container()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}