import 'package:flutter/material.dart';

import '../../widgets/memory_tab_listview.dart';

class MemoryDiaryTab extends StatelessWidget {
  
  final List _diaryEntries = [
    'diary entry 1',
    'diary entry 2',
    'diary entry 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
            child: Column(children: [
              //container for gridview
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: _diaryEntries.length,
                    itemBuilder: ((context, index) {
                      return MemoryTabListView(
                          diaryTitle: _diaryEntries[index]);
                    }),
                  ),
                ),
              )
            ])));
  }
}
