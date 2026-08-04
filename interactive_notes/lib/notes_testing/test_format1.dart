import 'package:flutter/material.dart';
// import 'dart:developer';

class TestFormat1 extends StatefulWidget {
  final Map<String, dynamic> questionDetails;
  final Function(String) answerStatus;


  const TestFormat1({
    super.key,
    required this.questionDetails,
    required this.answerStatus,
  });

  @override
  State<TestFormat1> createState() => TestFormat1State();
}

class TestFormat1State extends State<TestFormat1> {
  late String _questionText;
  late String _correctAnswer;
  late List<String> _options;
  late List<String> _shuffledOptions;
  String? _selectedAnswer;
  late List<ElevatedButton> buttonList;

  @override
  void initState() {
    super.initState();
    _selectedAnswer = null;
    _questionText = widget.questionDetails['question'] ?? '';
    _correctAnswer = widget.questionDetails['answer'] ?? '';
    _options = (widget.questionDetails['wrong_ans'] as List)
        .map((w) => w.toString())
        .toList();
    _options.add(_correctAnswer);
    _shuffledOptions = List.from(_options)..shuffle();

    buttonList = [];
  }

  @override
  void didUpdateWidget(TestFormat1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.questionDetails != widget.questionDetails) {
      _questionText = widget.questionDetails['question'] ?? '';
      _correctAnswer = widget.questionDetails['answer'] ?? '';
      _options = (widget.questionDetails['wrong_ans'] as List)
          .map((w) => w.toString())
          .toList();
      _options.add(_correctAnswer);
      _shuffledOptions = List.from(_options)..shuffle();
      _selectedAnswer = null; // reset selection for the new question
    }
  }

  Widget checkAnswer({
    required String selectedAnswer,
    required String correctAnswer,
    required String? explanation
  }) {
    // log('Check Answer');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (selectedAnswer == correctAnswer) ...[
          Text('Correct', style: TextStyle(fontSize: 30, color: Colors.green)),
          Text('Answer: $correctAnswer', style: TextStyle(color: Colors.green)),
        ] else ...[
          Text('Wrong', style: TextStyle(fontSize: 30, color: Colors.red)),
          Text('Your Answer: $selectedAnswer', style: TextStyle(color: Colors.red)),
          SizedBox(height: 8),
          Text('Correct Answer: ', style: TextStyle(fontSize: 30, color: Colors.green)),
          Text(correctAnswer, style: TextStyle(color: Colors.green)),
        ],
        if (explanation != '' && explanation != null)
            Text('\n Explanation: \n $explanation'),
      ],
    );
  }

  

  Color _buttonColor(String answer) {
    if (answer == _selectedAnswer) return Colors.black; 
    return Colors.grey;
  }


  List<Widget> _buildOptionButtons() {
    buttonList = [];
    for (final text in _shuffledOptions) {
      final button = ElevatedButton(
        onPressed: () {
          setState(() => _selectedAnswer = text);
          widget.answerStatus(_selectedAnswer!);  // called after setState, outside it
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _buttonColor(text),
          // backgroundColor: Colors.grey,
          disabledBackgroundColor: _buttonColor(text),
          // disabledBackgroundColor: Colors.black,
          alignment: Alignment.center
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      );
      buttonList.add(button);
    }
    return buttonList
        .map((btn) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: btn,
            ))
        .toList();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _questionText,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [..._buildOptionButtons()]
            ) 
          )
        ],
      )
    );
  }
} 