import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ess_app/dataList/diaries.dart';
import 'package:ess_app/guardian/edit/edit_entry_diary.dart';
import 'package:ess_app/models/diary_model.dart';
import 'package:ess_app/services/database.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/memory_tab_listview.dart';
import 'package:ess_app/constants.dart';

class MemoryDiaryTab extends StatefulWidget {
  const MemoryDiaryTab({super.key});

  @override
  State<MemoryDiaryTab> createState() => _MemoryDiaryTabState();
}

class _MemoryDiaryTabState extends State<MemoryDiaryTab> {
  var dbconn = DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(color: AppColors.backColor),
        child: Column(children: [
          SizedBox(height: 10.0),
          //container for gridview
          Expanded(
            child: Container(
              //builder of listview
              child: FutureBuilder<List<DocumentSnapshot>>(
                future: dbconn.getAllData(diaryCollection),
                builder: ((BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    List<DocumentSnapshot> documents =
                        snapshot.data! as List<DocumentSnapshot>;
                    return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          documents.map((item) {
                            return MemoryTabListView(
                                diaryIndex: index,
                                diaryTitle: item.get('diaryTitle'),
                                diaryDateTime: item.get('diaryDateTime'),
                                diaryDetails: item.get('diaryDetails'),
                                emoteRate: item.get('emoteRate'),
                                deleteTapped: (context) =>
                                    print('Clicked Delete Button'),
                                editTapped: (context) =>
                                    print('Click Edit Button'));
                          });
                        });
                  } else if (snapshot.hasError) {
                    throw Exception('$snapshot.error');
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  // delete? yes or no
  AwesomeDialog deleteDialog(BuildContext context, String index) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
      borderSide: BorderSide(
        color: AppColors.secondColor,
        width: 2,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      title: 'Delete Entry?',
      titleTextStyle: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: Colors.green,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      desc: 'Are you sure you want to delete this diary entry?',
      btnOkText: 'Yes',
      btnOkColor: Color(0xFFE86166),
      btnCancelColor: Colors.blue,
      btnCancelText: 'No',
      btnOkOnPress: () {
        print('yes');
      },
      btnCancelOnPress: () {
        print('no');
      },
      padding: EdgeInsets.all(15),
      showCloseIcon: false,
    );
  }

  //delete successfully
  AwesomeDialog deleteSuccessDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      borderSide: BorderSide(
        color: AppColors.secondColor,
        width: 2,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      title: 'Deleted Successfully',
      titleTextStyle: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: Colors.green,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      onDissmissCallback: (type) {
        // Navigator.of(context).pop();
      },
      padding: EdgeInsets.all(15),
      showCloseIcon: false,
      autoHide: Duration(seconds: 3),
    );
  }

  //deleting entry in list
  // void deleteDiaryEntry(String index) {
  //   print('Deleted diary at index ' + index.toString());
  //   deleteSuccessDialog(context).show();
  // }

  // void editDiaryEntry(BuildContext context, String index) {
  //   Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) => EditEntryDiary(editIndex: index)));
  // }
}
