import 'package:ess_app/constants.dart';
import 'package:ess_app/guardian/home/guardian_home.dart';
import 'package:ess_app/models/user_model.dart';
import 'package:ess_app/guardian/home/patient_home.dart';
import 'package:ess_app/services/auth.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChoicePage extends StatefulWidget {
  const ChoicePage({Key? key}) : super(key: key);

  @override
  State<ChoicePage> createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? _userPreference;

  @override
  void initState() {
    super.initState();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        _userPreference = prefs.getString(userPreferenceKey);
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          color: AppColors.backColor,
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
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                      
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
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      )
                    ]
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      userPreference = patientPreference;
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString(userPreferenceKey, patientPreference);

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              StreamProvider<UserModel?>.value(
                            value: AuthServices().user,
                            initialData: null,
                            child: patientHomePage(),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.elderly,
                            color: Colors.black,
                            size: 100,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'ELDERLY',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              //guardian
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF2BA05),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      )
                    ]
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      userPreference = guardianPreference;
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString(userPreferenceKey, guardianPreference);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              StreamProvider<UserModel?>.value(
                                value: AuthServices().user,
                                initialData: null,
                                child: guardianHomePage(),
                              )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
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
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

}
