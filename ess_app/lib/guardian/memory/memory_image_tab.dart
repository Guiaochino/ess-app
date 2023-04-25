import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ess_app/constants.dart';
import 'package:ess_app/guardian/edit/edit_entry_image.dart';
import 'package:ess_app/models/memory_model.dart';
import 'package:ess_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
                                          editMemoryEntry(context, docs);
                                        });
                                  });
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

  // delete? yes or no
  AwesomeDialog deleteDialog(BuildContext context, int index) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
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
      title: 'Delete Entry?',
      titleTextStyle: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: Colors.green,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      desc: 'Are you sure you want to delete this diary entry?',
      btnOkText: 'Yes',
      btnOkColor: Color(0xFFE86166),
      btnCancelColor: Colors.blue,
      btnCancelText: 'No',
      btnOkOnPress: () {
        print('yes');
      },
      btnCancelOnPress: () {
        print('no');
      },
      padding: EdgeInsets.all(15),
      showCloseIcon: false,
    );
  }

  //delete successfully
  AwesomeDialog deleteSuccessDialog(BuildContext context) {
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
      title: 'Deleted Successfully',
      titleTextStyle: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: Colors.green,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      onDissmissCallback: (type) {
        // Navigator.of(context).pop();
      },
      padding: EdgeInsets.all(15),
      showCloseIcon: false,
      autoHide: Duration(seconds: 3),
    );
  }

  //deleting entry in list
  void deleteMemoryEntry(String collectionCaller, String index) {
    dbconn.deleteKeyFromCollectionByID(collectionCaller, index);
    print('Deleted memory at index ' + index);
    deleteSuccessDialog(context).show();
  }

  //edit
  void editMemoryEntry(BuildContext context, MemoryModel memory) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditEntryImage(selectedMemory: memory)));
  }
}
