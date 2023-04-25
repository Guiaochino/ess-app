import 'package:ess_app/guardian/edit/edit_entry_schedule.dart';
import 'package:ess_app/guardian/schedule/schedule_home.dart';
import 'package:ess_app/models/schedule_model.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:ess_app/utils/dateTime_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewEntrySchedule extends StatelessWidget {
  final ScheduleModel schedule;

  const ViewEntrySchedule({
    required this.schedule,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backColor,
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
                  Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EditEntrySchedule(selectedSched: schedule)));
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
            //how is your day
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: (Text(
                  "Schedule Details",
                  textAlign: TextAlign.center,
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
            //schedule title
            Container(
              width: 300,
              child: Text(
                schedule.schedTitle,            
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold
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
                              schedule.schedDateTime.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE86166),
                              ),
                            )
                          )
                        ],
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
                                schedule.schedDateTime.toString(),
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
            //paragraph
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  color: Colors.white,
                  child: TextFormField(
                    enabled: false,
                    initialValue: schedule.schedDetails,
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