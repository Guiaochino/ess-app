import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ess_app/login/account_verification_sent.dart';
import 'package:ess_app/login/login_page.dart';
import 'package:ess_app/services/auth.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController user_su_controller = TextEditingController();
  final TextEditingController email_su_controller = TextEditingController();
  final TextEditingController pass_su_controller = TextEditingController();
  final TextEditingController pass_con_su_controller = TextEditingController();
  bool _errorCreate = false;

  final AuthServices _auth = AuthServices();

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
            Navigator.of(context).push(
              PageTransition(
                child: LoginPage(),
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
                //create an account
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Create an Account',
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
                        //Email
                        SizedBox(height: 30),
                        _errorCreate
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondColor,
                                    borderRadius:
                                        BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Invalid Credentials. Try again',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          )
                        : Container(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
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
                                  hintText: 'Email',
                                  contentPadding: EdgeInsets.only(
                                    top: 15,
                                    bottom: 15,
                                    left: 10,
                                    right: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //Password
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                obscureText: true,
                                controller: pass_su_controller,
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
                                  hintText: 'Password',
                                  contentPadding: EdgeInsets.only(
                                    top: 15,
                                    bottom: 15,
                                    left: 10,
                                    right: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //Confirm Password
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                textAlignVertical: TextAlignVertical.center,
                                obscureText: true,
                                controller: pass_con_su_controller,
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
                                  hintText: 'Confirm Password',
                                  contentPadding: EdgeInsets.only(
                                    top: 15,
                                    bottom: 15,
                                    left: 10,
                                    right: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        //Register
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: MaterialButton(
                                onPressed: () async {
                                  dynamic result =
                                      await _auth.SignUpEmailPassword(
                                          email_su_controller.text.trim(),
                                          pass_su_controller.text.trim());
                                  if (result == null) {
                                    setState(() {
                                      _errorCreate = true;
                                      email_su_controller.clear();
                                      pass_su_controller.clear();
                                      pass_con_su_controller.clear();
                                    });
                                  } else {
                                    Navigator.of(context).push(
                                      PageTransition(
                                        child: LoginPage(),
                                        type: PageTransitionType.rightToLeft,
                                      ),
                                    );
                                  }
                                  
                                },
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF333333),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        //Have and Account?
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Have an Account?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageTransition(
                                      child: LoginPage(),
                                      type: PageTransitionType.rightToLeft,
                                    ),
                                  );
                                },
                                child: Text(
                                  ' Log in',
                                  style: TextStyle(
                                    color: Color(0xFFE86166),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ]
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
