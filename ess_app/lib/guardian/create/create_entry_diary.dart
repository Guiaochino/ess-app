import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../memory/memory_home_page.dart';

class CreateEntryDiary extends StatefulWidget {
  const CreateEntryDiary({Key? key}) : super(key: key);

  @override
  State<CreateEntryDiary> createState() => _CreateEntryDiaryState();
}

class _CreateEntryDiaryState extends State<CreateEntryDiary> {
  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MemoryHomePage()));
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
            //how is your day
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: (Text(
                  'How is your day?',
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
                  width: 250,
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                    ),
                    decoration: InputDecoration(
                        iconColor: Colors.black,
                        prefixIcon: Icon(Icons.auto_stories, size: 30),
                        border: UnderlineInputBorder(),
                        hintText: 'Enter Diary Title',
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
            //date and time
            Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                              child: Text(
                            DateFormat('MM-dd-yyyy').format(DateTime.now()),
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
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
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
                              child: Text(
                            TimeOfDay.now().format(context).toString(),
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
            //recording button
            SizedBox(height: 20),
            //paragraph
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  color: Colors.white,
                  child: TextFormField(
                    maxLines: 40,
                    keyboardType: TextInputType.multiline,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    color: Color(0xFFF2BA05),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.save_alt,
                      size: 35,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        )))));
  }
}
