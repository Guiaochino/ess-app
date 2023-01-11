import 'package:flutter/material.dart';

import '../../widgets/reminder_tab_listview.dart';

class ReminderIncomingTab extends StatelessWidget {
  final List _reminderTitles = [
    'reminder entry 1',
    'reminder entry 2',
    'reminder entry 3',
  ];
  final List _reminderDetails = [
    '1Laborum duis ad consequat ad aliqua qui incididunt nulla aute. Elit Lorem qui enim ea enim commodo non consectetur commodo sunt irure. Ad nisi sit irure adipisicing irure officia.',
    '2Laborum duis ad consequat ad aliqua qui incididunt nulla aute. Elit Lorem qui enim ea enim commodo non consectetur commodo sunt irure. Ad nisi sit irure adipisicing irure officia.',
    '3Laborum duis ad consequat ad aliqua qui incididunt nulla aute. Elit Lorem qui enim ea enim commodo non consectetur commodo sunt irure. Ad nisi sit irure adipisicing irure officia.',
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
                    itemCount: _reminderTitles.length,
                    itemBuilder: ((context, index) {
                      return ReminderTabListView(
                          reminderTitle: _reminderTitles[index],
                          reminderDetails: _reminderDetails[index]);
                    }),
                  ),
                ),
              )
            ])));
  }
}
