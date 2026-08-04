import 'package:flutter/material.dart'; 
import 'dart:developer'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart'; // for kDebugMode
import 'homepage/app_bar.dart'; // file
import 'homepage/bottom_nav_bar.dart'; // file
import 'homepage/body_builder.dart'; // file
import 'data/user_data.dart'; // file
import 'notes_editor/note_editor.dart'; // file
import 'homepage/search_tag.dart'; // file
// --------------------------------------------------------------------------------------------------------------------------------------------
// Main
void main() async {       
  WidgetsFlutterBinding.ensureInitialized(); // must come first

  FlutterError.onError = (details) {
    FlutterError.dumpErrorToConsole(details);
  };  // Log details.stack to find the offending widget
  
  if (kDebugMode) {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.clear(); // wipes everything — debug only, remove/comment out when done testing
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,  // ← Flutter generates the whole scheme from this one colour
          primary:   Colors.green,   // main brand colour
          onPrimary: Colors.black, 
          secondary: Color(0xFF625B71),   // accent colour
          error:     Colors.red,           // error states
          surface:   Colors.white,         // cards, sheets
          // text: Colors.black,
        ),                                
        useMaterial3: true,
      ),
      home: const HomeScreen(),   // ✅ delegate to a child widget
    );
  }
}


// --------------------------------------------------------------------------------------------------------------------------------------------
// Home Screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //// <<<<<<<<<< Constructors & Initialisation >>>>>>>>>> \\\\
  List<Map<String, dynamic>> _notes = [];   // all loaded notes
  bool _isLoading = true;                   // show spinner while loading
  String _notesDisplayLayout = 'Grid';       // Grid/List, can add alphabetical order in future

  @override
  void initState() {
    super.initState();
    _loadNotes();                           // runs once when screen first opens
  }

  Future<void> _loadNotes() async {
    final notes = await UserPrefs.getAllNotes();  
    setState(() {
      _notes = notes;
      _isLoading = false;
    });
  }

  void _toggleDisplayLayout() {
    setState(() {
      if (_notesDisplayLayout == 'Grid') {
        _notesDisplayLayout = 'List';
      }
      else {
        _notesDisplayLayout = 'Grid';
      }
      log('Display Layout changed: to $_notesDisplayLayout');
    });
  }

  //// <<<<<<<<<< Main UI >>>>>>>>>> \\\\
  @override
  Widget build(BuildContext context) {
    _loadNotes();

    final bottomNavBarComponents = <Widget>[
      createNewNote(context),
      searchByTag(context, _notes)
    ];

    return Scaffold(
      appBar: MyAppBar(
        title: 'Interactive Notes',
        onToggleDisplay: _toggleDisplayLayout,
      ),
      body: BodyBuilder1(
        isLoading: _isLoading,
        notesDisplayLayout: _notesDisplayLayout,
        notes: _notes,
      ),
      bottomNavigationBar: MyBottomNavBar(components: bottomNavBarComponents),
    );
  }
}


// --------------------------------------------------------------------------------------------------------------------------------------------
// search questions base on tag

Widget searchByTag(BuildContext context, List<Map<String, dynamic>> notes) {
  return FloatingActionButton(
    heroTag: 'searchTagFab',
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchPage(notes: notes),
        ),
      );
      // log(notes.toString());
    },
    backgroundColor: Colors.white,
    child: Icon(Icons.search, color: Colors.black),
  );
}


// --------------------------------------------------------------------------------------------------------------------------------------------
// Create a new note
Widget createNewNote(BuildContext context) {
  return FloatingActionButton(
    heroTag: 'createNoteFab',
    onPressed: () async {
      await askForNoteName(context);
    },
    backgroundColor: Colors.white,
    child: Icon(
      Icons.add,
      color: Colors.black,
    ),
  );
}

Future<String?> askForNoteName(BuildContext context) async {
  final TextEditingController noteNameController = TextEditingController();
  final result = await showDialog<String>(
    context: context,
    builder: (BuildContext dialogContext) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          final noteName = noteNameController.text.trim();
          final canConfirm = noteName.isNotEmpty;

          void confirm() {
            if (!canConfirm) return; // guard: never proceed with an empty name

            UserPrefs.saveNote(
              noteName,
              {
                'note_name': noteName,
                'question_list': []
              }
            );

            Navigator.pop(dialogContext, noteName);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteEditor(noteName: noteName),
              ),
            );
          }

          return AlertDialog(
            title: const Text('Name this note'),
            content: TextField(
              controller: noteNameController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Enter note name',
                border: const OutlineInputBorder(),
                errorText: noteNameController.text.isNotEmpty && !canConfirm
                    ? 'Name cannot be empty'
                    : null,
              ),
              onChanged: (_) {
                setDialogState(() {});
              },
              onSubmitted: (_) => confirm(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: canConfirm ? confirm : null, // null disables the button when empty
                child: const Text('Confirm'),
              ),
            ],
          );
        },
      );
    },
  );
  return result;
}