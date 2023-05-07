import 'package:ess_app/guardian/edit/edit_entry_diary.dart';
import 'package:ess_app/models/diary_model.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import '../memory/memory_home_page.dart';

class ViewEntryDiary extends StatelessWidget {
  final DiaryModel diary;

  const ViewEntryDiary({
    required this.diary
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backColor,
        elevation: 0,
        title: Text(
          'Diary',
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                PageTransition(
                  child: MemoryHomePage(activePage: 1),
                  type: PageTransitionType.leftToRight,
                ),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                //edit
                Navigator.of(context).push(
                  PageTransition(
                    child: EditEntryDiary(selectedDiary: diary),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              )
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: AppColors.backColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: 20.0),
                //date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('EEEE, MMM d, yyyy').format(diary.diaryDateTime),
                            overflow: TextOverflow.ellipsis, 
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Colors.grey[600]
                            ),
                          ),
                          SizedBox(height: 5.0),
                          //diary title
                          Container(
                            child: Text(
                              this.diary.diaryTitle, 
                              overflow: TextOverflow.visible,  
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: iconColor(diary.emoteRate).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        icon(diary.emoteRate),
                        color: iconColor(diary.emoteRate),
                        size: 40,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                //paragraph
                Expanded(
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      color: AppColors.secondColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        diary.diaryDetails,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Colors.black
                        ),
                      ),
                    )
                  ),
                ),
                SizedBox(height: 20),
                //save button

                SizedBox(height: 20),
              ],
            ),
          )
        )
      )
    );
  }
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
      iconColor = Color.fromARGB(255, 204, 157, 4);
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
