
import 'package:ess_app/patient/edit/edit_entry_diary.dart';
import 'package:ess_app/patient/memory/memory_home_page.dart';
import 'package:ess_app/utils/dateTime_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewEntryDiary extends StatelessWidget {
  final int entryIndex;
  final int emoteRate;
  final String title;
  final String dateTime;
  final String details;

  const ViewEntryDiary({
    required this.entryIndex,
    required this.title,     
    required this.dateTime,
    required this.details,
    super.key, required this.emoteRate
  });

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
                  MaterialPageRoute(builder: (context) => MemoryHomePage(activePage: 1,)));
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
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EditEntryDiary(editIndex: entryIndex)));
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
                SizedBox(height: 20.0),
                //diary title
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon(emoteRate),
                          size: 50,
                          color: iconColor(emoteRate),
                          ),
                        SizedBox(width: 10),
                        Text(
                          title,            
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
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
                                    extractDatefromDTString(dateTime),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFE86166),
                                    ),
                                  )
                                )
                              ],
                            )
                          ),
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
                                    extractTimefromDTString(dateTime),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFE86166),
                                    ),
                                  )
                                )
                              ],
                            )
                          ),
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
                        initialValue: details,
                        textAlign: TextAlign.justify,
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
                          )
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //save button

                SizedBox(height: 20),
              ],
            )
          )
        )
      )
    );
  }
  IconData icon(int index){
    IconData iconRate = Icons.sentiment_neutral_outlined;
    switch (index){
      case 1:
      iconRate = Icons.sentiment_very_dissatisfied_outlined;
      break;
      case 2:
      iconRate = Icons.sentiment_very_dissatisfied;
      break;
      case 3:
      iconRate = Icons.sentiment_dissatisfied;
      break;
      case 4:
      iconRate = Icons.sentiment_neutral_rounded;
      break;
      case 5:
      iconRate = Icons.sentiment_satisfied;
      break;
      case 6:
      iconRate = Icons.sentiment_satisfied_outlined;
      break;
      case 7:
      iconRate = Icons.sentiment_very_satisfied_outlined;
      break;
    }
    return iconRate;
  }
  Color iconColor(int index){
    Color iconColor = Colors.grey;
    switch (index){
      case 1:
      iconColor = Colors.red;
      break;
      case 2:
      iconColor = Color.fromARGB(255, 204, 0, 112);
      break;
      case 3:
      iconColor = Color.fromARGB(255, 192, 0, 160);
      break;
      case 4:
      iconColor = Color.fromARGB(255, 255, 197, 6);
      break;
      case 5:
      iconColor = Color.fromARGB(255, 10, 72, 187);
      break;
      case 6:
      iconColor = Color.fromARGB(255, 241, 110, 35);
      break;
      case 7:
      iconColor = Color.fromARGB(255, 12, 148, 0);
      break;
    }
    return iconColor;
  }
}
