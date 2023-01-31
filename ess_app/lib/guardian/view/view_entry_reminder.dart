import 'package:ess_app/guardian/edit/edit_entry_reminder.dart';
import 'package:ess_app/guardian/reminder/reminder_home.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:ess_app/utils/dateTime_formatter.dart';
import 'package:flutter/material.dart';

class ViewReminder extends StatelessWidget {
  final int entryIndex;
  final String title;
  final String dateTime;
  final String details;

  const ViewReminder({
    required this.entryIndex,
    required this.title,     
    required this.dateTime,
    required this.details,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ReminderHomePage(activePage: 0,)));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 30,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                //edit
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EditEntryReminder(editIndex: entryIndex)));
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
          color: AppColors.backColor,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10.0),
                //add daily reminder
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: (Text(
                      'Daily Reminder',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.grey,
                            offset: Offset(5.0, 5.0),
                          ),
                        ],
                      ),
                    )),
                  ),
                ),
                SizedBox(height: 20.0),
                //reminder title
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 300,
                    child: Text(
                      title,            
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold
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
                              size: 55,
                            ),
                            SizedBox(width: 5.0),
                            Container(
                              child: Text(
                                extractTimefromDTString(dateTime),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFE86166),
                                ),
                              )
                            )
                          ],
                        )
                      ),
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
                        initialValue: details,
                        enabled: false,
                        maxLines: 40,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          fontSize: 20,
                          height: 2,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                            hintText: 'Enter details here...',
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
                Expanded(
                  flex: 2,
                  child:Container(),
                ),
                SizedBox(height: 20),
                //save button
                
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}