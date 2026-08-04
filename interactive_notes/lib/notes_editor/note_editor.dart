import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:interactive_notes/homepage/app_bar.dart'; // file
import 'package:interactive_notes/notes_editor/editors_nav_bar.dart'; // file
import 'package:interactive_notes/notes_editor/editors_body.dart'; // file
import 'package:interactive_notes/data/user_data.dart'; // file

class NoteEditor extends StatefulWidget {
  final String noteName;
  const NoteEditor({super.key, required this.noteName});
  
  @override
  State<NoteEditor> createState() => NoteEditorState();
}

class NoteEditorState extends State<NoteEditor> {
  final GlobalKey<EditorsBodyState> editorBodyKey = GlobalKey<EditorsBodyState>();
  final GlobalKey<NoteEditorState> noteEditorKey = GlobalKey<NoteEditorState>();
  int currentPage = 1;
  int? noteLength; // nullable — null until the fetch completes

  // int? draftPageNum; // page number that's new and not yet saved, or null
  final ValueNotifier<int?> draftPageNotifier = ValueNotifier<int?>(null);

  
  @override
  void initState() {
    super.initState();
    _loadNoteLength(null);
  }

  @override
  void dispose() {
    draftPageNotifier.dispose();
    super.dispose();
  }

  Future<void> _loadNoteLength(int? additional) async {
    final length = await UserPrefs.noteLength(widget.noteName);
    // log('Number of questions in ${widget.noteName} is $length');
    setState(() {
      if (additional != null) {
        noteLength = length + additional;
      } else {
        noteLength = length == 0 ? 1 : length;
      }
    });
  }

//// <<<<<<<<<< Drafting/ New Page/question >>>>>>>>>> \\\\

  // Update draft state WITHOUT rebuilding the Scaffold
  Future<bool> setDraftPage(int? page) async {
    log('DraftPage set to $page');
    draftPageNotifier.value = page; // only notifies listeners, no setState
    return true; // complete
  }

  // Explicit, manual full rebuild — call this when you actually need it
  Future<bool> refreshScaffold() async {
    setState(() {});
    return true; // complete
  }


  // Add a new page/ question
  Future<bool> addPage(bool cancelDraft) async {
    if (cancelDraft == false) { // add page
      await _loadNoteLength(1); // this already does setState internally, await will cancel rebuild
    } else { // delete page
      await _loadNoteLength(null);
    }
    log('Request to add new page received, noteLength = $noteLength');
    if (noteLength != null) {
      setState(() {
        currentPage = noteLength!;
      });
    }
    return true;
  }










//// <<<<<<<<<< Main >>>>>>>>>> \\\\
  @override
  Widget build(BuildContext context) {
    if (noteLength == null) {
      return Scaffold(
        appBar: MyAppBar(title: widget.noteName),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: MyAppBar(title: widget.noteName),
      body: EditorsBody(
        key: editorBodyKey,
        noteName:widget.noteName, 
        pageNum: currentPage,
      ),
      bottomNavigationBar: EditorsNavBar(
        bodyKey: editorBodyKey,
        // noteEditorKey: noteEditorKey,
        noteLength: noteLength!,
        currentPage: currentPage,
        newPage: (value) {
          setState(() {
            currentPage = value;
            log('Request to change page to $value received');
          });
        },
        onAddPage: addPage,
        // draftPageNum: draftPageNotifier.value
      ),
    );
  }
}