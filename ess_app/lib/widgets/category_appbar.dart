import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';

class categoryAppBar extends StatelessWidget {
  final String title;
  final IconData icon1;
  final IconData icon2;
  final String tabLabel1;
  final String tabLabel2;

  const categoryAppBar({
    Key? key, required this.title, required this.icon1, required this.icon2, required this.tabLabel1, required this.tabLabel2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      expandedHeight: 150,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black, 
          fontWeight: FontWeight.w700,
          fontSize: 25.0,
          letterSpacing: 1.0,
          fontFamily: 'Montserrat'
        ),
      ),
      backgroundColor: AppColors.firstColor,
      foregroundColor: Colors.black,
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(37),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromARGB(255, 206, 205, 205),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TabBar(
                      unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                      ),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.0,
                        fontFamily: 'Montserrat',
                      ),
                      labelColor: Colors.black,
                      unselectedLabelColor: AppColors.secondColor,
                      automaticIndicatorColorAdjustment: true,
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),

                      tabs: [
                        Tab(
                          height: 60,
                          icon: Icon(
                            icon1,
                            size: 20,
                          ),
                          text: tabLabel1,
                        ),
                        Tab(
                          height: 60,
                          icon: Icon(
                            icon2,
                            size: 20,
                          ),
                          text: tabLabel2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}