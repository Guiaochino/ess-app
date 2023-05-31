
import 'package:ess_app/guardian/view/view_entry_reminder.dart';
import 'package:ess_app/models/reminder_model.dart';
import 'package:ess_app/utils/dateTime_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:page_transition/page_transition.dart';

class ReminderTabListView extends StatelessWidget {
  final ReminderModel reminder;
  final Function(BuildContext)? deleteTapped;
  final Function(BuildContext)? editTapped;
  bool _isDone = false;

  ReminderTabListView({
    required this.reminder,
    required this.deleteTapped,
    required this.editTapped, 
  }) {
    final now = TimeOfDay.now();
    if (reminder.reminderDateTime.hour < now.hour ||
        (reminder.reminderDateTime.hour == now.hour && reminder.reminderDateTime.minute <= now.minute)) {
      _isDone = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Slidable(
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: editTapped,
              backgroundColor: Colors.blue,
              icon: Icons.edit_note,
              label: 'Edit',
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTapped,
              icon: Icons.delete_forever,
              label: 'Delete',
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            )
          ],
        ),
        child: MaterialButton(
          onPressed: () {
            Navigator.of(context).push(
              PageTransition(
                child: ViewReminder(
                  reminder: reminder,
                ),
                type: PageTransitionType.bottomToTop
              )
            );
          },
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: _isDone ? Colors.grey[200] : Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isDone ? Colors.grey[400]! : Colors.grey[400]!,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Icon(
                    Icons.alarm,
                    color: _isDone ? Colors.grey[600] : Color(0xFFE86166),
                    size: 32,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reminder.reminderTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            decoration: _isDone ? TextDecoration.lineThrough : TextDecoration.none,
                            color: _isDone ? Colors.grey[800] : Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          reminder.reminderDetails,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            decoration: _isDone ? TextDecoration.lineThrough : TextDecoration.none,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    extractTimefromDTString(reminder.reminderDateTime.toString()),
                    maxLines: 1,
                    style: TextStyle(
                      color: _isDone ? Colors.grey[400]! : Color(0xFFE86166),
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
