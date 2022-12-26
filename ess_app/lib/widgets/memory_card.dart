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
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFE86166), borderRadius: BorderRadius.circular(15)),
        width: 200,
        child: Stack(
          children: [
            Image.asset(
              imageDirectory,
              fit: BoxFit.fitWidth,
              height: 700,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black54, 
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
