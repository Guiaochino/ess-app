import 'package:ess_app/guardian/edit/edit_entry_image.dart';
import 'package:ess_app/models/memory_model.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import '../memory/memory_home_page.dart';

class ViewEntryImage extends StatelessWidget {
  final MemoryModel memory;
  
  
  const ViewEntryImage({
    required this.memory
  });

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
                    child: EditEntryImage(selectedMemory: memory),
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
                        DateFormat('EEEE, MMM d, yyyy').format(memory.memoryDateTime),
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
                        child: Text(
                          memory.memoryTitle,
                          maxLines: 2, 
                          overflow: TextOverflow.ellipsis,  
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                //image
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_){
                        return ImageScreen(imgPath: memory.memoryImg);
                      }));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        children: [
                          Image.network(
                            memory.memoryImg,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Text(
                              DateFormat('hh:mm aa').format(memory.memoryDateTime),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
                        child: Text(
                          memory.memoryDetails,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Colors.black
                          ),
                        ),
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
