import 'package:flutter/material.dart';

class RsPage1 extends StatelessWidget {
  final Color color;
  const RsPage1({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Open the app and look for "Reminders" or "Schedule" section, usually represented by an icon or tab labeled or with a relevant image.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                height: 1.75,
                fontSize: 16,
                color: Colors.grey[800],
                fontWeight: FontWeight.w600
              ),
            ),
          ]
        ),
      ),
    );
  }
}