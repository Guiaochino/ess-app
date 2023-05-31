import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';

class MdPage3 extends StatelessWidget {
  final Color color;
  const MdPage3({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                'assets/images/md2.jpg',
              ),
            ),
            SizedBox(height: 20),
            Text(
              "When adding a memory, include a title or brief summary that describes the memory concisely. \nThen, share any relevant notes, descriptions, or emotions associated with the memory. \n\nFeel free to include who was present, the location, and any significant details that make the memory special. This will help preserve the memory's essence and create a richer experience when revisiting it.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                height: 1.75,
                fontSize: 16,
                color: Colors.grey[800],
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 60),
          ]
        ),
      ),
    );
  }
}