import 'package:ess_app/guardian/edit/edit_entry_diary.dart';
import 'package:ess_app/guardian/widgets/popup_dialogs.dart';
import 'package:ess_app/models/diary_model.dart';
import 'package:ess_app/services/database.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ess_app/guardian/widgets/memory_tab_listview.dart';
import 'package:ess_app/constants.dart';

class MemoryDiaryTab extends StatefulWidget {
  const MemoryDiaryTab({super.key});

  @override
  State<MemoryDiaryTab> createState() => _MemoryDiaryTabState();
}

class _MemoryDiaryTabState extends State<MemoryDiaryTab> {
  final dbconn = DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);

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
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height:40),
                        Icon(
                          Icons.browser_not_supported_outlined,
                          size: 100,
                          color: Colors.black,
                        ),
                        Text(
                          'No Diaries Yet.',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final docs = data[index];
                          return MemoryTabListView(
                              diary: docs,
                              deleteTapped: (context) async {
                                try {
                                  bool? deleteConfirmed = await showConfirmationDialog(context, 'Are you sure you want to delete?');
                                  if (deleteConfirmed == true) {
                                    // perform deletion
                                    await deleteDiaryEntry(diaryCollection, docs.uid);
                                  } else {
                                    // user canceled deletion
                                  }
                                } catch (e) {
                                  // handle any errors that might occur here
                                  print(e);
                                }
                              },
                              editTapped: (context) =>
                                  editDiaryEntry(context, docs));
                        });
                  }
                } else if (snapshot.connectionState == ConnectionState.waiting) {
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

  //deleting entry in list
  Future<void> deleteDiaryEntry(String collectionCaller, String index) async {
    dbconn.deleteKeyFromCollectionByID(collectionCaller, index);
    print('Deleted diary at index ' + index.toString());
    showDeletionSuccessDialog(context, 'Diary deleted successfully!');
  }

  void editDiaryEntry(BuildContext context, DiaryModel diary) {
    Navigator.of(context).push(
      PageTransition(
        child: EditEntryDiary(selectedDiary: diary,),
        type: PageTransitionType.rightToLeft,
      ),
    );
  }
}
