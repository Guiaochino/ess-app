import 'package:ess_app/guardian/view/view_entry_schedule.dart';
import 'package:ess_app/models/schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ScheduleTabListView extends StatelessWidget {
  final int builderLength;
  final int tileIndex;
  final ScheduleModel schedule;
  final Function(BuildContext)? deleteTapped;
  final Function(BuildContext)? editTapped;
  bool _isDone = false;

  ScheduleTabListView({
    super.key,
    required this.schedule,
    required this.deleteTapped,
    required this.editTapped, required this.builderLength, required this.tileIndex,

  }){
    if (schedule.schedDateTime.isBefore(DateTime.now())) {
      _isDone = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // no edit button if sched is done
       startActionPane: _isDone == true ? null
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
              thickness: 2,
              color: Colors.white.withOpacity(0.7)
            ),
            indicatorStyle: IndicatorStyle(
              indicatorXY: 0.5,
              drawGap: true,
              width: 20,
              height: 20,
              padding: EdgeInsets.symmetric(vertical: 6),
              indicator: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: _isDone? Colors.green: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Icon(
                  _isDone? Icons.done : Icons.more_horiz,
                  size: 10,
                  color: Colors.white
                ),
              ),
            ),
            isFirst: tileIndex == 0? true: false,
            isLast: tileIndex == builderLength - 1? true: false,
            startChild: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    DateFormat('hh:mm aa').format(schedule.schedDateTime),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15
                    ),
                  ),
                ),
              ),
            ),
            endChild: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    PageTransition(
                      child: ViewEntrySchedule(
                        schedule: schedule,
                      ),
                      type: PageTransitionType.bottomToTop
                    )
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 60,
                  alignment: const Alignment(0.0, -0.70),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 5,
                          decoration: BoxDecoration(
                            color: _isDone? Colors.green: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  schedule.schedTitle,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    decoration: _isDone? TextDecoration.lineThrough: TextDecoration.none,
                                    color: _isDone? Colors.grey[700]: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Expanded(
                              child: Text(
                                schedule.schedDetails,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  decoration: _isDone? TextDecoration.lineThrough: TextDecoration.none,
                                  color: _isDone? Colors.grey[700]: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   height: 30,
                      //   width: 70,
                      //   decoration: BoxDecoration(
                      //     color: _isDone? Colors.green: Colors.red,
                      //     borderRadius: BorderRadius.all(Radius.circular(10)),
                      //   ),
                      //   child: Center(
                      //     child: Text(
                      //       _isDone? 'Completed': 'Upcoming',
                      //       maxLines: 1,
                      //       overflow: TextOverflow.ellipsis,
                      //       style: TextStyle(
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.w500,
                      //           fontSize: 10
                      //         ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}
