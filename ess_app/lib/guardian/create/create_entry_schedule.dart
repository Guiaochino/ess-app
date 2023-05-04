import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ess_app/constants.dart';
import 'package:ess_app/guardian/widgets/popup_dialogs.dart';
import 'package:ess_app/models/schedule_model.dart';
import 'package:ess_app/services/database.dart';
import 'package:ess_app/services/notifications.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import '../schedule/schedule_home.dart';
import 'package:ess_app/helpers.dart';

class CreateEntrySchedule extends StatefulWidget {
  @override
  State<CreateEntrySchedule> createState() => _CreateEntryScheduleState();
}

class _CreateEntryScheduleState extends State<CreateEntrySchedule> {

  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  final titleController = TextEditingController();
  final paragraphController = TextEditingController();
  final dbconn = DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);

  void dispose(){
    titleController.dispose();
    paragraphController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.backColor,
        elevation: 0,
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
          )
        ),
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
                    child: Text(
                      "What's the event?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.grey,
                            offset: Offset(5.0, 5.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                //schedule title
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    child: Container(
                      width: width - 40,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        textAlign: TextAlign.center,
                        controller: titleController,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          iconColor: Colors.black,
                          prefixIcon: Icon(Icons.event, size: 30),
                          border: UnderlineInputBorder(),
                          hintText: 'Enter Schedule Title',
                          hintStyle: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                //date
                Container(
                  height: 50,
                  width: width - 40,
                  child: TextField(
                    readOnly: true,
                    textAlignVertical: TextAlignVertical.bottom,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.watch_later),
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
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 5.0,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: DateFormat.yMMMEd().format(_dateTime),
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //time
                Container(
                  height: 50,
                  width: width - 40,
                  child: TextField(
                    readOnly: true,
                    textAlignVertical: TextAlignVertical.bottom,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.watch_later),
                        onPressed: () async {
                          TimeOfDay? newTime = await showTimePicker(
                            context: context,
                            initialTime: _timeOfDay,
                          );
                          if (newTime == null) return;
                          final newDateTime = DateTime(
                            _dateTime.year,
                            _dateTime.month,
                            _dateTime.day,
                            newTime.hour,
                            newTime.minute,
                          );
                          setState(() {
                            _dateTime = newDateTime;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 5.0,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: DateFormat.jm().format(_dateTime),
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                //paragraph
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      child: TextFormField(
                        controller: paragraphController,
                        maxLines: 40,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          fontSize: 18,
                          height: 2,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter details here...',
                          hintStyle: TextStyle(
                            color: Colors.grey[600],
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 5.0,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                height > 670?
                Spacer(
                  flex: 1,
                ): Container(),
                SizedBox(height: 20),
                //save button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    onPressed: (){
                      saveSchedule();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColors.firstColor),
                      overlayColor: MaterialStateProperty.all(Color.fromARGB(255, 230, 177, 5)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )
                      )
                    ),
                    child: Container(
                      height: 50,
                      
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.save,
                            size: 35,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10),
                          width > 280 ?
                          Text(
                            'Save Schedule',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ): Container(),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //saving diary
  void saveSchedule() {

    //null or empty entries
    if(titleController.text == null || titleController.text == ''){
      titleController.text = 'No Title';
    }
    if(paragraphController.text == null || paragraphController.text == ''){
      paragraphController.text = 'No Details';
    }
    

    if(_dateTime.isAfter(DateTime.now())){
      //add toscheduleList
      final ScheduleModel scheduleEntry =  new ScheduleModel(
        uid: generateUID(), 
        schedTitle: titleController.text, 
        schedDateTime: _dateTime, 
        schedDetails: paragraphController.text);
      
      dbconn.addData(scheduleCollection, scheduleEntry);
      // NotificationService.scheduleNotification(
      //   id: int.parse(scheduleEntry.uid),
      //   title: 'Event approaching!',
      //   body: '${scheduleEntry.schedTitle} \n${scheduleEntry.schedDetails}',
      //   scheduledDate: _dateTime,
      // );
      
      print('Schedule Entry Added');
      showSuccessDialog(context, 'Your schedule entry has been added.', ScheduleHomePage());
    }
    else{
      showErrorDialog(context, 'Date and Time must be in future.');
    }
  }
}
