import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ess_app/login/email_verification_sent.dart';
import 'package:ess_app/login/login_page.dart';
import 'package:ess_app/services/auth.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final TextEditingController email_su_controller = TextEditingController();

  final _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginPage()));
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
                  'Password Reset',
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
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                          child: Container(
                            child: Text(
                              'Type your email, and wait for verification',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 80, 80, 80),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Email Address
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 20,
                          right: 20,
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              style: TextStyle(
                                fontSize: 18.0,
                                height: 1.0,
                                color: Colors.black,
                              ),
                              controller: email_su_controller,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                hintText: 'Email Address',
                                contentPadding: EdgeInsets.only(
                                  top: 25,
                                  bottom: 25,
                                  left: 10,
                                  right: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: ElevatedButton(
                              onPressed: () {
                                _auth.ResetPassword(email_su_controller.text);
                                //TODO: add a send email implementation
                                //_auth.verifyEmail( );
                                Navigator.of(context).push(
                                  PageTransition(
                                    child: EmailVerificationSent(),
                                    type: PageTransitionType.rightToLeft,
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.grey[900]),
                                  overlayColor:
                                      MaterialStateProperty.all(Colors.black),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ))),
                              child: Container(
                                height: 60,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Send Email',
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
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  //email does not exist dialog
  AwesomeDialog emailErrorDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      borderSide: BorderSide(
        color: Color(0xFFE86166),
        width: 2,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      title: 'Verification Failed',
      desc: 'Email does not exist.',
      titleTextStyle: TextStyle(
        color: Colors.red,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      descTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      padding: EdgeInsets.all(15),
      showCloseIcon: false,
      autoHide: Duration(seconds: 3),
    );
  }
}
