import 'package:ess_app/models/reminder_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class UpReminderCard extends StatelessWidget {
  final ReminderModel reminder;

  UpReminderCard({required this.reminder});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
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
          title: Text(
            reminder.reminderTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat',
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            reminder.reminderDetails,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              fontFamily: 'Montserrat',
              color: Colors.grey[600],
            ),
          ),
          trailing: Container(
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                DateFormat('h:mm a').format(reminder.reminderDateTime),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
