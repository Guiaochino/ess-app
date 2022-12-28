import 'package:ess_app/guardian/view/view_entry_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../dataList/memories.dart';
import '../../widgets/memory_image_card.dart';

class MemoryImageTab extends StatelessWidget {
  const MemoryImageTab({super.key});
  
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
            //container for gridview contents
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
