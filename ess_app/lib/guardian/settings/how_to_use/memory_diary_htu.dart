import 'package:ess_app/guardian/settings/how_to_use/how_to_use_home.dart';
import 'package:ess_app/guardian/settings/how_to_use/tutorial_pages.dart/md_page1.dart';
import 'package:ess_app/guardian/settings/how_to_use/tutorial_pages.dart/md_page2.dart';
import 'package:ess_app/guardian/settings/how_to_use/tutorial_pages.dart/md_page3.dart';
import 'package:ess_app/guardian/settings/how_to_use/tutorial_pages.dart/md_page4.dart';
import 'package:ess_app/guardian/settings/how_to_use/tutorial_pages.dart/md_page5.dart';
import 'package:ess_app/guardian/settings/how_to_use/tutorial_pages.dart/md_page6.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MemoryDiaryTutorialPage extends StatefulWidget {
  const MemoryDiaryTutorialPage({super.key});

  @override
  State<MemoryDiaryTutorialPage> createState() => _MemoryDiaryTutorialPageState();
}

class _MemoryDiaryTutorialPageState extends State<MemoryDiaryTutorialPage> {
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
                onLastPage = value == 5 ? true : false;
              });
            },
            children: [
              MdPage1(
                color: Color.fromARGB(255, 171, 231, 255),
              ),
              MdPage2(
                color: Color(0xFFE0FFFF),
              ),
              MdPage3(
                color: Color(0xFFE6E6FA),
              ),
              MdPage4(
                color: Color(0xFFFDF5E6),
              ),
              MdPage5(
                color: Color(0xFFFFCBFC),
              ),
              MdPage6(
                color: Color(0xFFABB1FF),
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
                    _controller.jumpToPage(5);
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
                  count: 6,
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