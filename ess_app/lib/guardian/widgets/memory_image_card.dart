import 'package:ess_app/guardian/view/view_entry_image.dart';
import 'package:ess_app/guardian/widgets/popup_dialogs.dart';
import 'package:ess_app/models/memory_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class MemoryImageCard extends StatelessWidget {
  final MemoryModel memory;
  final Function(BuildContext)? deleteTapped;
  final Function(BuildContext)? editTapped;
  final Function() longPressed;

  const MemoryImageCard({
    Key? key,
    required this.memory,
    required this.deleteTapped,
    required this.editTapped,
    required this.longPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onLongPress: longPressed,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ViewEntryImage(
                memory: memory,
              ),
            ),
          );
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 6.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  memory.memoryImg,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      memory.memoryTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      DateFormat('MMM dd, yyyy').format(memory.memoryDateTime),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}