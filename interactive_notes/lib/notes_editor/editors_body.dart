import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:interactive_notes/data/user_data.dart'; // file

class EditorsBody extends StatefulWidget {
  final String noteName;
  final int pageNum;

  const EditorsBody({
    super.key,
    required this.noteName,
    required this.pageNum,
  });

  @override
  State<EditorsBody> createState() => EditorsBodyState();
}




// Renamed from `_EditorsBody` to `EditorsBodyState` (no leading underscore)
// so it's public and callable from other files via a GlobalKey.
class EditorsBodyState extends State<EditorsBody> {
  final ExpansibleController controller1 = ExpansibleController(); // Phase 1
  final ExpansibleController controller2 = ExpansibleController(); // Phase 2
  final ExpansibleController controller3 = ExpansibleController(); // Phase 3
  final Map<String, TextEditingController> controllerList = {
    'questionController': TextEditingController(),
    'answerController': TextEditingController(),
    'explanationController': TextEditingController(),
    'tagController': TextEditingController(),
    'wrongAnswerController1': TextEditingController(),
    'wrongAnswerController2': TextEditingController(),
    'wrongAnswerController3': TextEditingController(),
  };
  bool newChanges = false;
  bool _isLoadingData = false; // guard flag: true while we programmatically set/clear text
  final Map<String, String> _lastTextValues = {}; // help to prevent newChanges from activating when textField is simply clicked

  @override
  void initState() {
    super.initState();

    // Attach listeners ONCE here. Doing this inside _loadQuestionDetails()
    // caused listeners to be re-added every time data was (re)loaded,
    // stacking duplicates and letting programmatic text assignment
    // incorrectly flip newChanges to true.
    for (var entry in controllerList.entries) {
      _lastTextValues[entry.key] = entry.value.text; // seed with initial (empty) text

      entry.value.addListener(() {
        if (_isLoadingData) return;

        final currentText = entry.value.text;
        if (currentText == _lastTextValues[entry.key]) {
          // Only the selection/cursor moved — text is unchanged, ignore it.
          return;
        }
        _lastTextValues[entry.key] = currentText;

        if (!newChanges) {
          setState(() {
            log('Question edited --> newChanges = true');
            newChanges = true;
          });
        }
      });
    }
    controller1.expand();
    _loadQuestionDetails();
  }

  Future<void> _loadQuestionDetails() async {
    _isLoadingData = true; // suppress listener side-effects while filling fields

    final Map<String, dynamic>? questionDetails = await UserPrefs.getQuestion(
      widget.noteName,
      widget.pageNum - 1,
    );

    // If there's no saved data at all, leave every controller empty
    // so each TextField falls back to showing its hintText.
    if (questionDetails == null) {
      _isLoadingData = false;
      return;
    }

    setState(() {
      if (questionDetails['question'] != null &&
          (questionDetails['question'] as String).isNotEmpty) {
        controllerList['questionController']!.text = questionDetails['question'];
        _lastTextValues['questionController'] = questionDetails['question'];
      }
      if (questionDetails['answer'] != null &&
          (questionDetails['answer'] as String).isNotEmpty) {
        controllerList['answerController']!.text = questionDetails['answer'];
        _lastTextValues['answerController'] = questionDetails['answer'];
      }
      if (questionDetails['explanation'] != null &&
          (questionDetails['explanation'] as String).isNotEmpty) {
        controllerList['explanationController']!.text = questionDetails['explanation'];
        _lastTextValues['explanationController'] = questionDetails['explanation'];
      }
      if (questionDetails['tags'] != null && (questionDetails['tags'] as List).isNotEmpty) {
        final tags = (questionDetails['tags'] as List).cast<String>();
        final tagsText = tags.map((t) => '#$t').join(' ');
        controllerList['tagController']!.text = tagsText;
        _lastTextValues['tagController'] = tagsText;
      }
      if (questionDetails['wrong_ans'] != null &&
          (questionDetails['wrong_ans'] as List).isNotEmpty) {
          // (questionDetails['wrongAnswer'] as String).isNotEmpty) {
        controllerList['wrongAnswerController1']!.text = questionDetails['wrong_ans'][0];
        _lastTextValues['wrongAnswerController1'] = questionDetails['wrong_ans'][0];
        controllerList['wrongAnswerController2']!.text = questionDetails['wrong_ans'][1];
        _lastTextValues['wrongAnswerController2'] = questionDetails['wrong_ans'][1];
        controllerList['wrongAnswerController3']!.text = questionDetails['wrong_ans'][2];
        _lastTextValues['wrongAnswerController3'] = questionDetails['wrong_ans'][2];
      }
    });

    _isLoadingData = false; // re-enable change tracking now that load is complete
  }

