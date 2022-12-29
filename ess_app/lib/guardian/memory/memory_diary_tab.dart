import 'package:ess_app/dataList/diaries.dart';
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
                      diaryRecording: diary.diaryRecording,
                      diaryDetails: diary.diaryDetails,
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
}
