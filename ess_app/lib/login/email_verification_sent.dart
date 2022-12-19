import 'package:ess_app/login/email_verification.dart';
import 'package:ess_app/login/forgot_password.dart';
import 'package:flutter/material.dart';

class EmailVerificationSent extends StatefulWidget {
  const EmailVerificationSent({Key? key}) : super(key: key);

  @override
  State<EmailVerificationSent> createState() => _EmailVerificationSentState();
}

class _EmailVerificationSentState extends State<EmailVerificationSent> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: (IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EmailVerification()));
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 30,
              ))),
        ),
        body: SafeArea(
          child: Container(
            child: Center(
                child: ListView(
              children: [
                SizedBox(height: 20.0),
                //Email Verification
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: (Text(
                      'Email Verification',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.grey,
                            offset: Offset(5.0, 5.0),
                          ),
                        ],
                      ),
                    )),
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
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                          left: 30,
                          right: 30,
                        ),
                        child: Container(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                              style: (TextStyle(
                                  fontSize: 18.0,
                                  height: 1.0,
                                  color: Colors.black)),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      )),
                                  hintText: 'Enter Verification Code Here',
                                  contentPadding: EdgeInsets.only(
                                    top: 25,
                                    bottom: 25,
                                    left: 10,
                                    right: 10,
                                  ))),
                        )),
                      ),
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
                                  builder: (context) => ForgotPassword()));
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
                          'images/InternetSecurity.png',
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
