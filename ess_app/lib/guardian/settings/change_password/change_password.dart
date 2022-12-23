import 'package:ess_app/login/login_page.dart';
import 'package:flutter/material.dart';

import '../settings_home.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: (IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SettingsHomePage()));
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
                //forgot password
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: (Text(
                      'Change Password',
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
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                          left: 45,
                          right: 30,
                        ),
                        child: Container(
                          child: Container(
                              child: (Text(
                            'Please enter a new password',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 80, 80, 80),
                            ),
                          ))),
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
                                  hintText: 'New Password',
                                  contentPadding: EdgeInsets.only(
                                    top: 25,
                                    bottom: 25,
                                    left: 10,
                                    right: 10,
                                  ))),
                        )),
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
                                  builder: (context) => SettingsHomePage()));
                            },
                            child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Color(0xFF333333),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                    child: Text('Done',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        )))),
                          ),
                        )),
                      ),
                    ],
                  ),
                )
              ],
            )),
          ),
        ));
  }
}
