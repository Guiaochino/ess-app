import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import '../memory/memory_home_page.dart';
import 'dart:io';

class CreateEntryImage extends StatefulWidget {
  const CreateEntryImage({Key? key}) : super(key: key);

  @override
  State<CreateEntryImage> createState() => _CreateEntryImageState();
}

class _CreateEntryImageState extends State<CreateEntryImage> {

  File? _imageSelected;
  Uint8List? _imageSelectedPC;
  final imagePicker = ImagePicker();
  
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: (IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MemoryHomePage()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 30,
            ))),
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
                    child: (
                      Text(
                        'Nice Image you got here!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 35,
                          shadows: [
                            Shadow(
                              blurRadius: 5.0,
                              color: Colors.grey,
                              offset: Offset(5.0, 5.0),
                            ),
                          ],
                        ),
                      )
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                //image container
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: 
                      _imageSelectedPC == null ?
                      Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFF2BA05),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: MaterialButton(
                          
                          onPressed:() {
                            _asyncSimpleDialog(context);
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate,
                                  color: Colors.black,
                                  size: 100,
                                ),
                                Text(
                                  'ADD IMAGE',
                                  style: TextStyle(
                                    fontSize: 25, 
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    :Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFF2BA05),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: MaterialButton(
                          
                          onPressed:() {
                            _asyncSimpleDialog(context);
                          },
                          child: Image.memory(_imageSelectedPC!),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                //diary title
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    child: Container(
                      width: 250,
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                        decoration: InputDecoration(
                          iconColor: Colors.black,
                          prefixIcon: Icon(Icons.auto_stories, size: 30),
                          border: UnderlineInputBorder(),
                          hintText: 'Enter Diary Title',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                //paragraph
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      color: Colors.white,
                      child: TextFormField(
                        maxLines: 40,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          fontSize: 20,
                          height: 2,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: 'What happened today?',
                          hintStyle: TextStyle(
                            color: Colors.grey[600],
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //save button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2BA05),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.save_alt,
                          size: 35,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ]
            )
          )
        )
      )
    );
  }
  Future _asyncSimpleDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Add image from'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                print('camera');
                getImageFiles();
                  Navigator.of(context).pop();
              },
              child: Text('Use Camera'),
            ),
            SimpleDialogOption(
              onPressed: () {
                print('files');
                Navigator.of(context).pop();
              },
              child: Text('Select from files'),
            ),
            if(_imageSelectedPC != null)
            SimpleDialogOption(
              onPressed: () {
                print('remove');
                setState(() {
                  _imageSelectedPC = null;
                  Navigator.of(context).pop();
                });
              },
              child: Text('Remove Image'),
            )
          ],
        );
      }
    );
  }

  Future getCameraImage() async{
    //g
    final image = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _imageSelected = File(image!.path);
    });
    
  }

  Future getImageFiles() async{
    //for pc
    final image = await ImagePickerWeb.getImageAsBytes();
    setState(() {
      _imageSelectedPC = image;
    });
  }
}


