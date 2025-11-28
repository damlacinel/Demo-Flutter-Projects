import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  final List<Map<String, Object>> summaryData;

  const QuestionsSummary({
    super.key, 
    required this.summaryData
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400, //pixels
      child: SingleChildScrollView(
        //only has one direct child
        child: Column(
          children: summaryData.map((data) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              //casting with 'as'
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: 
                (data['correct_answer'] != data['user_answer'])
                ? const Color.fromARGB(255, 217, 62, 244)
                : const Color.fromARGB(255, 68, 155, 226),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  ((data['question_index'] as int) + 1).toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    ),
                  )
                  ),
              //contents out of the screen will be formatted accordingly with expanded
              SizedBox(width:10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //without expanded column (inside of the row) takes infinite 
                  children: [
                    Text(
                      data['question'].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 5),
                    Text(
                      data['user_answer'].toString(),
                      style: TextStyle(
                        color: const Color.fromARGB(255, 195, 76, 216),
                        ),
                      ),
                    SizedBox(height: 5),
                    Text(
                      data['correct_answer'].toString(),
                      style: TextStyle(
                        color: const Color.fromARGB(255, 106, 115, 213),
                      ),
                      //textAlign: TextAlign.left,
                      ),
                  ],
                ),
              ),
            ],
            );
          }).toList(),
          ),
      ),
    );
  }
}