import 'package:ess_app/guardian/create/create_entry_reminder.dart';
import 'package:ess_app/guardian/widgets/category_appbar.dart';
import "package:flutter/material.dart";
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../widgets/main_drawer.dart';
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
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Color.fromARGB(255, 255, 197, 6),
          foregroundColor: Colors.black,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          spacing: 12,
          children: [
            SpeedDialChild(
              child: Icon(
                Icons.add_a_photo,
                color: Colors.white,
              ),
              label: 'Add Image',
              backgroundColor: Colors.grey[800],

              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateEntryImage()));
              },
              // onTap: () => add image function
            ),
            SpeedDialChild(
              child: Icon(Icons.note_add, color: Colors.white),
              label: 'Add Diary Entry',
              backgroundColor: Colors.grey[800],
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateEntryDiary()));
              },
            )
          ],
        ),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: ((context, innerBoxIsScrolled) => [
            categoryAppBar(
              title: 'Memories',
              icon1: Icons.photo_album_outlined,
              icon2: Icons.book_outlined,
              tabLabel1: 'Images',
              tabLabel2: 'Diary',
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
