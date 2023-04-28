import 'package:ess_app/guardian/view/view_entry_reminder.dart';
import 'package:ess_app/models/reminder_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class UpcomingReminderListView extends StatelessWidget {
  final ReminderModel reminder;

  UpcomingReminderListView({
   required this.reminder});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(
            PageTransition(
              child: ViewReminder(
                reminder: reminder,
              ),
              type: PageTransitionType.bottomToTop
            )
          );
        },
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 47, 92, 150).withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Icon(
                Icons.notifications_active,
                size: 30,
                color: Color.fromARGB(255, 47, 92, 150), 
              ),
            ),
          //schedule date
          title: Text(
            reminder.reminderTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat',
              fontSize: 20,
              color: Colors.black
            ),
          ),
          //schedule details
          subtitle: Text(
            reminder.reminderDetails,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              fontFamily: 'Montserrat',
              color: Colors.grey[600],
            ),
          ),
          trailing: Container(
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              //schedule time
              child: Text(
                DateFormat('h:mm a').format(reminder.reminderDateTime),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                )
              ),
            )
          )
        ),
      ),
    );
  }
}
