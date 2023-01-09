import 'package:ess_app/guardian/create/create_entry_reminder.dart';
import 'package:ess_app/widgets/category_appbar.dart';
import "package:flutter/material.dart";
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../widgets/main_drawer.dart';
import '../create/create_entry_diary.dart';
import '../create/create_entry_image.dart';
import 'memory_diary_tab.dart';
import 'memory_image_tab.dart';

class MemoryHomePage extends StatelessWidget {
  final int activePage;
  const MemoryHomePage({
    required this.activePage,
    super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: activePage,
      length: 2,
      child: Scaffold(
        drawer: MainDrawer(),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color(0xFFF2BA05),
          foregroundColor: Colors.black,
          label: Text('Add Reminder'),
          icon: Icon(Icons.notification_add),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CreateReminder()));
          },
        ),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: ((context, innerBoxIsScrolled) => [
            categoryAppBar(
              title: 'Memories',
              icon1: Icons.photo_album_outlined,
              icon2: Icons.book_outlined,
              tabLabel1: 'INCOMING',
              tabLabel2: 'PAST',
            ),
          ]),
          body: Expanded(
            child: TabBarView(
              children: [
                MemoryImageTab(),
                MemoryDiaryTab(),
              ],
            ),
          ),
        )
      )
    );
  }
}
