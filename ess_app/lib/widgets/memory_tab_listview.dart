import 'package:ess_app/guardian/view/view_entry_diary.dart';
import 'package:ess_app/utils/dateTime_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../guardian/memory/memory_home_page.dart';

class MemoryTabListView extends StatelessWidget {
  final String diaryTitle;
  final String diaryDateTime;
  final String diaryDetails;
  final int emoteRate;
  final Function(BuildContext)? deleteTapped;

  MemoryTabListView({
    required this.diaryTitle,
    required this.diaryDateTime,
    required this.diaryDetails,
    required this.emoteRate,
    required this.deleteTapped,
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
              onPressed: ((context) {
                //edit
              }),
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
            height: 250,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
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
                              icon(emoteRate),
                              size: 50,
                              color: iconColor(emoteRate),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, 
                              vertical: 5.0,
                            ),
                            child: Container(
                              width: 5,
                              height: 50,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                diaryTitle,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 25, 
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
                              diaryDetails,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 15, 
                                color: Colors.grey,
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
                              title: diaryTitle,
                              dateTime: diaryDateTime,
                              details: diaryDetails,
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
                            child: Text('View Details',
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
