import 'package:ess_app/utils/colors.dart';
import 'package:flutter/material.dart';

class MdPage2 extends StatelessWidget {
  final Color color;
  const MdPage2({super.key, required this.color});

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
                'assets/images/md1.jpg',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Tap on the Add button, located at the middle-bottom of the screen. \n\nSelect the appropriate option to create a new memory entry either through image or through diary.',
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