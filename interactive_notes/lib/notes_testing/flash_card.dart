import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:interactive_notes/notes_testing/flash_card_body.dart'; // file
import 'package:interactive_notes/homepage/app_bar.dart'; // file

enum _NavDirection { next, back }

class FlashCard extends StatefulWidget {
  final Map<String, dynamic> note;
  const FlashCard({
    super.key,
    required this.note,
  });

  @override
  State<FlashCard> createState() => _FlashCard();
}

class _FlashCard extends State<FlashCard> {
  int _currentIndex = 0;
  late List<Map<String, dynamic>> _questions;
  _NavDirection _direction = _NavDirection.next;

  @override
  void initState() {
    super.initState();
    _questions = List<Map<String, dynamic>>.from(widget.note['question_list'] ?? []);
    _questions.shuffle();
  }

  void _goToNext() {
    log('current index: $_currentIndex');
    if (_questions.isEmpty || (_currentIndex+1 >= _questions.length)) {
      // Navigator.pop(context);
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
        _direction = _NavDirection.next;
        _currentIndex = _currentIndex + 1; // loops back to start
      });
    }
  }

  void _goBack() {
    if (_currentIndex != 0) {
      setState(() {
        _direction = _NavDirection.back;
        _currentIndex = _currentIndex - 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: MyAppBar(
          title: widget.note['note_name'], 
          onToggleDisplay: null
        ),
        body: const Center(child: Text('No questions in this note.')),
      );
    }

    final question = _questions[_currentIndex];

    return Scaffold(
      appBar: MyAppBar(
        title: ('${widget.note['note_name']}: \t ${_currentIndex+1}/${_questions.length}'),
        onToggleDisplay: null,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              // Bottom card
              Positioned(
                right: 10,
                top: 16,
                child: Container(
                  width: 350,
                  height: 210,
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 2,
                      color: Colors.black
                    )
                  ),
                ),
              ),
              // Middle card
              Positioned(
                right: 5,
                top: 8,
                child: Container(
                  width: 350,
                  height: 205,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 2,
                      color: Colors.black
                    )
                  ),
                ),
              ),
              // Front card -- animates out/in when index changes
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                layoutBuilder: (currentChild, previousChildren) {
                  // currentChild = the new incoming card
                  // previousChildren = the old card(s) still animating out
                  if (_direction == _NavDirection.back) {
                    // Going back: incoming (previous) card should sit on
                    // TOP, since it's the one sliding back into view.
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        ...previousChildren,
                        ?currentChild,
                      ],
                    );
                  }
                  // Going next: outgoing card stays on top while it
                  // animates away, so currentChild paints underneath.
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      ?currentChild,
                      ...previousChildren,
                    ],
                  );
                },
                transitionBuilder: (child, animation) {
                  final isOutgoing = animation.status == AnimationStatus.completed;
                  // log(animation.status.toString());

                  if (_direction == _NavDirection.back) {
                    if (!isOutgoing) {
                      // Incoming card (the previous question) slides back
                      // into place from the top-right.
                      final offsetAnimation = Tween<Offset>(
                        begin: Offset(1.2, -0.7),
                        end: Offset.zero,
                      ).animate(animation);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    } else {
                      // Outgoing card just sits underneath, no animation.
                      return child;
                    }
                  }

                  // Default "next" behavior
                  if (isOutgoing) {
                    // Outgoing card slides away to the top-right
                    final offsetAnimation = Tween<Offset>(
                      begin: Offset(1.2, -0.7),
                      end: Offset.zero,
                    ).animate(animation);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  } else {
                    // Incoming card: no slide, just appears
                    return child;
                  }
                },
                child: FlashCardBody(
                  key: ValueKey(_currentIndex), // triggers the switch animation
                  front: Container(
                    width: 350,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 2,
                        color: Colors.black
                      )
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 50),
                      child: Center(
                        child: Text('Q: ${question['question']}')
                      ),
                    )
                  ),
                  back: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    width: 350,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 2,
                        color: Colors.black
                      )
                    ),
                    child: SingleChildScrollView( 
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Center(
                        child: Column(
                          children: [
                            Text('A: ${question['answer']}'),
                            if (question['explanation'] != '') 
                              Text('\nExplanation: ${question['explanation']}')
                          ]
                        )
                      ),
                    )
                  ),
                  onTapNext: _goToNext,
                  onTapBack: _goBack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}