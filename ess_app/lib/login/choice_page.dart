import 'package:ess_app/guardian/home/home_page.dart';
import 'package:ess_app/patient/home/home_page.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class ChoicePage extends StatefulWidget {
  const ChoicePage({Key? key}) : super(key: key);

  @override
  State<ChoicePage> createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
            child: Container(
          child: Center(
              child: ListView(children: [
            SizedBox(height: 30),
            //who are you
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: (Text(
                  'Who Are You?',
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
            SizedBox(height: 70),
            //Patient
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFE86166),
                      borderRadius: BorderRadius.circular(20)),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => patientHomePage()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.elderly,
                            color: Colors.black,
                            size: 100,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'PATIENT',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            SizedBox(height: 30),
            //guardian
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFF2BA05),
                      borderRadius: BorderRadius.circular(20)),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => guardianHomePage()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.sports_kabaddi,
                            color: Colors.black,
                            size: 100,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'GUARDIAN',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ])),
        )));
  }
}
