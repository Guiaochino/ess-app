import 'package:flutter/material.dart';

class MdPage5 extends StatelessWidget {
  final Color color;
  const MdPage5({super.key, required this.color});

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
                'assets/images/md4.jpg',
              ),
            ),
            SizedBox(height: 20),
            Text(
              "To save your memory entry after adding details and photos, simply tap the 'Save' button. This will preserve your memory, allowing you to open and revisit it whenever you desire.",
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