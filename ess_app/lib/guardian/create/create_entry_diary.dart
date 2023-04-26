import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ess_app/constants.dart';
import 'package:ess_app/guardian/widgets/popup_dialogs.dart';
import 'package:ess_app/models/diary_model.dart';
import 'package:ess_app/services/database.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import '../memory/memory_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ess_app/helpers.dart';

class CreateEntryDiary extends StatefulWidget {
  const CreateEntryDiary({Key? key}) : super(key: key);

  @override
  State<CreateEntryDiary> createState() => _CreateEntryDiaryState();
}

class _CreateEntryDiaryState extends State<CreateEntryDiary> {
  
  DateTime _dateTime = DateTime.now();
  int selectedMood = 0; // selected mood index
  final titleController = TextEditingController(); //title textfield controller
  final paragraphController = TextEditingController(); //paragraph textfield controller
  final user = FirebaseAuth.instance.currentUser!;

  void dispose(){
    titleController.dispose();
    paragraphController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      "What's on your mind?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.grey,
                            offset: Offset(5.0, 5.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                // mood radio buttons -
                Container(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          customRadio(Icons.sentiment_very_dissatisfied_outlined, 1),
                          customRadio(Icons.sentiment_very_dissatisfied, 2),
                          customRadio(Icons.sentiment_dissatisfied, 3),
                          customRadio(Icons.sentiment_neutral_rounded, 4),
                          customRadio(Icons.sentiment_satisfied, 5),
                          customRadio(Icons.sentiment_satisfied_outlined, 6),
                          customRadio(Icons.sentiment_very_satisfied_outlined, 7)
                        ],
                      ),
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
                //recording button
                SizedBox(height: 20),
                //paragraph
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
                SizedBox(height: 20),
                //save button
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
    if(titleController.text == ''){
      titleController.text = 'No Title';
    }
    if(paragraphController.text == ''){
      paragraphController.text = 'No Details';
    }
    if(selectedMood == 0){
      selectedMood = 4;
    }

    print('title : ' + titleController.text);
    print('Emote Rate: $selectedMood');
    print('dateTime: '+ _dateTime.toString());
    print('details : ' + paragraphController.text);

    //add to diaryList
    DiaryModel diary_entry = new DiaryModel(
      uid: generateUID(),
      diaryTitle: titleController.text, 
      diaryDateTime: _dateTime, 
      diaryDetails: paragraphController.text, 
      emoteRate: selectedMood
    );

    DatabaseService(uid: user.uid).addData(diaryCollection, diary_entry);

    print('Diary Entry Added');
    showSuccessDialog(context, 'Your diary entry has been saved.', MemoryHomePage(activePage: 1));
  }
  
  //radio button
  Widget customRadio(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if(selectedMood == index){
            selectedMood = 0;
          }
          else{
            selectedMood = index;
          }
        });
      }, 
      child: Icon(
        icon,
        size: (selectedMood == index) ? 60.0 : 45.0,
        color: (selectedMood == index) ? iconColor(index) : Colors.grey[700],
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