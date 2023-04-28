import 'package:ess_app/models/schedule_model.dart';
import 'package:flutter/material.dart';

class UpSchedCard extends StatelessWidget {
  final ScheduleModel schedule;

  UpSchedCard({
   required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 47, 92, 150).withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Icon(
              Icons.notifications_active,
              size: 30,
              color: Color.fromARGB(255, 47, 92, 150), 
            ),
          ),
        //schedule date
        title: Text(
          schedule.schedTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat',
            fontSize: 20,
            color: Colors.black
          ),
        ),
        //schedule details
        subtitle: Text(
          schedule.schedDetails,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            fontFamily: 'Montserrat',
            color: Colors.grey[600],
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
              schedule.schedDateTime.toString(),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                fontFamily: 'Montserrat',
                color: Colors.grey[200],
              )
            ),
          )
        )
      ),
    );
  }
}
