import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ess_app/dataList/diaries.dart';
import 'package:ess_app/guardian/edit/edit_entry_diary.dart';
import 'package:ess_app/models/diary_model.dart';
import 'package:ess_app/services/database.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                child: StreamBuilder<List<DiaryModel>>(
              initialData: [],
              stream: dbconn.diaryData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<DiaryModel> data = snapshot.data!;
                  if (data.isEmpty) {
                    return Text('No Diary Available');
                  } else {
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final docs = data[index];
                          return MemoryTabListView(
                              diary: docs,
                              deleteTapped: (context) =>
                                  deleteDiaryEntry(diaryCollection, docs.uid),
                              editTapped: (context) =>
                                  editDiaryEntry(context, docs));
                        });
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Text('Error: $snapshot.error');
                }
              },
            )),
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
  void deleteDiaryEntry(String collectionCaller, String index) {
    dbconn.deleteKeyFromCollectionByID(collectionCaller, index);
    print('Deleted diary at index ' + index.toString());
    deleteSuccessDialog(context).show();
  }

  void editDiaryEntry(BuildContext context, DiaryModel diary) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditEntryDiary(selectedDiary: diary)));
  }
}