  @override
  void dispose() {
    for (var controller in controllerList.entries) {
      controller.value.dispose();
    }
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(EditorsBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pageNum != widget.pageNum || oldWidget.noteName != widget.noteName) {
      _isLoadingData = true; // suppress while clearing too, clearing counts as a change
      for (var controller in controllerList.entries) {
        controller.value.clear();
      }
      setState(() {
        newChanges = false;
      });
      controller1.expand();
      controller2.collapse();
      controller3.collapse();
      _loadQuestionDetails();
    }
  }





//// <<<<<<<<<< Widgets/ Functions >>>>>>>>>> \\\\
  Widget _textBox(String text, TextEditingController textController, String defaultText) {
    bool isTag = text == 'Tags';
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: textController,
            autofocus: true,
            inputFormatters: isTag ? [TagInputFormatter()] : null,
            decoration: InputDecoration(
              hintText: defaultText,
              hintStyle: TextStyle(color: Colors.grey[500]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }



  // Returns true only if mandatory fields (question and answers) are filled
  bool canSave() {
    if (controllerList['questionController']!.text.isEmpty ||
        controllerList['answerController']!.text.isEmpty || 
        controllerList['wrongAnswerController1']!.text.isEmpty ||
        controllerList['wrongAnswerController2']!.text.isEmpty ||
        controllerList['wrongAnswerController3']!.text.isEmpty 
      ) {
      return false;
    }
    return true;
  }

  bool saveData() {
    if (canSave() == true) {
      setState(() {
        newChanges = false;
      });
      Map<String, dynamic> questionData = {
        'question': controllerList['questionController']!.text,
        'answer': controllerList['answerController']!.text,
        'explanation': controllerList['answerController']!.text.isEmpty
            ? ''
            : controllerList['explanationController']!.text,
        'tags': controllerList['tagController']!.text.isEmpty 
            ? [] 
            : parseTags(controllerList['tagController']!.text), 
        'wrong_ans': [
          controllerList['wrongAnswerController1']!.text,
          controllerList['wrongAnswerController2']!.text,
          controllerList['wrongAnswerController3']!.text,
        ],
      };
      UserPrefs.upsertQuestion(widget.noteName, widget.pageNum - 1, questionData); // save to user_data.dart
      
      return true;
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Unable to save'),
          content: Text('Question or answer field is empty.'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // text/icon color
                backgroundColor: Colors.grey[400], // button background
              ),
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        ),
      );
      return false;
    }
  }

