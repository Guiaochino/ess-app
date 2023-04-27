import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ess_app/constants.dart';
import 'package:ess_app/guardian/widgets/popup_dialogs.dart';
import 'package:ess_app/helpers.dart';
import 'package:ess_app/models/memory_model.dart';
import 'package:ess_app/services/database.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:image_picker_web/image_picker_web.dart';
import '../memory/memory_home_page.dart';
import 'dart:io';
import 'package:ess_app/services/storage.dart';

class CreateEntryImage extends StatefulWidget {
  const CreateEntryImage({Key? key}) : super(key: key);

  @override
  State<CreateEntryImage> createState() => _CreateEntryImageState();
}

class _CreateEntryImageState extends State<CreateEntryImage> {
  File? _imageSelected;
  // Uint8List? _imageSelectedPC;
  DateTime _datetime = DateTime.now();
  final imagePicker = ImagePicker(); // imagepicker controller
  final titleController = TextEditingController(); //title textfield controller
  final paragraphController = TextEditingController(); //paragraph textfield controller

  final storage = StorageServices(uid: FirebaseAuth.instance.currentUser!.uid);
  final dbconn = DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);

  void dispose() {
    titleController.dispose();
    paragraphController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.backColor,
        elevation: 0,
        leading: (IconButton(
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
          ),
        )),
      ),
      body: SafeArea(
        child: Container(
          color: AppColors.backColor,
          child: Center(
            child: Column(children: [
              SizedBox(height: 10.0),
              //how is your day
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Nice Image!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.grey,
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              //image container
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: _imageSelected == null
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFFF2BA05),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: MaterialButton(
                              onPressed: () {
                                _asyncSimpleDialog(context);
                              },
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate,
                                      color: Colors.black,
                                      size: height > 645 ? 100 : 40,
                                    ),
                                    height > 670 && width > 280
                                        ? Text(
                                            'ADD IMAGE',
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: MaterialButton(
                              onPressed: () {
                                _asyncSimpleDialog(context);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  _imageSelected!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(height: 20.0),
              //memory title
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 50,
                  child: Container(
                    width: width - 40,
                    child: TextField(
                      controller: titleController,
                      textAlignVertical: TextAlignVertical.bottom,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                      decoration: InputDecoration(
                        iconColor: Colors.black,
                        prefixIcon: Icon(Icons.auto_stories, size: 30),
                        border: UnderlineInputBorder(),
                        hintText: 'Enter Memory Title',
                        hintStyle: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
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
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    color: Colors.white,
                    child: TextFormField(
                      controller: paragraphController,
                      maxLines: 40,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        fontSize: 15,
                        height: 2,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: "What's this image about?",
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 5.0,
                          ),
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  onPressed: (){
                    saveMemoryEntry();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.firstColor),
                    overlayColor: MaterialStateProperty.all(Color.fromARGB(255, 230, 177, 5)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )
                    )
                  ),
                  child: Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.save,
                          size: 25,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        width > 280?
                        Text(
                          'Save Memory',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ): Container()
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ]),
          ),
        ),
      ),
    );
  }

  Future <void> saveMemoryEntry() async {
    //null or empty entries
    if (titleController.text == null || titleController.text == '') {
      titleController.text = 'No Title';
    }
    if (paragraphController.text == null || paragraphController.text == '') {
      paragraphController.text = 'No Details';
    }

    print('image path : ');
    print('title : ' + titleController.text);
    print('dateTime: ' + DateTime.now().toString());
    print('details : ' + paragraphController.text);

    //Upload image to Storage
    // Add to Database
    if (_imageSelected != '' && _imageSelected != null) {
      try{
        var upload = await storage.uploadImage( generateUID(), _imageSelected!);

        MemoryModel memoryEntry = new MemoryModel(
          uid: generateUID(), 
          memoryTitle: titleController.text, 
          memoryDateTime: _datetime,
          memoryImg: upload,
          memoryDetails: paragraphController.text);

        dbconn.addData(memoryCollection, memoryEntry);
        print('Memory Entry Added');
        showSuccessDialog(context, 'Your memory entry has been saved.', MemoryHomePage(activePage: 0));
      }catch(e){
        print(e);
      }
    } else {
      showErrorDialog(context, 'Attach an image and try again.');
    }
  }


  //dialog options
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
                  getCameraImage();
                  Navigator.of(context).pop();
                },
                child: Text('Use Camera'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  getImageFiles();
                  Navigator.of(context).pop();
                },
                child: Text('Select from files'),
              ),
              if (_imageSelected != null)
                SimpleDialogOption(
                  onPressed: () {
                    print('remove');
                    setState(() {
                      _imageSelected = null;
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text('Remove Image'),
                )
            ],
          );
        });
  }

  //camera
  Future getCameraImage() async {
    //g
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      // User canceled image selection
      return;
    }
    setState(() {
      _imageSelected = File(image.path);
      print(_imageSelected);
      print('ewe');
    });
  }

  // //image picker from files
  Future getImageFiles() async {
    //for pc
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      // User canceled image selection
      return;
    }
    setState(() {
      _imageSelected = File(image.path);
      print(_imageSelected);
      print('ewe');
    });
  }
}
