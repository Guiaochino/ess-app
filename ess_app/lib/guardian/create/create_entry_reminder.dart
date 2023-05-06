import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ess_app/constants.dart';
import 'package:ess_app/guardian/widgets/popup_dialogs.dart';
import 'package:ess_app/helpers.dart';
import 'package:ess_app/models/reminder_model.dart';
import 'package:ess_app/models/schedule_model.dart';
import 'package:ess_app/services/database.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import '../../Services/notif_service.dart';
import '../reminder/reminder_home.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class CreateEntryReminder extends StatefulWidget {
  const CreateEntryReminder({Key? key}) : super(key: key);

  @override
  State<CreateEntryReminder> createState() => _CreateEntryReminderState();
}

class _CreateEntryReminderState extends State<CreateEntryReminder> {
  String notificationID = generateUID();

  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();

  late TimeOfDay _pickedTime;

  final titleController = TextEditingController(); //title textfield controller
  final paragraphController =
      TextEditingController(); //paragraph textfield controller
  final dbconn = DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);

  void dispose() {
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
                child: ReminderHomePage(activePage: 0),
                type: PageTransitionType.leftToRight,
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
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
                    child: Text(
                      "What's the daily task?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
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
                SizedBox(height: 20.0),
                //reminder title
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
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                        decoration: InputDecoration(
                            iconColor: Colors.black,
                            prefixIcon: Icon(Icons.notifications, size: 30),
                            border: UnderlineInputBorder(),
                            hintText: 'Enter Reminder Title',
                            hintStyle: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
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
                          _selectTime();
                          // TimeOfDay? newTime = await showTimePicker(
                          //   context: context,
                          //   initialTime: _timeOfDay,
                          // );
                          // if (newTime == null) return;
                          // final newDateTime = DateTime(
                          //   _dateTime.year,
                          //   _dateTime.month,
                          //   _dateTime.day,
                          //   newTime.hour,
                          //   newTime.minute,
                          // );
                          // setState(() {
                          //   _dateTime = newDateTime;
                          //   print(_dateTime);
                          // });
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
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
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
                          fontSize: 15,
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
                height > 670
                    ? Spacer(
                        flex: 1,
                      )
                    : Container(),
                SizedBox(height: 20),
                //save button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      saveReminderEntry();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.firstColor),
                        overlayColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 230, 177, 5)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ))),
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
                          width > 280
                              ? Text(
                                  'Save Reminder',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                )
                              : Container(),
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

  //saving reminder
  void saveReminderEntry() {
    debugPrint('DITO NA UNG KAPAG NAKASAVE NA YUNNG REMINDER');
    NotificationService().scheduleNotification(
        id: int.parse(notificationID),
        title: titleController.text,
        body: paragraphController.text,
        scheduledNotificationDateTime: _dateTime);
    print('ito naman yung current id counter $notificationID');
    //null or empty entries
    if (titleController.text == null || titleController.text == '') {
      titleController.text = 'No Title';
    }
    if (paragraphController.text == null || paragraphController.text == '') {
      paragraphController.text = 'No Details';
    }

    print('title : ' + titleController.text);
    print('dateTime: ' + _dateTime.toString());
    print('details : ' + paragraphController.text);

    //add to reminderList
    ReminderModel scheduleEntry = new ReminderModel(
        uid: notificationID,
        reminderTitle: titleController.text,
        reminderDateTime: _dateTime,
        reminderDetails: paragraphController.text);

    dbconn.addData(reminderCollection, scheduleEntry);

    print('reminder Entry Added');
    showSuccessDialog(context, 'Your reminder has been saved.',
        ReminderHomePage(activePage: 0));
  }

  Future<void> _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _timeOfDay,
    );
    if (newTime != null) {
      final newDateTime = DateTime(
        _dateTime.year,
        _dateTime.month,
        _dateTime.day,
        newTime.hour,
        newTime.minute,
      );
      setState(() {
        _dateTime = newDateTime;
        debugPrint('DATETIME NA NAPILI NG USER  >>>> $_dateTime');
      });
    }
    print(
        'ito yung dinedebug ko Notification #$notificationID na sinet ko sa time na $_dateTime');

    //newTime nase-save ang date

    // if (newTime == null) return;
    // final newDateTime = DateTime(
    //   _dateTime.year,
    //   _dateTime.month,
    //   _dateTime.day,
    //   newTime.hour,
    //   newTime.minute,
    // );
    // setState(() {
    //   _dateTime = newDateTime;
    //   print(_dateTime);
    // });
  }
}
