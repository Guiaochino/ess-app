
import 'package:ess_app/guardian/settings/settings_home.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'change_password.dart';

class EmailVerificationSentChangePass extends StatefulWidget {
  const EmailVerificationSentChangePass({Key? key}) : super(key: key);

  @override
  State<EmailVerificationSentChangePass> createState() => _EmailVerificationSentChangePassState();
}

class _EmailVerificationSentChangePassState extends State<EmailVerificationSentChangePass> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backColor,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    child: SettingsHomePage(),
                    type: PageTransitionType.leftToRight,
                  ),
                );
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 30,
              ),),
        ),
        body: SafeArea(
          child: Container(
            color: AppColors.backColor,
            child: Center(
                child: ListView(
              children: [
                SizedBox(height: 20.0),
                //Email Verification
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Email Verification',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                //yellow container
                Container(
                  margin: EdgeInsets.only(top: height * 0.03),
                  height: height * 0.85,
                  decoration: BoxDecoration(
                      color: Color(0xFFF2BA05),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      )),
                  child: Column(
                    children: [
                      //verification code
                      SizedBox(height: 30),
                      //resend
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: (Text(
                            'Resend',
                            style: TextStyle(
                              color: Color(0xFFE86166),
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          )),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      //text
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45.0),
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Column(children: [
                            Text(
                              "If you haven't received the email, check your Spam Folder",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 80, 80, 80),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Please click resend, if there are no emails received',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 80, 80, 80),
                              ),
                            )
                          ]),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      //send email
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChangePassword()));
                            },
                            child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Color(0xFF333333),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                    child: Text('Verify',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        )))),
                          ),
                        )),
                      ),
                      SizedBox(height: 20.0),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 40,
                          left: 40,
                          right: 40,
                        ),
                        child: Container(
                            child: Image.asset(
                          'assets/images/InternetSecurity.png',
                          height: 40,
                        )),
                      ))
                    ],
                  ),
                )
              ],
            )),
          ),
        ));
  }
}