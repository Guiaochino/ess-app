import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ess_app/constants.dart';
import 'package:ess_app/guardian/edit/edit_entry_image.dart';
import 'package:ess_app/guardian/widgets/popup_dialogs.dart';
import 'package:ess_app/models/memory_model.dart';
import 'package:ess_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';
import '../widgets/memory_image_card.dart';

class MemoryImageTab extends StatefulWidget {
  const MemoryImageTab({super.key});

  @override
  State<MemoryImageTab> createState() => _MemoryImageTabState();
}

class _MemoryImageTabState extends State<MemoryImageTab> {
  //memories from datalist
  final dbconn = DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: Column(
          children: [
            SizedBox(height: 20.0),
            //container for gridview contents
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                    child: StreamBuilder<List<MemoryModel>>(
                        stream: dbconn.memoryData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<MemoryModel> data = snapshot.data!;
                            if (data.isEmpty) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.image_not_supported_outlined,
                                          size: 200,
                                          color: Colors.black,
                                        ),
                                        Text(
                                          'No Images Yet.',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return StaggeredGridView.countBuilder(
                                staggeredTileBuilder: (index) =>
                                    index % 7 == 0
                                        ? StaggeredTile.count(2, 2)
                                        : StaggeredTile.count(1, 1),
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                crossAxisCount: 3,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final docs = data[index];
                                  return MemoryImageCard(
                                      memory: docs,
                                      deleteTapped: (context) {
                                        deleteMemoryEntry(
                                            memoryCollection, docs.uid);
                                      },
                                      editTapped: (context) {
                                        // editMemoryEntry(context, docs);
                                      }, longPressed: () { 
                                        _asyncSimpleDialog(
                                          context, 
                                          (){
                                            editMemoryEntry(context, docs);
                                          },
                                          (){
                                            deleteMemoryEntry(memoryCollection, docs.uid);
                                          }
                                        );
                                       },
                                  );
                                }
                              );
                            }
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return Text('$snapshot.error');
                          }
                        })),
              ),
            )
          ],
        ),
      ),
    );
  }

  //deleting entry in list
  void deleteMemoryEntry(String collectionCaller, String index) {
    dbconn.deleteKeyFromCollectionByID(collectionCaller, index);
    print('Deleted memory at index ' + index);
  }

  //edit
  void editMemoryEntry(BuildContext context, MemoryModel memory){
    Navigator.of(context).push(
      PageTransition(
        child: EditEntryImage(selectedMemory: memory,),
        type: PageTransitionType.rightToLeft,
      ),
    );
  }

  //simple dialog
  Future _asyncSimpleDialog(BuildContext context1,Function editPress, Function deletePress) async {
    return await showDialog(
        context: context1,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Choose an action.'),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                  print('edited in dialog');
                  editPress();
                },
                child: Text('Edit'),
              ),
              SimpleDialogOption(
                onPressed: () async {
                 try {
                    bool? deleteConfirmed = await showConfirmationDialog(context, 'Are you sure you want to delete?');
                    if (deleteConfirmed == true) {
                      // perform deletion
                      deletePress();
                      Navigator.of(context).pop();
                      // deleteTapped;
                      showDeletionSuccessDialog(context, 'Memory deleted successfully!');
                    } else {
                      // user canceled deletion
                      print('cancelled');
                    }
                  } catch (e) {
                    // handle any errors that might occur here
                    print(e);
                  }
                },
                child: Text('Delete'),
              ),
              
            ],
          );
        }
      );
  }
  
  //dialog options
}
