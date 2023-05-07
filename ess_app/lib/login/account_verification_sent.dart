import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ess_app/login/create_account.dart';
import 'package:ess_app/login/email_verification.dart';
import 'package:ess_app/login/forgot_password.dart';
import 'package:ess_app/login/login_page.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AccountVerificationSent extends StatefulWidget {
  const AccountVerificationSent({Key? key}) : super(key: key);

  @override
  State<AccountVerificationSent> createState() => _AccountVerificationSent();
}

class _AccountVerificationSent extends State<AccountVerificationSent> {
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
                  MaterialPageRoute(builder: (context) => CreateAccount()));
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
                      'Email Verification',
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
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
                          //done
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
                                    height: 60,
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

  //verification failed dialog
  AwesomeDialog verifErrorDialog(BuildContext context) {
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
      title: 'Verification Failed!',
      desc: 'Codes do not match.',
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
