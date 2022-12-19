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
    return Container(
      height: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 10.0,
              bottom: 10.0,
            ),
            child: Container(
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
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.notifications_active_outlined,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 12.0, left: 20.0, bottom: 12.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      scheduleDate,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      scheduleDetails,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              right: 10.0,
              bottom: 10.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(scheduleTime,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.grey[200],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
