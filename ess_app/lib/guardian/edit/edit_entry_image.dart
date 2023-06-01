import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ess_app/guardian/memory/memory_home_page.dart';
import 'package:ess_app/guardian/widgets/popup_dialogs.dart';
import 'package:ess_app/models/memory_model.dart';
import 'package:ess_app/services/database.dart';
import 'package:ess_app/services/storage.dart';
import 'package:ess_app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:image_picker_web/image_picker_web.dart';

class EditEntryImage extends StatefulWidget {
  final MemoryModel selectedMemory;
  
  const EditEntryImage({required this.selectedMemory});

  @override
  State<EditEntryImage> createState() => _EditEntryImageState(memory: selectedMemory);
}

class _EditEntryImageState extends State<EditEntryImage> {
  MemoryModel memory;
  _EditEntryImageState({required this.memory});

  File? _imageSelected;
  // Uint8List? _imageSelectedPC;
  final imagePicker = ImagePicker(); // imagepicker controller
  final titleController = TextEditingController(); //title textfield controller
  final paragraphController = TextEditingController(); //paragraph textfield controller
  final storage = StorageServices(uid: FirebaseAuth.instance.currentUser!.uid);
  final dbconn = DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);
  String _imageUrl = '';
  bool _noImgFromDevice = true;

  //load memory data
  void initState(){
    titleController.text = memory.memoryTitle;
    paragraphController.text = memory.memoryDetails;
    _imageUrl = memory.memoryImg;
    super.initState();
  }

  void dispose(){
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
        leading: IconButton(
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
        ),
      ),
      body: SafeArea(
        child: Container(
          color: AppColors.backColor,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  //how is your day
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: (
                        Text(
                          'Edit memory',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                          ),
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  //image container
                  Expanded(
                    child: 
                      _imageSelected == null ?
                      Container(
                        child: 
                        _noImgFromDevice == false ?
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
                                    size: height > 645? 100: 40,
                                  ),
                                  height > 670 && width > 280 ?
                                  Text(
                                    'ADD IMAGE',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 25, 
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ): Container()
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: GestureDetector(
                              child: Image.network(
                                memory.memoryImg,
                                fit: BoxFit.cover,
                              ),
                              onLongPress: (){
                                _asyncSimpleDialog(context);
                              },
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_){
                                  return ImageScreen(imgPath: memory.memoryImg);
                                }));
                              },
                            ),
                          ),
                        ),
                      )
                    :Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: MaterialButton(
                          
                          onPressed:() {
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
                  SizedBox(height: 20.0),
                  //memory title
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 50,
                      child: Container(
                        width: width - 40,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.bottom,
                          controller: titleController,
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
                  SizedBox(height: 20),
                  //save button
                  ElevatedButton(
                    onPressed: (){
                      saveMemoryEntry();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFFF2BA05)),
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
                            Icons.save_alt,
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
                  SizedBox(height: 20),
                ]
              ),
            )
          )
        )
      )
    );
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
            if(_imageSelected != null)
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  _imageSelected = null;
                  _noImgFromDevice = true;
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
  
  //camera
  Future getCameraImage() async{
    //g
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      // User canceled image selection
      return;
    }
    setState(() {
      _imageSelected = File(image.path);
      print(_imageSelected);
      _noImgFromDevice = false;
    });
    
  }
  //image picker from files
  Future getImageFiles() async{
    //for pc
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      // User canceled image selection
      return;
    }
    setState(() {
      _imageSelected = File(image.path);
      print(_imageSelected);
      _noImgFromDevice = false;
    });
  }


  //saving memory
  Future<void> saveMemoryEntry() async {

    //null or empty entries
    if(titleController.text == null || titleController.text == ''){
      titleController.text = 'No Title';
    }
    if(paragraphController.text == null || paragraphController.text == ''){
      paragraphController.text = 'No Details';
    }
    
    if(_imageSelected != '' && _imageSelected != null || _imageUrl != ''){
      setState(() {
        memory.memoryTitle = titleController.text;
        memory.memoryDetails = paragraphController.text;
      },
      );
      print(_noImgFromDevice);
      try{
        if(_noImgFromDevice){
          dbconn.updateMemoryByID(memory.uid, memory);
          showSuccessDialog(context, 'Your memory entry has been saved.', MemoryHomePage(activePage: 0));
        }
        else{
          var upload = await storage.uploadImage(memory.uid, _imageSelected!);

          setState(() {
            memory.memoryImg = upload;
          },
          );
          dbconn.updateMemoryByID(memory.uid, memory);
          print(memory);
          showSuccessDialog(context, 'Your memory entry has been saved.', MemoryHomePage(activePage: 0));
          print('success');
        }
      }catch(e){
        print(e);
      }
    }
    else{
      showErrorDialog(context, 'Attach an image and try again.');
    }
    
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


