/*
  NOTE: edit entry diary uses INT editIndex taken from listviewbuilder index 
*/

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ess_app/dataList/diaries.dart';
import 'package:ess_app/guardian/memory/memory_home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditEntryDiary extends StatefulWidget {
  final int editIndex;
  
  const EditEntryDiary({required this.editIndex});
  

  @override
  State<EditEntryDiary> createState() => _EditEntryDiaryState(diaryId: editIndex);
}

class _EditEntryDiaryState extends State<EditEntryDiary> {
  int diaryId = 0 ;
  _EditEntryDiaryState({required this.diaryId});

  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  int selectedMood = 0; // selected mood index
  final titleController = TextEditingController(); //title textfield controller
  final paragraphController = TextEditingController(); //paragraph textfield controller
  late Diary diaryEntry;

  //load diary data
  void initState(){
    print(diaryId);
    diaryEntry = diaryList[diaryId];
    titleController.text = diaryEntry.diaryTitle;
    paragraphController.text = diaryEntry.diaryDetails;
    selectedMood = diaryEntry.emoteRate;
  }

  void dispose(){
    titleController.dispose();
    paragraphController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(diaryEntry.diaryID.toString()),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MemoryHomePage()));
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
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10.0),
                //how is your day
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'How is your day?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 35,
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
                  color: Colors.grey[400],
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                SizedBox(height: 10.0),
                //diary title
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    child: Container(
                      width: 250,
                      child: TextField(
                        controller: titleController,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                        decoration: InputDecoration(
                          iconColor: Colors.black,
                          prefixIcon: Icon(Icons.auto_stories, size: 30),
                          border: UnderlineInputBorder(),
                          hintText: 'Enter Diary Title',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                //date and time
                Container(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //date
                        Expanded(
                          flex: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Icon(
                                  Icons.calendar_month,
                                  color: Color(0xFFE86166),
                                  size: 40,
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Expanded(
                                flex: 5,
                                child: Text(
                                DateFormat('E, MMM d, yyyy').format(DateTime.now()),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE86166),
                                ),
                              ))
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        //time
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Icon(
                                  Icons.watch_later,
                                  color: Color(0xFFE86166),
                                  size: 40,
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  TimeOfDay.now().format(context).toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFE86166),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                //recording button
                SizedBox(height: 20),
                //paragraph
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      color: Colors.white,
                      child: TextFormField(
                        controller: paragraphController,
                        maxLines: 40,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          fontSize: 20,
                          height: 2,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: 'What happened today?',
                          hintStyle: TextStyle(
                            color: Colors.grey[600],
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //save button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ElevatedButton(
                    onPressed: (){
                      saveDiaryEntry();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFFF2BA05)),
                      overlayColor: MaterialStateProperty.all(Color.fromARGB(255, 230, 177, 5)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )
                      )
                    ),
                    child: Container(
                      height: 80,
                      
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.save_alt,
                            size: 35,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          )
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

  //success dialog
  AwesomeDialog successDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      borderSide: BorderSide(
        color: Color(0xFFE86166),
        width: 2,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      title: 'Edited Successfully!',
      titleTextStyle: TextStyle(
        color: Colors.green,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      onDissmissCallback:(type) {
        Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MemoryHomePage()));
      },
      padding: EdgeInsets.all(15),
      showCloseIcon: false,
      autoHide: Duration(seconds: 3),
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

    print('id: ' + diaryId.toString());
    print('title : ' + titleController.text);
    print('emote rate: $selectedMood');
    print('dateTime: '+ DateTime.now().toString());
    print('details : ' + paragraphController.text);

    //save to diaryList
    setState(() {
      diaryList[diaryId].diaryID = diaryId;
      diaryList[diaryId].diaryTitle = titleController.text;
      diaryList[diaryId].emoteRate = selectedMood;
      diaryList[diaryId].diaryDateTime = DateTime.now().toString();
      diaryList[diaryId].diaryDetails = paragraphController.text;
    },);
    
    print('Diary Entry Edited');
    successDialog(context).show();
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