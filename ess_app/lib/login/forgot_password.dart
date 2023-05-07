import 'package:ess_app/login/login_page.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final TextEditingController newPassController = TextEditingController();
  final TextEditingController passConfirmController = TextEditingController();
  bool _errorLogin = false;

  void dispose() {
    newPassController.dispose();
    passConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.backColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(PageTransition(
              child: LoginPage(),
              type: PageTransitionType.leftToRight,
            ));
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
            child: ListView(
              children: [
                SizedBox(height: 20.0),
                //forgot password
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Text(
                          'Type your new and old password',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 80, 80, 80),
                          ),
                        ),
                        SizedBox(height: 20),
                        _errorLogin
                        ? Column(
                          children: [
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: Text(
                                  "Passwords don't match.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        )
                        : Container(),
                        //new password
                        Container(
                          child: TextField(
                            style: TextStyle(
                              fontSize: 18.0,
                              height: 1.0,
                              color: Colors.black,
                            ),
                            controller: newPassController,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
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
                              hintText: 'New Password',
                              contentPadding: EdgeInsets.only(
                                top: 25,
                                bottom: 25,
                                left: 10,
                                right: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: TextField(
                            style: TextStyle(
                              fontSize: 18.0,
                              height: 1.0,
                              color: Colors.black,
                            ),
                            controller: passConfirmController,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
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
                              hintText: 'Confirm New Password',
                              contentPadding: EdgeInsets.only(
                                top: 25,
                                bottom: 25,
                                left: 10,
                                right: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        //done button
                        ElevatedButton(
                          onPressed: () {
                            if (newPassController.text == passConfirmController.text) {
                              //TODO: add function that changes the auth password here
                              final String _newPass = newPassController.text;
                              
                              Navigator.of(context).push(
                                PageTransition(
                                  child: LoginPage(),
                                  type: PageTransitionType.leftToRight,
                                ),
                              );
                            }
                            else{
                              setState(() {
                                _errorLogin = true;
                              });
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey[900]),
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
}
