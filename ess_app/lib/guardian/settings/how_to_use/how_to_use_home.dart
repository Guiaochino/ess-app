import 'package:ess_app/guardian/settings/how_to_use/memory_diary_htu.dart';
import 'package:ess_app/guardian/settings/how_to_use/reminder_schedule_htu.dart';
import 'package:ess_app/guardian/settings/settings_home.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class HowToUseHome extends StatelessWidget {
  const HowToUseHome({Key? key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 200, 82),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 236, 200, 82),
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.of(context).push(
              PageTransition(
                child: SettingsHomePage(),
                type: PageTransitionType.leftToRight,
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                'How to Use?',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Get started with these simple steps to make the most of the app!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            'Memory & Diary',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Explore and manage your memories and diary entries.',
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              PageTransition(
                                child: MemoryDiaryTutorialPage(),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Divider(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          tileColor: Colors.white,
                          title: Text(
                            'Schedule & Reminder',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Organize your schedule and set reminders for important events.',
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              PageTransition(
                                child: ReminderScheduleTutorialPage(),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}