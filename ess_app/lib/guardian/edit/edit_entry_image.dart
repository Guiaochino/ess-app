import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ess_app/guardian/memory/memory_home_page.dart';
import 'package:ess_app/models/memory_model.dart';
import 'package:ess_app/utils/colors.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  late MemoryModel memoryEntry;

  //load memory data
  void initState(){
    memoryEntry = memory;
    titleController.text = memoryEntry.memoryTitle;
    paragraphController.text = memoryEntry.memoryDetails;
  }

  void dispose(){
    titleController.dispose();
    paragraphController.dispose();
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
                MaterialPageRoute(builder: (context) => MemoryHomePage(activePage: 0,)));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 30,
            ))),
      ),
      body: SafeArea(
        child: Container(
          color: AppColors.backColor,
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
                        'Edit memory',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
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
                      _imageSelected == null ?
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
                ),
                SizedBox(height: 20.0),
                //memory title
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    child: Container(
                      width: width - 60,
                      child: TextField(
                        controller: titleController,
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
                          hintText: 'Enter Memory Title',
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
                        controller: paragraphController,
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
                  child: ElevatedButton(
                    onPressed: (){
                      saveMemoryEntry();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFFF2BA05)),
                      overlayColor: MaterialStateProperty.all(Color.fromARGB(255, 230, 177, 5)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )
                      )
                    ),
                    child: Container(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.save_alt,
                            size: 35,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10),
                          width > 280?
                          Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ): Container()
                        ],
                      ),
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

  
  //
  AwesomeDialog errorDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      borderSide: BorderSide(
        color: Color(0xFFE86166),
        width: 2,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      title: 'No Image!',
      desc: 'Attach an image and try again.',
      titleTextStyle: TextStyle(
        color: Colors.red,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      descTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      padding: EdgeInsets.all(15),
      showCloseIcon: false,
      autoHide: Duration(seconds: 3),
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
                print('camera');
                  Navigator.of(context).pop();
              },
              child: Text('Use Camera'),
            ),
            SimpleDialogOption(
              onPressed: () {
                print('files');
                // getImageFiles();
                Navigator.of(context).pop();
              },
              child: Text('Select from files'),
            ),
            if(_imageSelected != null)
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
      }
    );
  }
  
  //camera
  // Future getCameraImage() async{
  //   //g
  //   final image = await imagePicker.getImage(source: ImageSource.camera);
  //   setState(() {
  //     _imageSelected = File(image!.path);
  //   });
    
  // }
  // //image picker from files
  // Future getImageFiles() async{
  //   //for pc
  //   final image = await ImagePickerWeb.getImageAsBytes();
  //   setState(() {
  //     _imageSelectedPC = image;
  //   });
  // }

  //success dialog
  AwesomeDialog successDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      borderSide: BorderSide(
        color: Color(0xFFE86166),
        width: 2,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      title: 'Edited Successfully!',
      titleTextStyle: TextStyle(
        color: Colors.green,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      onDissmissCallback:(type) {
        Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MemoryHomePage(activePage: 0,)));
      },
      padding: EdgeInsets.all(15),
      showCloseIcon: false,
      autoHide: Duration(seconds: 3),
    );
  }

  //saving memory
  void saveMemoryEntry() {

    //null or empty entries
    if(titleController.text == null || titleController.text == ''){
      titleController.text = 'No Title';
    }
    if(paragraphController.text == null || paragraphController.text == ''){
      paragraphController.text = 'No Details';
    }
    
    if(_imageSelected != '' && _imageSelected != null){

      //save to memoryList
      setState(() {
        memory.memoryTitle = titleController.text;
        memory.memoryDateTime = DateTime.now();
        memory.memoryDetails = paragraphController.text;
      },);
      
      print('Memory Entry Edited');
      successDialog(context).show();
    }
    else{
      errorDialog(context).show();
    }
    
  }
}


