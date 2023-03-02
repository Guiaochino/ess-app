import 'package:ess_app/guardian/create/create_entry_reminder.dart';
import 'package:ess_app/guardian/widgets/category_appbar.dart';
import 'package:ess_app/guardian/widgets/category_tab.dart';
import 'package:ess_app/utils/colors.dart';
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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.firstColor,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'Memory',
            style: TextStyle(
              color: Colors.black, 
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
              fontFamily: 'Montserrat'
            ),
          ), 
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            categoryTab(
              icon1: Icons.photo_album_outlined,
              icon2: Icons.book_outlined,
              tabLabel1: 'IMAGES',
              tabLabel2: 'DIARY',
            ),
            Expanded(
              child: TabBarView(
                children: [
                  MemoryImageTab(),
                  MemoryDiaryTab(),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
