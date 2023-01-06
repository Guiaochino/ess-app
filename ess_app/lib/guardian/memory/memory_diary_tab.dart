import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ess_app/dataList/diaries.dart';
import 'package:ess_app/guardian/memory/memory_home_page.dart';
import 'package:flutter/material.dart';

import '../../widgets/memory_tab_listview.dart';

class MemoryDiaryTab extends StatefulWidget {
  const MemoryDiaryTab({super.key});

  @override
  State<MemoryDiaryTab> createState() => _MemoryDiaryTabState();
}

class _MemoryDiaryTabState extends State<MemoryDiaryTab> {
  List<Diary> diaries = diaryList;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: Column(
          children: [
          //container for gridview
            Expanded(
              child: Container(
                //builder of listview
                child: ListView.builder(
                  itemCount: diaries.length,
                  itemBuilder: ((context, index) {
                    final diary = diaries[index];
                    return MemoryTabListView(
                      diaryTitle: diary.diaryTitle,
                      diaryDateTime: diary.diaryDateTime,
                      diaryDetails: diary.diaryDetails,
                      emoteRate: diary.emoteRate,
                      deleteTapped: (context){
                        // deleteDialog(context, index).show();
                        deleteDiaryEntry(index);
                        print('tapped');
                      },
                    );
                  }),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
  // delete? yes or no
  AwesomeDialog deleteDialog(BuildContext context, int index) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
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
        color: Color(0xFFE86166),
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
      onDissmissCallback:(type) {
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
}
