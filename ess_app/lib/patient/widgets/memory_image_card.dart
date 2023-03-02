
import 'package:ess_app/patient/view/view_entry_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MemoryImageCard extends StatelessWidget {
  final int memoryIndex;
  final String title;
  final String details;
  final String dateTime;
  final String imageDirectory;
  final Function(BuildContext)? deleteTapped;
  final Function(BuildContext)? editTapped;

  const MemoryImageCard({
    super.key,
    required this.memoryIndex,
    required this.title,
    required this.details,
    required this.dateTime,
    required this. imageDirectory,
    required this.deleteTapped, 
    required this.editTapped,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Slidable(
        closeOnScroll: true,
          startActionPane: ActionPane(
            motion: DrawerMotion(),
            children: [
              SlidableAction(
                autoClose: true,
                onPressed: editTapped,
                backgroundColor: Colors.blue,
                icon: Icons.edit_note,
                label: 'Edit',
                borderRadius: BorderRadius.circular(20),
              )
            ],
          ),
          endActionPane: ActionPane(
            motion: DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: deleteTapped, //delete function
                icon: Icons.delete_forever,
                label: 'Delete',
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.circular(20),
              )
            ],
          ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ViewEntryImage(
                entryIndex: memoryIndex,
                title: title,
                dateTime:dateTime,
                imgPath: imageDirectory,
                details:details,
              )
            ));
          },
          onLongPress: () {
            _asyncSimpleDialog(context);
          },
          child: Stack(fit: StackFit.expand, children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), 
                color: Colors.black,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(19),
                child: Opacity(
                  opacity: 0.5,
                  child: Image.asset(
                    imageDirectory,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
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
                editTapped;
              },
              child: Text('Edit Memory'),
            ),
            SimpleDialogOption(
              onPressed: () {
                deleteTapped;
              },
              child: Text('Delete Memory'),
            )
          ],
        );
      }
    );
  }

}
