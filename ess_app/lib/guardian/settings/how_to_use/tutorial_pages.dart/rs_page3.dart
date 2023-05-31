import 'package:flutter/material.dart';

class RsPage3 extends StatelessWidget {
  final Color color;
  const RsPage3({super.key, required this.color});

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
                'assets/images/rs2.jpg',
              ),
            ),
            SizedBox(height: 20),
            Text(
              "When adding a reminder or schedule, include a title or brief summary or any relevant notes. This will help you immediately remember what the alarm is about when it notifies you \n\n For schedules, you can add a date for a special occassion or event that is not a daily reminder",
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