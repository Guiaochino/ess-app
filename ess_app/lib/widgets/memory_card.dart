import 'package:flutter/material.dart';

class MemoryCard extends StatelessWidget {
  final String title;
  final String details;
  final String dateTime;
  final String imageDirectory;

  const MemoryCard({
    Key? key,
    required this.title,
    required this.details,
    required this.dateTime,
    required this. imageDirectory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFE86166), borderRadius: BorderRadius.circular(15)),
        width: 200,
        child: Stack(
          fit: StackFit.expand, 
          children: [
            Container(
              height: 50,
              width: 50,
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
    );
  }
}
