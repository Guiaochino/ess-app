import 'package:ess_app/models/diary_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiaryCard extends StatelessWidget {
  final DiaryModel diary;

  const DiaryCard({
    Key? key,
    required this.diary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 40;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE86166),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('MMM d, yyyy').format(diary.diaryDateTime),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.7),
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  Icon(
                    icon(diary.emoteRate),
                    size: 30,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                diary.diaryTitle,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              Text(
                diary.diaryDetails,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.7),
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  IconData icon(int index) {
    IconData iconRate = Icons.sentiment_neutral_outlined;
    switch (index) {
      case 1:
        iconRate = Icons.sentiment_very_dissatisfied_outlined;
        break;
      case 2:
        iconRate = Icons.sentiment_very_dissatisfied;
        break;
      case 3:
        iconRate = Icons.sentiment_dissatisfied;
        break;
      case 4:
        iconRate = Icons.sentiment_neutral_rounded;
        break;
      case 5:
        iconRate = Icons.sentiment_satisfied;
        break;
      case 6:
        iconRate = Icons.sentiment_satisfied_outlined;
        break;
      case 7:
        iconRate = Icons.sentiment_very_satisfied_outlined;
        break;
    }
    return iconRate;
  }
}
