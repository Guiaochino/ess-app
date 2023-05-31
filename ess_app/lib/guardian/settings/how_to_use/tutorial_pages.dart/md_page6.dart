import 'package:flutter/material.dart';

class MdPage6 extends StatelessWidget {
  final Color color;
  const MdPage6({super.key, required this.color});

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
                'assets/images/mdhome.jpg',
              ),
            ),
            SizedBox(height: 20),
            Text(
              "To manage your memories, go to the 'Memories' section. There, you can browse and edit any memory by changing the photo or details. If you want to remove a memory, go to its page and look for the 'Delete' option. This way, you have full control over your memories, keeping them organized and cherished according to your preferences.",
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