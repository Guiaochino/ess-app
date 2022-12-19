import 'package:ess_app/login/login_page.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: (Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 30,
                )),
          )),
        ),
        body: SafeArea(
          child: Container(
            child: Center(
                child: ListView(
              children: [
                SizedBox(height: 20.0),
                //create an account
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: (Text(
                      'Create an Account',
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
                      //Username
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
                                  hintText: 'Username',
                                  contentPadding: EdgeInsets.only(
                                    top: 25,
                                    bottom: 25,
                                    left: 10,
                                    right: 10,
                                  ))),
                        )),
                      ),
                      //Email
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                                  hintText: 'Email',
                                  contentPadding: EdgeInsets.only(
                                    top: 25,
                                    bottom: 25,
                                    left: 10,
                                    right: 10,
                                  ))),
                        )),
                      ),
                      //Password
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                                  hintText: 'Password',
                                  contentPadding: EdgeInsets.only(
                                    top: 25,
                                    bottom: 25,
                                    left: 10,
                                    right: 10,
                                  ))),
                        )),
                      ),
                      //Confirm Password
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                                  hintText: 'Confirm Password',
                                  contentPadding: EdgeInsets.only(
                                    top: 25,
                                    bottom: 25,
                                    left: 10,
                                    right: 10,
                                  ))),
                        )),
                      ),
                      SizedBox(height: 20),
                      //Register
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                            },
                            child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Color(0xFF333333),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                    child: Text('Register',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        )))),
                          ),
                        )),
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                                },
                                child: Text(
                                  ' Log in',
                                  style: TextStyle(
                                    color: Color(0xFFE86166),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ]),
                      )
                    ],
                  ),
                )
              ],
            )),
          ),
        ));
  }
}
