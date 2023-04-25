import 'package:ess_app/guardian/view/view_entry_image.dart';
import 'package:ess_app/models/memory_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MemoryImageCard extends StatelessWidget {
  final MemoryModel memory;
  final Function(BuildContext)? deleteTapped;
  final Function(BuildContext)? editTapped;

  const MemoryImageCard({
    super.key,
    required this.memory,
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
                memory: memory,
              )
            ));
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
                    memory.memoryImg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(memory.memoryTitle,
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
}
