import 'package:ess_app/guardian/view/view_entry_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../dataList/memories.dart';
import '../../widgets/memory_image_card.dart';

class MemoryImageTab extends StatefulWidget {
  const MemoryImageTab({super.key});

  @override
  State<MemoryImageTab> createState() => _MemoryImageTabState();
}

class _MemoryImageTabState extends State<MemoryImageTab> {
  //memories from datalist
  final List<Memory> memories = memoryList;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: Column(
          children: [
            SizedBox(height: 20.0),
            //container for gridview contents
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  child: memories.isEmpty?
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.image_not_supported_outlined,
                                size: 200,
                                color: Colors.black,
                              ),
                              Text(
                                'No Images Yet.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                    //builder for gridview
                    :StaggeredGridView.countBuilder(
                    staggeredTileBuilder: (index) => index % 7 == 0
                      ? StaggeredTile.count(2, 2)
                      : StaggeredTile.count(1, 1),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    crossAxisCount: 3,
                    itemCount: memories.length,
                    itemBuilder: (context, index) {
                      final memory = memories[index];
                      return MemoryImageCard(
                        title: memory.memoryTitle,
                        details: memory.memoryDetails,
                        imageDirectory: memory.memoryImg,
                        dateTime: memory.memoryDateTime,
                      );
                    }
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