  // Used when trying to switch page, see if need to save.
  // Public (no leading underscore) and async — must be awaited by the
  // caller, since the dialog only resolves once the user responds.
  Future<bool> canSwitchPage() async {
    if (newChanges == false) {
      // no new changes
      if (canSave() == true) { // double check fields are not empty
        return true;
      }
    }

    // Ask the user whether to save before switching.
    final bool? shouldSave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Changes detected'),
        content: Text('Would you like to save changes?'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black, // text/icon color
              backgroundColor: Colors.grey[400], // button background
            ),
            onPressed: () => Navigator.pop(context, false),
            child: Text('No'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black, // text/icon color
              backgroundColor: Colors.grey[400], // button background
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text('Yes'),
          ),
        ],
      ),
    );

    if (shouldSave == true) {
      // "Yes" was tapped: try to save, only allow switching if it succeeded.
      return saveData();
    }

    if (shouldSave == false) {
      // "No" was tapped: discard changes, allow the switch.
      return true;
    }

    // Dialog dismissed without an explicit choice (e.g. tapped outside).
    // Treat this as "don't switch yet" to avoid silently losing data.
    return false;
  }


  List<String> parseTags(String input) {
  return input
    .trim()
    .split(RegExp(r'\s+'))
    .where((t) => RegExp(r'^#[a-z0-9_]+$').hasMatch(t))
    .map((t) => t.substring(1))
    .toList();
  }



//// <<<<<<<<<< Main >>>>>>>>>> \\\\
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 25,
            child: newChanges == false ? Text('') : Text('unsaved'),
          ),

          // A controller has been provided to the ExpansionTile because it's
          // going to be accessed from a component that is not within the
          // tile's BuildContext.
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ExpansionTile(
              controller: controller1,
              title: const Text('Phase 1: Enter a question and the answer'),
              backgroundColor: const Color.fromARGB(255, 201, 200, 200),
              collapsedBackgroundColor: Colors.grey,
              children: <Widget>[
                _textBox('Question', controllerList['questionController']!, 'e.g. What is 2+2 ?'),
                _textBox('Answer', controllerList['answerController']!, 'e.g. 4')
              ],
            ),
          ),

          const SizedBox(height: 30),
          // A controller has not been provided to the ExpansionTile because
          // the automatically created one can be retrieved via the tile's BuildContext.

          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ExpansionTile(
              controller: controller2,
              title: const Text('Phase 2: Enter additional explanation and keywords'),
              backgroundColor: const Color.fromARGB(255, 201, 200, 200),
              collapsedBackgroundColor: Colors.grey,
              children: <Widget>[
                _textBox('Explanation/ Additional Details',
                    controllerList['explanationController']!, 'e.g. This is a simple addition equation'),
                _textBox('Tags', controllerList['tagController']!, 'e.g. #math #addition #grade1'),
              ],
            ),
          ),

          const SizedBox(height: 30),

          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ExpansionTile(
              controller: controller3,
              title: const Text('Phase 3: Enter some wrong answers'),
              backgroundColor: const Color.fromARGB(255, 201, 200, 200),
              collapsedBackgroundColor: Colors.grey,
              children: <Widget>[
                _textBox('Wrong Answer 1: ', controllerList['wrongAnswerController1']!, 'e.g. 2 + 2 = 5'),
                _textBox('Wrong Answer 2: ', controllerList['wrongAnswerController2']!, 'e.g. 2 + 2 = 6'),
                _textBox('Wrong Answer 3: ', controllerList['wrongAnswerController3']!, 'e.g. 2 + 2 = 7'),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0), // Adds spacing on all outer sides
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                // backgroundColor: const Color.fromARGB(255, 19, 218, 25),
                backgroundColor: newChanges == true ? Color.fromARGB(255, 19, 218, 25) : const Color.fromARGB(255, 196, 195, 195),
              ),
              onPressed: () {
                saveData();
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class TagInputFormatter extends TextInputFormatter {
  // Matches: zero or more complete "#word " groups,
  // optionally followed by one in-progress "#partialword" (or just "#", or nothing).
  static final RegExp _validPattern =
      RegExp(r'^(#[a-z0-9_]+ )*(#[a-z0-9_]*)?$');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final lowered = newValue.text.toLowerCase();

    if (_validPattern.hasMatch(lowered)) {
      return newValue.copyWith(text: lowered);
    }

    // Reject the keystroke entirely — snap back to last valid state.
    return oldValue;
  }
}