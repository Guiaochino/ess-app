import 'package:ess_app/utils/dateTime_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ScheduleTabListView extends StatelessWidget {
  final int builderLength;
  final int tileIndex;
  final int entryID;
  final String title;
  final String details;
  final String dateTime;
  final bool isDone;
  final Function(BuildContext)? deleteTapped;
  final Function(BuildContext)? editTapped;

  ScheduleTabListView({
    super.key,
    required this.entryID,
    required this.title,
    required this.details,
    required this.dateTime,
    required this.isDone,
    required this.deleteTapped,
    required this.editTapped, required this.builderLength, required this.tileIndex,

  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // no edit button if sched is done
       startActionPane: isDone == true ? null
       :ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: editTapped,
            backgroundColor: Colors.blue,
            icon: Icons.edit_note,
            label: 'Edit',
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          )
        ],
      ),
      endActionPane: ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: deleteTapped,
            icon: Icons.delete_forever,
            label: 'Delete',
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          child: TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.25,
            beforeLineStyle: LineStyle(
              color: Colors.white.withOpacity(0.7)
            ),
            indicatorStyle: IndicatorStyle(
              indicatorXY: 0.5,
              drawGap: true,
              width: 30,
              height: 30,
              indicator: 
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: isDone? Colors.green: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Icon(
                    isDone? Icons.done : Icons.more_horiz,
                    size: 20,
                    color: Colors.white
                  ),
                ),
            ),
            isFirst: tileIndex == 0? true: false,
            isLast: tileIndex == builderLength - 1? true: false,
            startChild: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Container(
                child: Text(
                  extractTimefromDTString(dateTime),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15
                  ),
                ),
              ),
            ),
            endChild: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
              child: Container(
                height: 60,
                alignment: const Alignment(0.0, -0.70),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  decoration: isDone? TextDecoration.lineThrough: TextDecoration.none,
                                  color: isDone? Colors.grey[300]: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              details,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                decoration: isDone? TextDecoration.lineThrough: TextDecoration.none,
                                color: isDone? Colors.grey[300]: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 12
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                        color: isDone? Colors.green: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: Text(
                          isDone? 'Completed': 'Upcoming',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 10
                            ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}
