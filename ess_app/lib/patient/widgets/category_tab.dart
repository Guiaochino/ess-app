import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';

class categoryTab extends StatelessWidget {
  final IconData icon1;
  final IconData icon2;
  final String tabLabel1;
  final String tabLabel2;
  const categoryTab({super.key, required this.icon1, required this.icon2, required this.tabLabel1, required this.tabLabel2});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      child: TabBar(
        automaticIndicatorColorAdjustment: true,
        indicatorWeight: 5.0,
        indicatorColor: AppColors.secondColor,
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: 'Montserrat',
          letterSpacing: 2.0,
        ),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'Montserrat',
          letterSpacing: 5.0,
        ),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey[700],
        indicator: BoxDecoration(
          color: AppColors.backColor
        ),
        tabs: [
          Tab(
            height: 70,
            icon: Icon(
              icon1,
              size: 20,
            ),
            text: tabLabel1,
          ),
          Tab(
            height: 70,
            icon: Icon(
              icon2,
              size: 20,
            ),
            text: tabLabel2,
          ),
        ],
      ),
    );
  }
}