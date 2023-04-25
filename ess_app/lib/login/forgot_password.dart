import 'package:ess_app/login/login_page.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
                SizedBox(height: 20.0),
                //forgot password
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.grey,
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
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
                                'Please enter a new password',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 80, 80, 80),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //new password
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 30,
                            right: 30,
                          ),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 18.0,
                                  height: 1.0,
                                  color: Colors.black
                                ),
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
                          ),
                        ),
                        SizedBox(height: 20),
                        //done button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF333333),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Done',
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
