import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ess_app/guardian/edit/edit_entry_image.dart';
import 'package:ess_app/models/memory_model.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import '../memory/memory_home_page.dart';

class ViewEntryImage extends StatefulWidget {
  final MemoryModel memory;
  
  
  const ViewEntryImage({
    required this.memory
  });

  @override
  State<ViewEntryImage> createState() => _ViewEntryImageState();
}

class _ViewEntryImageState extends State<ViewEntryImage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Memory',
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        leading: 
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                PageTransition(
                  child: MemoryHomePage(activePage: 0),
                  type: PageTransitionType.leftToRight,
                ),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )
          ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                //edit
                Navigator.of(context).push(
                  PageTransition(
                    child: EditEntryImage(selectedMemory: widget.memory),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
                size: 30,
              )
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: AppColors.backColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: 20.0),
                //how is your day
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('EEEE, MMM d, yyyy').format(widget.memory.memoryDateTime),
                        overflow: TextOverflow.ellipsis, 
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.grey[600]
                        ),
                      ),
                      SizedBox(height: 5.0),
                      //diary title
                      Container(
                        child: AnimatedTextKit(
                          totalRepeatCount: 1,
                          animatedTexts: [
                            TyperAnimatedText(
                              widget.memory.memoryTitle,
                              textStyle: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w700
                              ),
                            )
                          ],
                        )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                //image
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xFFF2BA05),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: GestureDetector(
                        child: Image.network(
                          widget.memory.memoryImg,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child; // Image loaded successfully, display it
                            }
                            return Center(
                              child: CircularProgressIndicator(), // Show loading indicator
                            );
                          },
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_){
                            return ImageScreen(imgPath: widget.memory.memoryImg);
                          }));
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                //paragraph
                Expanded(
                  flex: 1,
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      color: AppColors.secondColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: AnimatedTextKit(
                          totalRepeatCount: 1,
                          animatedTexts: [
                            TypewriterAnimatedText(
                              widget.memory.memoryDetails,
                              textAlign: TextAlign.justify,
                              textStyle: TextStyle(
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Colors.black,
                              ),
                              speed: Duration(milliseconds: 5),
                            )
                          ],
                        )
                      ),
                    )
                  ),
                ),
                SizedBox(height: 20),
        
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class ImageScreen extends StatelessWidget {
  final String imgPath;
  const ImageScreen({super.key, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              imgPath,
              fit: BoxFit.cover,
            )
          ),
        ),
        onTap: (){
          Navigator.pop(context);
        },
      ),
    );
  }
}
