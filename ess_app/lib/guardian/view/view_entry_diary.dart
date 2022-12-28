import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../memory/memory_home_page.dart';

class ViewEntryDiary extends StatefulWidget {
  const ViewEntryDiary({Key? key}) : super(key: key);

  @override
  State<ViewEntryDiary> createState() => _ViewEntryDiaryState();
}

class _ViewEntryDiaryState extends State<ViewEntryDiary> {
  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: 
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MemoryHomePage()));
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
                  "What's on your mind?",
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
                    enabled: false,
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
                        hintText: 'populate title here',
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
                    enabled: false,
                    maxLines: 40,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      fontSize: 20,
                      height: 2,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        hintText: 'populate text here',
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
}
