import 'dart:async';

import 'package:ess_app/login/email_verification.dart';
import 'package:ess_app/login/login_page.dart';
import 'package:ess_app/services/auth.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class EmailVerificationSent extends StatefulWidget {
  final String email;
  const EmailVerificationSent({Key? key, required this.email}) : super(key: key);

  @override
  State<EmailVerificationSent> createState() => _EmailVerificationSentState();
}

class _EmailVerificationSentState extends State<EmailVerificationSent> {

  final _auth = AuthServices();
  bool _isButtonEnabled = true;
  int _countdown = 30;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
                    child: EmailVerification(),
                    type: PageTransitionType.leftToRight,
                  ),
                );
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            color: AppColors.backColor,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 30.0),
                  //Email Verification
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Password Reset Verification',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  //yellow container
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.firstColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        children: [
                          //verification code
                          SizedBox(height: 30),
                          //resend
                          Padding(
                            padding:const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: (){
                                  if (_isButtonEnabled) {
                                    _auth.ResetPassword(widget.email);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('A password reset email has been sent to the email address.'),
                                      ),
                                    );

                                    setState(() {
                                      _isButtonEnabled = false;
                                      _countdown = 30;
                                    });

                                    _timer = Timer.periodic(Duration(seconds: 1), (_timer) {
                                      setState(() {
                                        if (_countdown > 0) {
                                          _countdown--;
                                        } else {
                                          _timer.cancel();
                                          _isButtonEnabled = true;
                                        }
                                      });
                                    });
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    !_isButtonEnabled ? 
                                    Text(
                                      '[$_countdown]',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                      ),
                                    )
                                    : Container(),
                                    SizedBox(width: 5),
                                    Text(
                                      'Resend',
                                      style: TextStyle(
                                        color: _isButtonEnabled ? Color.fromARGB(255, 212, 17, 3) : Colors.grey[600],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          //text
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
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
                                ),
                              ]),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          //send email
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      PageTransition(
                                        child: LoginPage(),
                                        type: PageTransitionType.rightToLeft,
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.grey[900]),
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.black),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ))),
                                  child: Container(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Done',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

}
