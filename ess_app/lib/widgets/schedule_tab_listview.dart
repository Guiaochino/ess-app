import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ScheduleTabListView extends StatelessWidget {
  // final String scheduleTitle;
  // final String scheduleDetails;
  // final String scheduleDateTime;
  // final bool eventDone;
  // final Function(bool?)? onChanged;
  // final Function(BuildContext)? deleteTapped;

  ScheduleTabListView({
    super.key,
    // required this.scheduleTitle,
    // required this.scheduleDetails,
    // required this.eventDone,
    // // required this.scheduleDateTime,
    // required this.onChanged,
    // required this.deleteTapped
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Slidable(
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: ((context) {
                //edit
              }),
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
              onPressed: (context) {},
              icon: Icons.delete_forever,
              label: 'Delete',
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
            )
          ],
        ),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Column(
                children: [
                  //1st column - icon and title
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      TimeOfDay.now()
                                          .format(context)
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Container(
                                    width: 5,
                                    height: 50,
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "sampleTitle",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //2nd Column -  schedule details
                  // Expanded(
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 10.0, horizontal: 10.0),
                  //     child: Container(
                  //       child: Container(
                  //         child: Text('Nostrud laboris ex dolor consequat ut. Ut Lorem aliquip culpa elit sit cupidatat esse nostrud consequat id. Esse nulla nisi laboris tempor. Adipisicing sint eu occaecat ad. Ad minim ad nisi qui irure reprehenderit tempor dolore do veniam.',
                  //             maxLines: 4,
                  //             overflow: TextOverflow.ellipsis,
                  //             textAlign: TextAlign.justify,
                  //             style: TextStyle(
                  //                 fontSize: 15, color: Colors.grey)),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // //3rd Column - view details
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Container(
                  //       height: 50,
                  //       width: 150,
                  //       child: Center(
                  //           child: Row(
                  //         children: [
                  //           Icon(
                  //             Icons.date_range,
                  //             color: Color(0xFFE86166),
                  //           ),
                  //           SizedBox(width: 10),
                  //           Text(extractDatefromDTString(scheduleDateTime),
                  //               style: TextStyle(
                  //                 color: Color(0xFFE86166),
                  //                 fontWeight: FontWeight.normal,
                  //                 fontSize: 15,
                  //               )),
                  //         ],
                  //       )),
                  //     ),
                  //     Container(
                  //       height: 50,
                  //       width: 120,
                  //       child: Center(
                  //           child: Row(
                  //         children: [
                  //           Icon(
                  //             Icons.watch_later,
                  //             color: Color(0xFFE86166),
                  //           ),
                  //           SizedBox(width: 10),
                  //           Text(extractTimefromDTString(scheduleDateTime),
                  //               style: TextStyle(
                  //                 color: Color(0xFFE86166),
                  //                 fontWeight: FontWeight.normal,
                  //                 fontSize: 15,
                  //               )),
                  //         ],
                  //       )),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
