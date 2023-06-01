import 'package:ess_app/guardian/memory/memory_home_page.dart';
import 'package:ess_app/guardian/widgets/popup_dialogs.dart';
import 'package:ess_app/services/database.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ess_app/models/diary_model.dart';
import 'package:page_transition/page_transition.dart';

class EditEntryDiary extends StatefulWidget {
  final DiaryModel selectedDiary;
  
  const EditEntryDiary({required this.selectedDiary});
  

  @override
  State<EditEntryDiary> createState() => _EditEntryDiaryState(diary: selectedDiary);
}

class _EditEntryDiaryState extends State<EditEntryDiary> {
  DiaryModel diary;
  _EditEntryDiaryState({required this.diary});

  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  int selectedMood = 0; // selected mood index
  final titleController = TextEditingController(); //title textfield controller
  final paragraphController = TextEditingController(); //paragraph textfield controller
  final dbconn = DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);
  

  //load diary data
  void initState(){
    titleController.text = diary.diaryTitle;
    paragraphController.text = diary.diaryDetails;
    _dateTime = diary.diaryDateTime;
    selectedMood = diary.emoteRate;
    print(_dateTime);
    super.initState();
  }

  void dispose(){
    titleController.dispose();
    paragraphController.dispose();
    super.dispose();
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
        leading: IconButton(
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
            size: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: AppColors.backColor,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10.0),
                //how is your day
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Edit Diary',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                // mood radio buttons -
                Container(
                  height: 70,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customRadio(Icons.sentiment_very_dissatisfied_outlined, 1),
                        SizedBox(width: 5),
                        customRadio(Icons.sentiment_very_dissatisfied, 2),
                        SizedBox(width: 5),
                        customRadio(Icons.sentiment_dissatisfied, 3),
                        SizedBox(width: 5),
                        customRadio(Icons.sentiment_neutral_rounded, 4),
                        SizedBox(width: 5),
                        customRadio(Icons.sentiment_satisfied, 5),
                        SizedBox(width: 5),
                        customRadio(Icons.sentiment_satisfied_outlined, 6),
                        SizedBox(width: 5),
                        customRadio(Icons.sentiment_very_satisfied_outlined, 7)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                //diary title
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    child: Container(
                      width: width - 40,
                      child: TextField(
                        controller: titleController,
                        textAlignVertical: TextAlignVertical.bottom,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          iconColor: Colors.black,
                          prefixIcon: Icon(Icons.auto_stories, size: 30),
                          border: UnderlineInputBorder(),
                          hintText: 'Enter Diary Title',
                          hintStyle: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      child: TextFormField(
                        controller: paragraphController,
                        maxLines: 40,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          fontSize: 18,
                          height: 2,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: 'What happened today?',
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 5.0,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    onPressed: (){
                      saveDiaryEntry();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColors.firstColor),
                      overlayColor: MaterialStateProperty.all(Color.fromARGB(255, 230, 177, 5)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )
                      )
                    ),
                    child: Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.save,
                            size: 25,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10),
                          width > 280?
                          Text(
                            'Save Diary',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ): Container()
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


  //saving diary
  void saveDiaryEntry() {

    //null or empty entries
    if(titleController.text == null || titleController.text == ''){
      titleController.text = 'No Title';
    }
    if(paragraphController.text == null || paragraphController.text == ''){
      paragraphController.text = 'No Details';
    }
    if(selectedMood == 0){
      selectedMood = 4;
    }

    //save to diaryList
    setState(() {
      diary.diaryTitle = titleController.text;
      diary.emoteRate = selectedMood;
      diary.diaryDetails = paragraphController.text;
    },);

    dbconn.updateDiaryByID(diary.uid, diary);
    print('Diary Entry Edited');
    showSuccessDialog(context, 'Your diary has been edited.', MemoryHomePage(activePage: 1));

  }
  
  //radio button
  Widget customRadio(IconData icon, int index) {
    final isSelected = selectedMood == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMood = isSelected ? 0 : index;
        });
      },
      child: Container(
        width: isSelected ? 50.0 : 40.0,
        height: isSelected ? 50.0 : 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Colors.white : Colors.grey[200],
          border: Border.all(
            color: isSelected ? iconColor(index) : Colors.grey[700]!,
            width: isSelected ? 3.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: isSelected ? 36.0 : 24.0,
          color: isSelected ? iconColor(index) : Colors.grey[700],
        ),
      ),
    );
  }

  //color of radiobuttons
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