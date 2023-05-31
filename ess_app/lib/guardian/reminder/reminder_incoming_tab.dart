import 'package:ess_app/constants.dart';
import 'package:ess_app/guardian/edit/edit_entry_reminder.dart';
import 'package:ess_app/guardian/widgets/popup_dialogs.dart';
import 'package:ess_app/services/database.dart';
import 'package:ess_app/services/notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ess_app/guardian/widgets/reminder_tab_listview.dart';
import 'package:ess_app/models/reminder_model.dart';

class ReminderIncomingTab extends StatefulWidget {
  const ReminderIncomingTab({super.key});

  @override
  State<ReminderIncomingTab> createState() => _ReminderIncomingTabState();
}

class _ReminderIncomingTabState extends State<ReminderIncomingTab> {
  final dbconn = DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ReminderModel>>(
      stream: dbconn.getIncomingReminders,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //sorting function for incoming
          List<ReminderModel> incomingReminders = snapshot.data!;
          return Container(
            decoration: BoxDecoration(
              color: AppColors.backColor,
            ),
            child: Column(
              children: [
                SizedBox(height: 10.0),
                //container for gridview
                Expanded(
                  child: incomingReminders.isEmpty
                      ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height:40),
                          Icon(
                            Icons.notifications_off,
                            size: 100,
                            color: Colors.black,
                          ),
                          Text(
                            'No Reminders',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      )
                      : Container(
                          child: ListView.builder(
                            itemCount: incomingReminders.length,
                            itemBuilder: ((context, index) {
                              final reminder = incomingReminders[index];
                              return ReminderTabListView(
                                  reminder: reminder,
                                  deleteTapped: (context) async {
                                    try {
                                      bool? deleteConfirmed = await showConfirmationDialog(context, 'Are you sure you want to delete?');
                                      if (deleteConfirmed == true) {
                                        // perform deletion
                                        await deleteReminderEntry(reminderCollection, reminder.uid);
                                      } else {
                                        // user canceled deletion
                                      }
                                    } catch (e) {
                                      // handle any errors that might occur here
                                      print(e);
                                    }
                                  },
                                  editTapped: (context) {
                                    editReminderEntry(context, reminder);
                                  });
                            }),
                          ),
                        ),
                ),
              ],
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Text('Error: $snapshot.error');
        }
      });
  }

  Future <void> deleteReminderEntry(String collectionCaller, String index) async {
    print('Deleted reminder at index ' + index);
    NotificationService.removeNotificationWithId(int.parse(index));
    dbconn.deleteKeyFromCollectionByID(collectionCaller, index);
    showDeletionSuccessDialog(context, 'Reminder deleted successfully!');
  }

  void editReminderEntry(BuildContext context, ReminderModel reminder) {
    Navigator.of(context).push(
      PageTransition(
        child: EditEntryReminder(selectedReminder: reminder),
        type: PageTransitionType.rightToLeft,
      ),
    );
  }
}
