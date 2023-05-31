import 'package:flutter/material.dart';

class MdPage4 extends StatelessWidget {
  final Color color;
  const MdPage4({super.key, required this.color});

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
                'assets/images/md3.jpg',
              ),
            ),
            SizedBox(height: 20),
            Text(
              "For Image Memories, You can add a photo to your memory by choosing a picture you already have or take a new one using the camera. Select the image that reminds you of the memory or capture a new photo in the app. This way, you can easily include your favorite pictures to make your memories more special.",
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