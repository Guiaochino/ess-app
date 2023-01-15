
import 'package:ess_app/patient/view/view_entry_image.dart';
import 'package:flutter/material.dart';

class MemoryCard extends StatelessWidget {
  final int imageId;
  final String title;
  final String details;
  final String dateTime;
  final String imageDirectory;

  const MemoryCard({
    Key? key,
    required this.title,
    required this.details,
    required this.dateTime,
    required this. imageDirectory, required this.imageId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 40;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFE86166), borderRadius: BorderRadius.circular(15)),
        width: width,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ViewEntryImage(
                entryIndex: imageId,
                title: title,
                dateTime:dateTime,
                imgPath: imageDirectory,
                details:details,
              )
            ));
          },
          child: Stack(
            fit: StackFit.expand, 
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), 
                  color: Colors.black
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
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
