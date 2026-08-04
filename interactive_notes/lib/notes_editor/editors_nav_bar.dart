import 'package:flutter/material.dart';
import 'dart:developer';
// import 'package:interactive_notes/data/user_data.dart'; // file
// import 'package:interactive_notes/notes_editor/note_editor.dart';
import 'package:interactive_notes/notes_editor/editors_body.dart';


class EditorsNavBar extends StatefulWidget {
  final GlobalKey<EditorsBodyState> bodyKey;
  // final GlobalKey<NoteEditorState> noteEditorKey;
  final int noteLength;
  final int currentPage;
  // final int? _draftPageNum; // page number that's new and not yet saved, or null
  final Future<bool> Function(bool cancelDraft) onAddPage; 
  final Function(int) newPage;

  const EditorsNavBar({
    super.key,
    required this.bodyKey,
    // required this.noteEditorKey,
    required this.noteLength,
    required this.currentPage,
    required this.newPage,
    required this.onAddPage,
  //   int? draftPageNum,
  // }) : _draftPageNum = draftPageNum;
  });

  @override
  State<EditorsNavBar> createState() => _EditorsNavBarState();
}



class _EditorsNavBarState extends State<EditorsNavBar> {
  // late Future<int> _lengthFuture;

  @override
  void initState() {
    super.initState();
    // _lengthFuture = UserPrefs.noteLength(widget.noteName); // UserPrefs is the class name in user_data.dart
  }

  @override
  Widget build(BuildContext context) {     
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 20
      ),
      color: Theme.of(context).colorScheme.primary,
      alignment: Alignment.center,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.noteLength + 1, // +1 to account for the add button
        itemBuilder: (context, index) {
          if (index == widget.noteLength) {

            // Last item: the "add new page" button
            return Padding(
              padding: const EdgeInsets.only(left: 1),
              child: IconButton(
                // iconSize: 20,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white, // background color of the button
                  shape: CircleBorder(),
                  // fixedSize: const Size(1, 1),
                  padding: const EdgeInsets.all(1)
                ),
                icon: const Icon(Icons.add, color: Colors.black),
                onPressed: () async {
                  log('Add new page tapped');
                  // final bool canProceed = await widget.bodyKey.currentState!.canSwitchPage();
                  await widget.bodyKey.currentState!.canSwitchPage();
                  await widget.onAddPage(false); // reverse page = false
                },
              ),
            );
          }

          final questionNumber = index + 1;
          final isCurrentPage = questionNumber == widget.currentPage; // fixed: compare to actual current page

          
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(right: 12),
            width: isCurrentPage ? 40 : 37,
            height: isCurrentPage ? 50 : 45,
            decoration: BoxDecoration(
              color: isCurrentPage
                  ? const Color.fromARGB(255, 115, 180, 121)
                  : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isCurrentPage ? Colors.green.shade700 : Colors.grey,
                width: isCurrentPage ? 2 : 1,
              ),
              boxShadow: isCurrentPage
                ? [
                    const BoxShadow(
                      color: Colors.green,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ]
                : [],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      '$questionNumber',
                      style: TextStyle(
                        color: isCurrentPage ? Colors.white : Colors.black87,
                        fontWeight:
                            isCurrentPage ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          if (isCurrentPage == false) { // prevent clicking current page again
                            log('Page $questionNumber tapped');
                            // check whether need to save question data
                            final bool canProceed = await widget.bodyKey.currentState!.canSwitchPage();
                            if (!mounted) return;
                            if (canProceed) {
                              final bool canSave = widget.bodyKey.currentState!.canSave();
                              if (canProceed == true && canSave == false) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    actions: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.black, // text/icon color
                                            backgroundColor: Colors.green, // button background
                                          ),
                                          onPressed: () => Navigator.pop(context),
                                          child: Text('Stay on current Page'),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.black, // text/icon color
                                            backgroundColor: Colors.red, // button background
                                          ),
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            await widget.onAddPage(true); // delete existing page
                                          },
                                          child: Text('Delete current page & proceed'),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                widget.newPage(questionNumber);
                              }
                                // await widget.onAddPage(true); // delete existing page
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );

        },
      ),
    );
  
    //   },
    // );
  }
}