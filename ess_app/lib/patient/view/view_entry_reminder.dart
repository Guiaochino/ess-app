import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';

import '../reminder/reminder_home.dart';

class ViewReminder extends StatefulWidget {
  const ViewReminder({Key? key}) : super(key: key);

  @override
  State<ViewReminder> createState() => _ViewReminderState();
}

class _ViewReminderState extends State<ViewReminder> {
  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: (IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReminderHomePage()));
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
                    child: Column(
          children: [
            SizedBox(height: 10.0),
            //add daily reminder
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: (Text(
                  'Add Daily Reminder',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 35,
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
            SizedBox(height: 20.0),
            //diary title
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                child: Container(
                  width: 300,
                  child: TextField(
                    textAlign: TextAlign.center,
                    enabled: false,
                    decoration: InputDecoration(
                        iconColor: Colors.black,
                        prefixIcon: Icon(Icons.notifications, size: 30),
                        border: UnderlineInputBorder(),
                        hintText: 'Enter Reminder Title',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  height: 80,
                  child: Center(
                    child: GroupButton(
                      isRadio: false,
                      buttons: [
                        'S U N',
                        'M O N',
                        'T U E',
                        'W E D',
                        'T H U',
                        'F R I',
                        'S A T',
                      ],
                      options: GroupButtonOptions(
                        selectedColor: Color(0xFFE86166),
                        unselectedColor: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        buttonHeight: 50,
                        buttonWidth: 70,
                        spacing: 10,
                        direction: Axis.horizontal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            //time
            Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Expanded(
                  flex: 5,
                  child: Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.watch_later,
                        color: Color(0xFFE86166),
                        size: 40,
                      ),
                      SizedBox(width: 5.0),
                      Container(
                          child: MaterialButton(
                        onPressed: _showTimePicker,
                        child: Text(
                          _timeOfDay.format(context).toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE86166),
                          ),
                        ),
                      ))
                    ],
                  )),
                ),
              ),
            ),
            SizedBox(height: 20),
            //paragraph
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  color: Colors.white,
                  child: TextFormField(
                    maxLines: 40,
                    keyboardType: TextInputType.multiline,
                    enabled: false,
                    style: TextStyle(
                      fontSize: 20,
                      height: 2,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        hintText: 'What happened today?',
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            //save button

            SizedBox(height: 20),
          ],
        )))));
  }

  MaterialStateProperty<Color> getButtonColor(Color color, Color colorPressed) {
    final getButtonColor = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    };
    return MaterialStateProperty.resolveWith(getButtonColor);
  }
}
