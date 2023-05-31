import 'package:flutter/material.dart';

class RsPage5 extends StatelessWidget {
  final Color color;
  const RsPage5({super.key, required this.color});

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
                'assets/images/rshome.jpg',
              ),
            ),
            SizedBox(height: 20),
            Text(
              "To manage your reminders and schedule, go to the dedicated section. You can browse, edit, and delete your reminders and alarms there easily. Select a reminder or schedule to make changes, and find the 'Edit' option. Remove any item by selecting it and choosing 'Delete'. Stay in control of your reminders and schedule, personalizing them to suit your needs.",
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