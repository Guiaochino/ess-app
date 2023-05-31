import 'package:ess_app/guardian/settings/how_to_use/how_to_use_home.dart';
import 'package:ess_app/guardian/settings/how_to_use/tutorial_pages.dart/md_page1.dart';
import 'package:ess_app/guardian/settings/how_to_use/tutorial_pages.dart/md_page2.dart';
import 'package:ess_app/guardian/settings/how_to_use/tutorial_pages.dart/md_page3.dart';
import 'package:ess_app/guardian/settings/how_to_use/tutorial_pages.dart/md_page4.dart';
import 'package:ess_app/guardian/settings/how_to_use/tutorial_pages.dart/md_page5.dart';
import 'package:ess_app/guardian/settings/how_to_use/tutorial_pages.dart/rs_page1.dart';
import 'package:ess_app/guardian/settings/how_to_use/tutorial_pages.dart/rs_page2.dart';
import 'package:ess_app/guardian/settings/how_to_use/tutorial_pages.dart/rs_page3.dart';
import 'package:ess_app/guardian/settings/how_to_use/tutorial_pages.dart/rs_page4.dart';
import 'package:ess_app/guardian/settings/how_to_use/tutorial_pages.dart/rs_page5.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ReminderScheduleTutorialPage extends StatefulWidget {
  const ReminderScheduleTutorialPage({super.key});

  @override
  State<ReminderScheduleTutorialPage> createState() => _ReminderScheduleTutorialPageState();
}

class _ReminderScheduleTutorialPageState extends State<ReminderScheduleTutorialPage> {
  PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (value){
              setState(() {
                onLastPage = value == 4 ? true : false;
              });
            },
            children: [
              RsPage1(
                color: Color.fromARGB(255, 171, 231, 255),
              ),
              RsPage2(
                color: Color(0xFFE0FFFF),
              ),
              RsPage3(
                color: Color(0xFFE6E6FA),
              ),
              RsPage4(
                color: Color(0xFFFDF5E6),
              ),
              RsPage5(
                color: Color(0xFFFFCBFC),
              ),

            ],
          ),
          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    _controller.jumpToPage(4);
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      height: 1.75,
                      fontSize: 14,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  count: 5,
                  controller: _controller,
                  effect: WormEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    activeDotColor:AppColors.secondColor
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    if(onLastPage){
                      Navigator.of(context).push(
                        PageTransition(
                          child: HowToUseHome(),
                          type: PageTransitionType.leftToRight,
                        ),
                      );
                    }
                    else{
                      _controller.nextPage(
                        duration: Duration(milliseconds: 500), 
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text(
                    !onLastPage ? 'Next' : 'Done',
                    style: TextStyle(
                      height: 1.75,
                      fontSize: 14,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}