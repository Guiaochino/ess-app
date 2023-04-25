import 'package:ess_app/guardian/view/view_entry_image.dart';
import 'package:ess_app/models/memory_model.dart';
import 'package:flutter/material.dart';

class MemoryCard extends StatelessWidget {
  final MemoryModel memory;

  const MemoryCard({
    Key? key,
    required this.memory
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 40;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFE86166), borderRadius: BorderRadius.circular(15)),
        width: width,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ViewEntryImage(
                memory: memory
              )
            ));
          },
          child: Stack(
            fit: StackFit.expand, 
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), 
                  color: Colors.black
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(19),
                  child: Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      memory.memoryImg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  memory.memoryTitle,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
