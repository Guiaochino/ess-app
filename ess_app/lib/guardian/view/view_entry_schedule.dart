import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../schedule/schedule_home.dart';

class ViewSchedule extends StatefulWidget {
  @override
  State<ViewSchedule> createState() => _ViewScheduleState();
}

class _ViewScheduleState extends State<ViewSchedule> {
  // @override
  // void initState() {
  //   //if no existing data, get the template list
  //   if (_myBox.get("CURRENT_SCHEDULE_LIST") == null) {
  //     db.createDefaultData();
  //     print("no database items");
  //   }
  //   //if theres an existing data, load it
  //   else {
  //     db.loadData();
  //     print(db.ScheduleList);
  //   }
  //   super.initState();
  // }

  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  final titleController = TextEditingController();
  final paragraphController = TextEditingController();

  // void saveSchedule() {
  //   db.ScheduleList.add([
  //     titleController.text,
  //     paragraphController.text,
  //     false,
  //     parseDateToString(_dateTime),
  //   ]);
  //   print(titleController.text);
  //   print(paragraphController.text);
  //   db.updateDataBase();
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ScheduleHomePage()));
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 30,
              )
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: () {
                  //edit
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.black,
                  size: 30,
                )
              ),
            ),
          ],
        ),
        body: SafeArea(
            child: Container(
                child: Center(
                    child: Column(
          children: [
            SizedBox(height: 10.0),
            //how is your day
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: (Text(
                  "What's the event?",
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
            Container(
              height: 50,
              child: Container(
                width: 300,
                child: TextField(
                  controller: titleController,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  decoration: InputDecoration(
                      iconColor: Colors.black,
                      prefixIcon: Icon(Icons.event, size: 30),
                      border: UnderlineInputBorder(),
                      hintText: 'populate Event Title',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            //date and time
            Container(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Color(0xFFE86166),
                            size: 40,
                          ),
                          SizedBox(width: 5.0),
                          Container(
                              child: MaterialButton(
                            onPressed: () async {
                              DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: _dateTime,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2025),
                              );
                              if (newDate == null) return;
                              final newDateTime = DateTime(
                                newDate.year,
                                newDate.month,
                                newDate.day,
                                _dateTime.hour,
                                _dateTime.minute,
                              );
                              setState(() {
                                _dateTime = newDateTime;
                              });
                            },
                            child: Text(
                              DateFormat.yMMMEd().format(_dateTime),
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
                    Expanded(
                      flex: 4,
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
                              child: Text(
                                _timeOfDay.format(context).toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE86166),
                                ),
                              ))
                        ],
                      )),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            //paragraph
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  color: Colors.white,
                  child: TextFormField(
                    enabled: false,
                    controller: paragraphController,
                    maxLines: 40,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      fontSize: 20,
                      height: 2,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        hintText: "populate event details",
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
            
          ],
        )))));
  }
  
}
