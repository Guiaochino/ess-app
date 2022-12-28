import 'package:flutter/material.dart';
import '../memory/memory_home_page.dart';

class ViewEntryImage extends StatelessWidget {

  final String title;
  final String dateTime;
  final String imgPath;
  final String details;
  
  
  const ViewEntryImage({
    super.key,
    required this.title,    
    required this.dateTime,
    required this.imgPath,
    required this.details,
  });
  

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: 
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MemoryHomePage()));
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 30,
              )
            ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: () {
                  //edit
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
            
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  //how is your day
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: (Text(
                        'Nice Image you got here!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.grey,
                              offset: Offset(5.0, 5.0),
                            ),
                          ],
                        ),
                      )),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  //image
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 7,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xFFF2BA05),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  imgPath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  //diary title
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Container(
                        width: 250,
                        child: Text(
                          title,            
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  //paragraph
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        color: Colors.white,
                        child: TextFormField(
                          initialValue: details,
                          textAlign: TextAlign.justify,
                          maxLines: 40,
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(
                            fontSize: 20,
                            height: 2,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                              hintText: 'populate image details here',
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              )),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  SizedBox(height: 20),
        ])))));
  }
}
