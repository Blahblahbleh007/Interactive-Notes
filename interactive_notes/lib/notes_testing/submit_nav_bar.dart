// import 'package:flutter/material.dart';

// class SubmitBottomNavBar extends StatefulWidget {
//   final Function(String) onSubmit;
//   const SubmitBottomNavBar({super.key, required this.onSubmit});

//   @override
//   State<SubmitBottomNavBar> createState() => _SubmitBottomNavBarState();
// }


// class _SubmitBottomNavBarState extends State<SubmitBottomNavBar> {
//   String buttonText = 'Submit'; // Set initial value directly here

//   void _handlePress() {
//     widget.onSubmit(buttonText);
//     setState(() {
//       if (buttonText == 'Submit') {
//         buttonText = 'Next'; // Update text after every press
//       }
//       else {
//         buttonText = 'Submit'; // for next question
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 70,
//       color: Theme.of(context).colorScheme.primary,
//       alignment: Alignment.center,
//       child: ElevatedButton(
//         onPressed: _handlePress,
//         child: Text(buttonText, style: const TextStyle(color: Colors.black)),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class SubmitBottomNavBar extends StatefulWidget {
  final Function(String) onSubmit;
  final bool canSubmit; // added: gates the 'Submit' press only

  const SubmitBottomNavBar({
    super.key,
    required this.onSubmit,
    this.canSubmit = true, // default true so existing call sites don't break
  });

  @override
  State<SubmitBottomNavBar> createState() => _SubmitBottomNavBarState();
}

class _SubmitBottomNavBarState extends State<SubmitBottomNavBar> {
  String buttonText = 'Submit'; // Set initial value directly here

  void _handlePress() {
    widget.onSubmit(buttonText);
    setState(() {
      if (buttonText == 'Submit') {
        buttonText = 'Next'; // Update text after every press
      } else {
        buttonText = 'Submit'; // for next question
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Only block the press when the button currently says 'Submit'
    // and nothing has been selected yet. 'Next' should never be blocked.
    final isEnabled = buttonText == 'Next' || widget.canSubmit;

    return Container(
      height: 70,
      color: Theme.of(context).colorScheme.primary,
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: isEnabled ? _handlePress : null, // fixed: null disables the button
        child: Text(buttonText, style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}