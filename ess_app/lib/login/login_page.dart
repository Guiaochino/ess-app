import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ess_app/login/create_account.dart';
import 'package:ess_app/login/email_verification.dart';
import 'package:ess_app/login/forgot_password.dart';
import 'package:ess_app/services/auth.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'choice_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _auth = AuthServices();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: AppColors.firstColor,
                  child: Center(
                    child: Image.asset(
                  'assets/images/geriAssisTransparent.png',
                  fit: BoxFit.cover,
                )
                  )
                ),
              ),
              SizedBox(height: 40),
              //emailfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: emailController, // Email Controller for inputs
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        prefixIcon: Icon(Icons.account_box_rounded),
                        hintText: 'Username/Email',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              //passwordfield
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController, // Password Controller for inputs
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              //forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EmailVerification()));
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),

                //signin button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: MaterialButton(
                    onPressed: () async {
                      dynamic result = await _auth.SignInEmailPassword(emailController.text.trim(), passwordController.text.trim());
                      if (result == null) {
                        print("Error in Signin");
                      } else {
                        print("Login Successfully!");
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChoicePage()));
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Color(0xFFF2BA05),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                            child: Text('Log In',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )))),
                  ),
                ),
              SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  Text(
                    'No Account Yet?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateAccount()));
                    },
                    child: Text(
                      ' Sign up now!',
                      style: TextStyle(
                        color: Color.fromARGB(255, 241, 83, 72),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ]
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  //login failed dialog
  AwesomeDialog loginErrorDialog(BuildContext context) {
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
      title: 'Login Failed!',
      desc: 'Incorrect Credentials.',
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

