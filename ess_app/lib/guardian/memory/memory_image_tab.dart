import 'package:ess_app/guardian/view/view_entry_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../widgets/memory_image_card.dart';

class MemoryImageTab extends StatelessWidget {
  const MemoryImageTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ViewEntryImage()));
        },
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 177, 190, 226),
              Color.fromARGB(255, 200, 204, 218),
              Color.fromARGB(255, 214, 174, 175),
              Color.fromARGB(255, 221, 170, 172),
              Color.fromARGB(255, 233, 170, 172),
              Color.fromARGB(255, 233, 148, 151),
              Color.fromARGB(255, 230, 109, 113),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 40,
                  child: Text('Spare Container'),
                ),
              ),
              //container for gridview contents
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    child: StaggeredGridView.countBuilder(
                      staggeredTileBuilder: (index) => index % 7 == 0
                          ? StaggeredTile.count(2, 2)
                          : StaggeredTile.count(1, 1),
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      crossAxisCount: 3,
                      itemCount: 25,
                      itemBuilder: (context, index) => MemoryImageCard(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
