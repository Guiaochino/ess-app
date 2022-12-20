import 'package:flutter/material.dart';

class MemoryImageCard extends StatelessWidget {
  const MemoryImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.black),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(19),
          child: Opacity(
            opacity: 0.5,
            child: Image.asset(
              'images/IreneImage.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Center(
        child: Text('Image Title',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      )
    ]);
  }
}
