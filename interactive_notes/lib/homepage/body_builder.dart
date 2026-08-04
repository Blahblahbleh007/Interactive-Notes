// This body is for the home screen, it shows a list of notes 
// you can select to start testing or edit
import 'package:flutter/material.dart';
import 'package:interactive_notes/notes_testing/flash_card.dart';
import 'package:interactive_notes/notes_testing/testing.dart'; // file
import 'package:interactive_notes/notes_editor/note_editor.dart'; // file
import 'package:interactive_notes/data/user_data.dart';
import 'dart:developer';

class BodyBuilder1 extends StatelessWidget {
  final bool isLoading;
  final String notesDisplayLayout;  // grid or list
  final List<Map<String, dynamic>> notes; // list of notes

  const BodyBuilder1({
    super.key, 
    required this.isLoading, 
    required this.notesDisplayLayout, 
    required this.notes 
  });




  Widget dropDownList({
    required BuildContext context,
    required Map<String, dynamic> note,
  }) {
    return PopupMenuButton<String> (
      icon: const Icon(Icons.more_vert, size: 20),
      padding: EdgeInsets.zero,
      onSelected: (String value) async {
        log('Selected: $value');
        switch (value) {
          case 'Edit':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteEditor(noteName: note['note_name']),
              ),
            );
            break;
          case 'Delete':
            // UserPrefs.deleteNote(note['note_name']);
            showDialog(
              context: context, 
              builder: (dialogContext) => AlertDialog(
                title: Text('Confirm delete!'),
                // content: Text(''),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black, // text/icon color
                      backgroundColor: Colors.grey, // button background
                    ),
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black, // text/icon color
                      backgroundColor: Colors.red, // button background
                    ),
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      UserPrefs.deleteNote(note['note_name']);
                    },
                    child: Text('Delete'),
                  ),
                ]
              )
            );
            break;
          case 'Rename':
            final newName = await showRenameDialog(context, initialValue: note['note_name']);
            if (newName != null) {
              final success = await UserPrefs.rename(newName, note['note_name']);
              if (!success) {
                // e.g. name already taken — show a SnackBar or similar
                await showDialog(
                  context: context, 
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'Name already exists',
                        style: TextStyle(color:Colors.red),
                      )
                    );
                  }
                );
              }
            }
            break;
          case 'Flash Card':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FlashCard(note: note),
              ),
            );
            break;
        }
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: 'Edit', 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Edit'), Icon(Icons.edit)])
        ),
        const PopupMenuItem(
          value: 'Delete', 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Delete'), Icon(Icons.delete)])
        ), 
        const PopupMenuItem(
          value: 'Rename', 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Rename'), Icon(Icons.textsms_outlined)])
        ),        
        const PopupMenuItem(value: 'Flash Card', child: Text('Flash Card')),
      ],
    );
  }







  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (notes.isEmpty) {
      return const Center(child: Text('No notes yet. Tap + to create one.'));
    }

    void startTest(note) {
      // print(note);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestingPage(note: note),
        ),
      );
    }

    if (notesDisplayLayout == 'Grid') {
      return GridView.builder(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.7,
        ),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      startTest(note);
                    }, // navigation goes here later
                    child: Stack(
                      children: [
                        const Center(
                          child: Icon(Icons.note_alt, size: 50, color: Colors.green),
                        ),
                        Positioned(
                          top: 2,
                          right: 0,
                          child: dropDownList(context: context, note: note),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                note['note_name'] ?? 'Unnamed',
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      );
    }


    else {
      return ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            title: Text(note['note_name'] ?? 'Unnamed'),
            onTap: () {
              startTest(note);
            }, // navigation goes here later
            trailing: SizedBox(
              width: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dropDownList(context: context, note: note),
                ],
              ),
            ),
          );
        },
      );
    }
  }
} 




Future<String?> showRenameDialog(BuildContext context, {String initialValue = ''}) {
  final controller = TextEditingController(text: initialValue);

  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Rename'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Enter new name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // returns null
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newName = controller.text.trim();
              if (newName.isEmpty) return; // ignore empty input
              Navigator.pop(context, newName);
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  );
}