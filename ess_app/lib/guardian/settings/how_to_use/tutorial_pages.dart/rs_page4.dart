import 'package:flutter/material.dart';

class RsPage4 extends StatelessWidget {
  final Color color;
  const RsPage4({super.key, required this.color});

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
                'assets/images/rs3.jpg',
              ),
            ),
            SizedBox(height: 20),
            Text(
              "To save your reminder entry after adding details and time or date, simply tap the 'Save' button. This will schedule an alarm that will notify you when the time comes",
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