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
                gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 177, 190, 226),
                Color.fromARGB(255, 200, 204, 218),
                Color.fromARGB(255, 214, 174, 175),
                Color.fromARGB(255, 221, 170, 172),
                Color.fromARGB(255, 233, 170, 172),
                Color.fromARGB(255, 233, 148, 151),
                Color.fromARGB(255, 230, 109, 113),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 40,
                  child: Text('Spare Container'),
                ),
              ),
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
