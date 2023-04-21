import 'package:ess_app/guardian/view/view_entry_diary.dart';
import 'package:ess_app/models/diary_model.dart';
import 'package:ess_app/utils/dateTime_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../memory/memory_home_page.dart';

class MemoryTabListView extends StatelessWidget {
  // final int diaryIndex;
  // final String diaryTitle;
  // final DateTime diaryDateTime;
  // final String diaryDetails;
  // final int emoteRate;
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
                  bottomRight: Radius.circular(20)),
            )
          ],
        ),
        endActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTapped, //delete function
              icon: Icons.delete_forever,
              label: 'Delete',
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
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
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    //1st column - icon and title
                    Container(
                      height: 50,
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Center(
                            child: Icon(
                              icon(diary.emoteRate),
                              size: 50,
                              color: iconColor(diary.emoteRate),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                diary.diaryTitle,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 20, 
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //2nd Column -  diary details
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0, 
                          horizontal: 10.0,
                        ),
                        child: Container(
                          child: Container(
                            child: Text(
                              diary.diaryDetails,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 15, 
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //3rd Column - view details
                    Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewEntryDiary(
                              diary: diary,
                            ),
                          ));
                        },
                        child: Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Color(0xFFE86166),
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Center(
                            child: Text('Read more',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  //get icon
  IconData icon(int index){
    IconData iconRate = Icons.sentiment_neutral_outlined;
    switch (index){
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

  Color iconColor(int index){
    Color iconColor = Colors.grey;
    switch (index){
      case 1:
      iconColor = Colors.red;
      break;
      case 2:
      iconColor = Color.fromARGB(255, 204, 0, 112);
      break;
      case 3:
      iconColor = Color.fromARGB(255, 192, 0, 160);
      break;
      case 4:
      iconColor = Color.fromARGB(255, 255, 197, 6);
      break;
      case 5:
      iconColor = Color.fromARGB(255, 10, 72, 187);
      break;
      case 6:
      iconColor = Color.fromARGB(255, 241, 110, 35);
      break;
      case 7:
      iconColor = Color.fromARGB(255, 12, 148, 0);
      break;
    }
    return iconColor;
  }
}
