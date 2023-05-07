import 'package:ess_app/guardian/view/view_entry_image.dart';
import 'package:ess_app/guardian/widgets/popup_dialogs.dart';
import 'package:ess_app/models/memory_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MemoryImageCard extends StatelessWidget {
  final MemoryModel memory;
  final Function(BuildContext)? deleteTapped;
  final Function(BuildContext)? editTapped;
  final Function()longPressed;

  const MemoryImageCard({
    super.key,
    required this.memory,
    required this.deleteTapped, 
    required this.editTapped, required this.longPressed,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onLongPress: longPressed,
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
                child: Image.network(
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
    );
  }
}

