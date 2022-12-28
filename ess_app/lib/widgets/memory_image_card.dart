import 'package:ess_app/guardian/view/view_entry_image.dart';
import 'package:flutter/material.dart';

class MemoryImageCard extends StatelessWidget {
  final String title;
  final String details;
  final String dateTime;
  final String imageDirectory;

  const MemoryImageCard({
    super.key,
    required this.title,
    required this.details,
    required this.dateTime,
    required this. imageDirectory,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ViewEntryImage(
            title: title,
            dateTime:dateTime,
            imgPath: imageDirectory,
            details:details,
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
    );
  }
}
