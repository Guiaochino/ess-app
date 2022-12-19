import 'package:flutter/material.dart';

class MemoryCard extends StatelessWidget {
  final String imageDirectory;

  const MemoryCard({
    Key? key,
    required this.imageDirectory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFE86166), borderRadius: BorderRadius.circular(15)),
        width: 200,
        child: Stack(
          children: [
            Image.asset(
              imageDirectory,
              fit: BoxFit.fill,
              height: 700,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Image title",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
