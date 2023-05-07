import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ess_app/login/create_account.dart';
import 'package:ess_app/services/auth.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ess_app/login/email_verification.dart';

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
  bool _errorLogin = false;

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
      resizeToAvoidBottomInset: true,
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
                    ))),
              ),
              SizedBox(height: 20),
              _errorLogin
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.secondColor,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                              'Invalid Credentials.',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),),
                    )
                  : Container(),
              SizedBox(height: 20),
              //emailfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      controller:
                          emailController, // Email Controller for inputs
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
                      textAlignVertical: TextAlignVertical.center,
                      obscureText: true,
                      controller:
                          passwordController, // Password Controller for inputs
                      keyboardType: TextInputType.visiblePassword,
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
                      Navigator.of(context).push(
                        PageTransition(
                          child: EmailVerification(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: MaterialButton(
                  onPressed: () async {
                    dynamic result = await _auth.SignInEmailPassword(
                        emailController.text.trim(),
                        passwordController.text.trim());
                    print(result);
                    if (result == null) {
                      setState(() {
                        _errorLogin = true;
                        emailController.clear();
                        passwordController.clear();
                      });
                    } else {
                      print("Login Successfully!");
                      Navigator.of(context).push(
                        PageTransition(
                          child: ChoicePage(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFFF2BA05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'No Account Yet?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: CreateAccount(),
                        type: PageTransitionType.rightToLeft,
                      ),
                    );
                  },
                  child: Text(
                    ' Sign up now!',
                    style: TextStyle(
                      color: Color.fromARGB(255, 241, 83, 72),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
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
