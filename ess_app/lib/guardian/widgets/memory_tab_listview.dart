import 'package:ess_app/guardian/view/view_entry_diary.dart';
import 'package:ess_app/models/diary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class MemoryTabListView extends StatelessWidget {
  final DiaryModel diary;
  final Function(BuildContext)? deleteTapped;
  final Function(BuildContext)? editTapped;

  MemoryTabListView({
    required this.diary,
    required this.deleteTapped,
    required this.editTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            )
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
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Icon(
                        icon(diary.emoteRate),
                        size: 40,
                        color: iconColor(diary.emoteRate),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          diary.diaryTitle,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      diary.diaryDetails,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 4),
                      Text(
                        DateFormat('MMM d, yyyy').format(diary.diaryDateTime),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            PageTransition(
                              child: ViewEntryDiary(diary: diary),
                              type: PageTransitionType.rightToLeft,
                            ),
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFFE86166),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Read more',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData icon(int index) {
    IconData iconRate = Icons.sentiment_neutral_outlined;
    switch (index) {
      case 1:
        iconRate = Icons.sentiment_very_dissatisfied_outlined;
        break;
      case 2:
        iconRate = Icons.sentiment_very_dissatisfied;
        break;
      case 3:
        iconRate = Icons.sentiment_dissatisfied;
        break;
      case 4:
        iconRate = Icons.sentiment_neutral_rounded;
        break;
      case 5:
        iconRate = Icons.sentiment_satisfied;
        break;
      case 6:
        iconRate = Icons.sentiment_satisfied_outlined;
        break;
      case 7:
        iconRate = Icons.sentiment_very_satisfied_outlined;
        break;
    }
    return iconRate;
  }

  Color iconColor(int index) {
    Color iconColor = Colors.grey;
    switch (index) {
      case 1:
        iconColor = Color(0xFF333399); // Very Sad (Dark Indigo)
        break;
      case 2:
        iconColor = Color(0xFF6699CC); // Sad (Steel Blue)
        break;
      case 3:
        iconColor = Color(0xFF99CCFF); // Somewhat Sad (Light Blue)
        break;
      case 4:
        iconColor = Color(0xFFCCCCCC); // Neutral (Light Gray)
        break;
      case 5:
        iconColor = Color(0xFFFFCC99); // Somewhat Happy (Peach)
        break;
      case 6:
        iconColor = Color(0xFFFF9933); // Happy (Orange)
        break;
      case 7:
        iconColor = Color(0xFFFF6633); // Very Happy (Vibrant Orange)
        break;
    }
    return iconColor;
  }
}

