import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ess_app/patient/edit/edit_entry_reminder.dart';
import 'package:flutter/material.dart';
import '../../dataList/reminders.dart';
import '../widgets/reminder_tab_listview.dart';

class ReminderPastTab extends StatefulWidget {
  const ReminderPastTab({super.key});

  @override
  State<ReminderPastTab> createState() => _ReminderPastTabState();
}

class _ReminderPastTabState extends State<ReminderPastTab> {
  List<Reminder> reminders = reminderList.where((i) => i.reminderIsDone).toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: Column(
          children: [
            SizedBox(height: 10.0),
          //container for gridview
            Expanded(
              child: reminders.isEmpty?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.notifications_off,
                          size: 200,
                          color: Colors.black,
                        ),
                        Text(
                          'No Reminders',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ],
              )
              :Container(
                child: ListView.builder(
                  itemCount: reminders.length,
                  itemBuilder: ((context, index) {
                    final reminder = reminders[index];
                    return ReminderTabListView(
                      reminderIndex: reminder.reminderID,
                      reminderTitle: reminder.reminderTitle,
                      reminderDateTime: reminder.reminderDateTime,
                      reminderDetails: reminder.reminderDetails,
                      isDone: reminder.reminderIsDone,
                      deleteTapped: (context){
                        // deleteDialog(context, index).show();
                        deleteReminderEntry(index);
                        
                        print('tapped');
                      },
                      editTapped:(context){
                        editReminderEntry(context, reminder.reminderID);
                      }
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

   // delete? yes or no
  AwesomeDialog deleteDialog(BuildContext context, int index) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
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
      title: 'Delete Entry?',
      titleTextStyle: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: Colors.green,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      desc: 'Are you sure you want to delete this diary entry?',
      btnOkText: 'Yes',
      btnOkColor: Color(0xFFE86166),
      btnCancelColor: Colors.blue,
      btnCancelText: 'No',
      btnOkOnPress: () {
        print('yes');
      },
      btnCancelOnPress: () {
        print('no');
      },
      padding: EdgeInsets.all(15),
      showCloseIcon: false,
    );
  }
  //delete successfully
  AwesomeDialog deleteSuccessDialog(BuildContext context) {
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
      title: 'Deleted Successfully',
      titleTextStyle: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: Colors.green,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      onDissmissCallback:(type) {
        // Navigator.of(context).pop();
        
      },
      padding: EdgeInsets.all(15),
      showCloseIcon: false,
      autoHide: Duration(seconds: 3),
    );
  }

  void deleteReminderEntry(int index) {

    print('Deleted diary at index ' + index.toString());
    setState(() {
      reminderList.removeAt(index);
    });
    deleteSuccessDialog(context).show();
  }
  void editReminderEntry(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => EditEntryReminder(editIndex: index)));
  }
}