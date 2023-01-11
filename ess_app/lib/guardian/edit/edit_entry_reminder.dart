import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ess_app/dataList/reminders.dart';
import 'package:ess_app/guardian/reminder/reminder_home.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:ess_app/utils/dateTime_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditEntryReminder extends StatefulWidget {
  final int editIndex;
  
  const EditEntryReminder({required this.editIndex});


  @override
  State<EditEntryReminder> createState() => _EditEntryReminderState(reminderId: editIndex);
}

class _EditEntryReminderState extends State<EditEntryReminder> {
  int reminderId = 0 ;
  _EditEntryReminderState({required this.reminderId});

  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  final titleController = TextEditingController(); //title textfield controller
  final paragraphController = TextEditingController(); //paragraph textfield controller
  late Reminder reminderEntry;

  void initState(){
    print(reminderId);
    
    reminderEntry = reminderList[reminderId];
    titleController.text = reminderEntry.reminderTitle;
    paragraphController.text = reminderEntry.reminderDetails;
    _dateTime = parseStringToDate(reminderEntry.reminderDateTime);


  }
  void dispose(){
    titleController.dispose();
    paragraphController.dispose();
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
        leading: (IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ReminderHomePage(activePage: 0,)));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 30,
            ))),
      ),
      body: SafeArea(
        child: Container(
          color:AppColors.backColor,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10.0),
                //add daily reminder
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: (Text(
                      'Edit Daily Reminder',
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
                //reminder title
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    child: Container(
                      width: width - 60,
                      child: TextField(
                        controller: titleController,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        decoration: InputDecoration(
                          iconColor: Colors.black,
                          prefixIcon: Icon(Icons.notifications, size: 30),
                          border: UnderlineInputBorder(),
                          hintText: 'Enter Reminder Title',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          )
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
                            Spacer(),
                            Icon(
                              Icons.watch_later,
                              color: Color(0xFFE86166),
                              size: 55,
                            ),
                            SizedBox(width: 5.0),
                            Expanded(
                              flex: 4,
                              child: MaterialButton(
                                onPressed: () async {
                              TimeOfDay? newTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(_dateTime),
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
                                print(_dateTime);
                              });
                            },
                                child: Text(
                                  DateFormat.jm().format(_dateTime),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFE86166),
                                  ),
                                ),
                              ),
                            ),
                            Spacer()
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
                        controller: paragraphController,
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
                height > 670?
                Spacer(
                  flex: 1,
                ): Container(),
                SizedBox(height: 20),
                //save button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ElevatedButton(
                    onPressed: (){
                      saveReminderEntry();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFFF2BA05)),
                      overlayColor: MaterialStateProperty.all(Color.fromARGB(255, 230, 177, 5)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )
                      )
                    ),
                    child: Container(
                      height: 80,
                      
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.save_alt,
                            size: 35,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10),
                          width > 280 ?
                          Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 25,
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
  //success dialog
  AwesomeDialog successDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      borderSide: BorderSide(
        color: Color(0xFFE86166),
        width: 2,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      title: 'Edited Successfully!',
      titleTextStyle: TextStyle(
        color: Colors.green,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      onDissmissCallback:(type) {
        Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ReminderHomePage(activePage: 0,)));
      },
      padding: EdgeInsets.all(15),
      showCloseIcon: false,
      autoHide: Duration(seconds: 3),
    );
  }

  //saving reminder
  void saveReminderEntry() {
    bool isDone =  false;
    //null or empty entries
    if(titleController.text == null || titleController.text == ''){
      titleController.text = 'No Title';
    }
    if(paragraphController.text == null || paragraphController.text == ''){
      paragraphController.text = 'No Details';
    }
    if(_dateTime.isBefore(DateTime.now())){
      isDone = true;
    }

    print('title : ' + titleController.text);
    print('dateTime: '+ _dateTime.toString());
    print('done :' + isDone.toString());
    print('details : ' + paragraphController.text);

    //add to reminderList
    setState(() {
      reminderList[reminderId].reminderID = reminderId;
      reminderList[reminderId].reminderTitle = titleController.text;
      reminderList[reminderId].reminderIsDone = isDone;
      reminderList[reminderId].reminderDateTime = _dateTime.toString();
      reminderList[reminderId].reminderDetails = paragraphController.text;
    },);
    
    print('reminder Entry Edited');
    successDialog(context).show();
  }

}
