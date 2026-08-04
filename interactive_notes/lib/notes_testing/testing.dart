import 'package:flutter/material.dart';
// import 'package:interactive_notes/data/user_data.dart';
import 'dart:math';
import 'package:interactive_notes/homepage/app_bar.dart'; // file
import 'package:interactive_notes/notes_testing/test_format1.dart'; // file
import 'package:interactive_notes/notes_testing/submit_nav_bar.dart'; // file

class TestingPage extends StatefulWidget {
  final Map<String, dynamic> note;
  const TestingPage({super.key, required this.note});
  @override
  State<TestingPage> createState() => _TestingPage();
}

class _TestingPage extends State<TestingPage> {
  late List<Map<String, dynamic>> questions;
  late int _currentIndex;            // index into _questions for the question on screen
  late List<int> _remainingIndices;  // indices not yet answered correctly
  late dynamic selectedAnswer;

  @override
  void initState() {
    super.initState();

    // question_list is already a List<Map<String, dynamic>> on widget.note
    // (that's what UserPrefs.getNote / getAllNotes returns), so no async
    // UserPrefs call is needed here — initState can't await anyway.
    questions = List<Map<String, dynamic>>.from(widget.note['question_list'] ?? []);

    /* each entry looks like:
        {
          'question': 'What is the derivative of x²?',
          'answer': '2x',
          'wrong_ans': ['x', 'x²', '2'],
          'explanation': 'differentiate'
        }
    */

    selectedAnswer = '';

    if (questions.isNotEmpty) {
      _remainingIndices = List<int>.generate(questions.length, (i) => i);
      _currentIndex = _remainingIndices[Random().nextInt(_remainingIndices.length)];
    } else {
      _remainingIndices = [];
      _currentIndex = -1; // no question available
    }
  }

  void _goToNext() {
    // use isEmpty, not == [] (list equality doesn't work that way in Dart)
    if (_remainingIndices.isEmpty) {
      // Navigator.pop(context); // or push to a results page
      showDialog(
        context: context, 
        builder: (dialogContext) => AlertDialog(
          title: Text('Finished Revision!'),
          // content: Text(''),
          actions: [
            Align(
              alignment: Alignment.center,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, // text/icon color
                  backgroundColor: Colors.green, // button background
                ),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  Navigator.pop(context);
                },
                child: Text('Exit'),
              ),
            )
          ]
        )
      );
    } else {
      setState(() {
        selectedAnswer = '';
        _currentIndex = _remainingIndices[Random().nextInt(_remainingIndices.length)];
      });
    }
  }

  void _removeQuestion() {
    // if scored correctly, no need to test again — remove by value, not position
    _remainingIndices.remove(_currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex == -1) {
      // no questions in this note
      return Scaffold(
        appBar: MyAppBar(
          title: widget.note['note_name'],
          onToggleDisplay: null,
        ),
        body: const Center(child: Text('No questions in this note yet.')),
      );
    }

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
      child: Scaffold(
        appBar: MyAppBar(
          // title: ('${widget.note['note_name']}: \t ${_currentIndex+1}/${questions.length}'),
          title: ('${widget.note['note_name']}: \t ${(questions.length - _remainingIndices.length+1)}/${questions.length}'),
          
          onToggleDisplay: null,
        ),
        body: TestFormat1(
          questionDetails: questions[_currentIndex],
          answerStatus: (value) {
            setState(() {
              selectedAnswer = value;
            });
          },
        ),
        bottomNavigationBar: SubmitBottomNavBar(
          canSubmit: selectedAnswer != '',
          onSubmit: (value) {
            if (value == 'Submit') {
              String correctAnswer = questions[_currentIndex]['answer'];
              String? explanation = questions[_currentIndex]['explanation'];
              if (selectedAnswer == correctAnswer) {
                _removeQuestion(); // only remove question if answered correctly,
                // this is not a widget so it cannot be in children
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: SingleChildScrollView(
                    child: TestFormat1State().checkAnswer(
                      selectedAnswer: selectedAnswer,
                      correctAnswer: correctAnswer,
                      explanation: explanation
                    )
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  duration: Duration(minutes: 1),
                )

              );
            } else if (value == 'Next') {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              _goToNext();
            }
          },
        ),
      ),
    );
  }
}