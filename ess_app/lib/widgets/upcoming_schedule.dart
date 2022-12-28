import 'package:flutter/material.dart';

class UpSchedCard extends StatelessWidget {
  final String scheduleDate;
  final String scheduleDetails;
  final String scheduleTime;

  UpSchedCard({
    required this.scheduleDate,
    required this.scheduleDetails,
    required this.scheduleTime,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 158, 106, 255),
                Color.fromARGB(255, 106, 115, 247),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            Icons.notifications_active,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      //schedule date
      title: Text(
        scheduleDate,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Colors.black
        ),
      ),
      //schedule details
      subtitle: Text(
        scheduleDetails,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.grey[600]
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          //schedule time
          child: Text(
            scheduleTime,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Colors.grey[200],
            )
          ),
        )
      )
    );
  }
}
