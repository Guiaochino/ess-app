import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ess_app/dataList/diaries.dart';
import 'package:ess_app/guardian/edit/edit_entry_diary.dart';
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
  late bool listEmptyState;
  late int listLen;
  late List<dynamic> diaryList;

  @override
  Widget build(BuildContext context) {
    dbconn.getAllData(diaryCollection).then((value) {
      setEmptyState(value.isEmpty);
      setLen(value.length);
      setDataList(value);
    });

    return Container(
      child: Container(
        decoration: BoxDecoration(color: AppColors.backColor),
        child: Column(children: [
          SizedBox(height: 10.0),
          //container for gridview
          Expanded(
            child: listEmptyState
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.description,
                              size: 200,
                              color: Colors.black,
                            ),
                            Text(
                              'No Diary Entry',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(
                    //builder of listview
                    child: ListView.builder(
                      itemCount: listLen,
                      itemBuilder: ((context, index) {
                        final diary = diaryList[index];
                        return MemoryTabListView(
                            diaryIndex: diary.diaryID,
                            diaryTitle: diary.diaryTitle,
                            diaryDateTime: diary.diaryDateTime,
                            diaryDetails: diary.diaryDetails,
                            emoteRate: diary.emoteRate,
                            deleteTapped: (context) {
                              // deleteDialog(context, index).show();
                              deleteDiaryEntry(index);

                              print('tapped');
                            },
                            editTapped: (context) {
                              editDiaryEntry(context, diary.diaryID);
                            });
                      }),
                    ),
                  ),
          ),
        ]),
      ),
    );
  }

  // delete? yes or no
  AwesomeDialog deleteDialog(BuildContext context, int index) {
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
  void deleteDiaryEntry(int index) {
    print('Deleted diary at index ' + index.toString());
    setState(() {
      diaryList.removeAt(index);
    });
    deleteSuccessDialog(context).show();
  }

  void editDiaryEntry(BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditEntryDiary(editIndex: index)));
  }

  void setEmptyState(bool state) {
    listEmptyState = state;
  }

  void setLen(int value) {
    listLen = value;
  }

  void setDataList(List<dynamic> data) {
    diaryList = data;
  }

}
