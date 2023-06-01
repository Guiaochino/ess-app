import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ess_app/guardian/edit/edit_entry_schedule.dart';
import 'package:ess_app/guardian/schedule/schedule_home.dart';
import 'package:ess_app/models/schedule_model.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class ViewEntrySchedule extends StatefulWidget {
  final ScheduleModel schedule;
  bool _isDone = false;

  ViewEntrySchedule({
    required this.schedule,
    super.key
  }){
    if (schedule.schedDateTime.isBefore(DateTime.now())) {
      _isDone = true;
    }
  }

  @override
  State<ViewEntrySchedule> createState() => _ViewEntryScheduleState();
}

class _ViewEntryScheduleState extends State<ViewEntrySchedule> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backColor,
        elevation: 0,
        title: Text(
          'Schedule',
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                PageTransition(
                  child: ScheduleHomePage(),
                  type: PageTransitionType.leftToRight,
                ),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    child: EditEntrySchedule(selectedSched: widget.schedule),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              )),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: AppColors.backColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: 20.0),
                //how is your day
                Row(
                  children: [
                  Container(
                    width: 5,
                    height: 30,
                    decoration: BoxDecoration(
                      color: widget._isDone? Colors.green: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(width: 5),
                    Expanded(
                      child: AnimatedTextKit(
                        totalRepeatCount: 1,
                        animatedTexts: [
                          TyperAnimatedText(
                            widget.schedule.schedTitle,
                            textStyle: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.w700
                            ),
                          )
                        ],
                      )
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.firstColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.black,
                        ),
                        SizedBox(width: 5),
                        Text(
                          DateFormat('EEE, MMMM d, yyyy').format(widget.schedule.schedDateTime),
                          overflow: TextOverflow.ellipsis, 
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.firstColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.watch_later,
                          color: Colors.black,
                        ),
                        SizedBox(width: 5),
                        Text(
                          DateFormat('h:mm a').format(widget.schedule.schedDateTime),
                          overflow: TextOverflow.ellipsis, 
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      color: AppColors.secondColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: AnimatedTextKit(
                        totalRepeatCount: 1,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            widget.schedule.schedDetails,
                            textAlign: TextAlign.justify,
                            textStyle: TextStyle(
                              height: 1.5,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            speed: Duration(milliseconds: 5),
                          )
                        ],
                      )
                    )
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