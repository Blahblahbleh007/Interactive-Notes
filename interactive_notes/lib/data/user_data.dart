import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'package:interactive_notes/data/default_data.dart'; // file

class UserPrefs {
  
  /* Index of all note names that exist, stored under this fixed key.
  Needed because notes are now stored directly under their own name
  (e.g. 'Basic Math'), so we can't tell note keys apart from other
  prefs keys (like '_indexKey' or 'default_notes_version') just by
  looking at the key itself. */
  static const String _indexKey = '__note_index__';




// --------------------------------------------------------------------------------------------------------------------------------------------
//// <<<<<<<<<< Getters >>>>>>>>>> \\\\

  static Future<Set<String>> _loadIndex(SharedPreferences prefs) async {
    return prefs.getStringList(_indexKey)?.toSet() ?? <String>{};
  }

  // Get every question in a note, in order. Question number = index + 1.
  static Future<List<Map<String, dynamic>>> getQuestions(String noteName) async {
    final data = await _loadNote(noteName);
    return _questionListOf(data);
  }

  // Get a single question by its 0-based index
  static Future<Map<String, dynamic>?> getQuestion(String noteName, int index) async {
    final list = _questionListOf(await _loadNote(noteName));
    if (index < 0 || index >= list.length) return null;
    return list[index];
  }

  // Read the full note
  static Future<Map<String, dynamic>?> getNote(String noteName) async {
    final data = await _loadNote(noteName);
    return data.isEmpty ? null : data;
  }

  // Check if any notes exist
  static Future<bool> hasNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final names = await _loadIndex(prefs);
    return names.isNotEmpty;
  }

  // Helper: safely read question_list out of a note as a typed List.
  static List<Map<String, dynamic>> _questionListOf(Map<String, dynamic> note) {
    final raw = note['question_list'] as List<dynamic>?;
    if (raw == null) return [];
    return raw.map((q) => Map<String, dynamic>.from(q as Map)).toList();
  }

  // Get number of questions in note
  static Future<int> noteLength(String noteName) async {
    final data = await _loadNote(noteName);
    if (data.isEmpty) {log('$noteName is empty'); return 0;}
    return _questionListOf(data).length;
  }



// --------------------------------------------------------------------------------------------------------------------------------------------
//// <<<<<<<<<< Save/Update/Add >>>>>>>>>> \\\\

  static Future<void> _saveIndex(SharedPreferences prefs, Set<String> names) async {
    await prefs.setStringList(_indexKey, names.toList());
  }

  static Future<void> _addToIndex(String noteName) async {
    final prefs = await SharedPreferences.getInstance();
    final names = await _loadIndex(prefs);
    if (names.add(noteName)) {
      await _saveIndex(prefs, names);
    }
  }

  // Load the full note map (or empty if none)
  static Future<Map<String, dynamic>> _loadNote(String noteName) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(noteName);
    if (jsonString == null) return {};
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  // Save the full note map. Stored under its own name, same as the
  // default notes (e.g. key 'Basic Math' -> {'note_name': 'Basic Math', ...}).
  static Future<void> saveNote(String noteName, Map<String, dynamic> data) async {
    log('Saving note $noteName');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(noteName, jsonEncode(data));
    await _addToIndex(noteName);
  }

  // Deep merge: only updates keys you pass in, leaves others untouched.
  // NOTE: question_list is now a List, not a Map, so it is never deep-merged
  // here — if `updates` contains 'question_list' it will fully replace the
  // existing one. For editing individual questions, use addQuestion /
  // updateQuestion / deleteQuestion below instead of updateNote.
  static Map<String, dynamic> _deepMerge(
    Map<String, dynamic> base,
    Map<String, dynamic> updates,
  ) {
    final result = Map<String, dynamic>.from(base);
    updates.forEach((key, value) {
      if (value is Map<String, dynamic> && result[key] is Map<String, dynamic>) {
        result[key] = _deepMerge(result[key], value);
      } else {
        result[key] = value;
      }
    });
    return result;
  }

  // Public update function — only updates what you pass in (note-level fields,
  // e.g. note_name). Do not use this to edit individual questions.
  static Future<void> updateNote(String noteName, Map<String, dynamic> updates) async {
    final existing = await _loadNote(noteName);
    final merged = _deepMerge(existing, updates);
    await saveNote(noteName, merged);
  }

  // // Append a new question to the end of the list
  // static Future<void> addQuestion(String noteName, Map<String, dynamic> question) async {
  //   final data = await _loadNote(noteName);
  //   final list = _questionListOf(data);
  //   list.add(question);
  //   data['question_list'] = list;
  //   await saveNote(noteName, data);
  // }

  // // Shallow-merge `updates` into the question at `index` (e.g. fix a typo,
  // // change the answer). Leaves every other question untouched.
  // static Future<void> updateQuestion(
  //   String noteName,
  //   int index,
  //   Map<String, dynamic> updates,
  // ) async {
  //   final data = await _loadNote(noteName);
  //   final list = _questionListOf(data);
  //   if (index < 0 || index >= list.length) return;
  //   list[index] = {...list[index], ...updates};
  //   data['question_list'] = list;
  //   await saveNote(noteName, data);
  // }
// Add or update a question depending on whether `index` already exists.
  // - If a question exists at `index`, shallow-merges `question` into it
  //   (only the fields you pass get changed, everything else stays the same).
  // - If no question exists at `index` (e.g. index == list.length, or any
  //   out-of-range index), `question` is appended as a brand new entry.
  static Future<void> upsertQuestion(
    String noteName,
    int index,
    Map<String, dynamic> question,
  ) async {
    final data = await _loadNote(noteName);
    final list = _questionListOf(data);

    if (index >= 0 && index < list.length) {
      // Index exists -> update (merge)
      list[index] = {...list[index], ...question};
    } else {
      // Index doesn't exist -> add as new question
      list.add(question);
    }

    data['question_list'] = list;
    await saveNote(noteName, data);
    log('New data: $data');
  }




// --------------------------------------------------------------------------------------------------------------------------------------------
//// <<<<<<<<<< Deletion/ Removal >>>>>>>>>> \\\\


  // Delete the question at `index`. Every question after it automatically
  // shifts down by one — no manual renumbering needed.
  static Future<void> deleteQuestion(String noteName, int index) async {
    final data = await _loadNote(noteName);
    final list = _questionListOf(data);
    if (index < 0 || index >= list.length) return;
    list.removeAt(index);
    data['question_list'] = list;
    await saveNote(noteName, data);
  }

  // Delete a note
  static Future<void> deleteNote(String noteName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(noteName);
    await _removeFromIndex(noteName);
  }

  static Future<void> _removeFromIndex(String noteName) async {
    final prefs = await SharedPreferences.getInstance();
    final names = await _loadIndex(prefs);
    if (names.remove(noteName)) {
      await _saveIndex(prefs, names);
    }
  }

  // Renames a note: copies its data to `newNoteName` and removes `oldNoteName`.
  // Returns false (no-op) if newNoteName already exists and isn't the same note.
  static Future<bool> rename(String newNoteName, String oldNoteName,) async {
    if (oldNoteName == newNoteName) return true; // nothing to do

    final prefs = await SharedPreferences.getInstance();

    // Guard against overwriting an unrelated existing note.
    if (prefs.containsKey(newNoteName)) {
      return false;
    }

    final data = await _loadNote(oldNoteName);
    if (data.isEmpty) return false; // old note doesn't exist

    data['note_name'] = newNoteName; // keep the field consistent with the key

    await saveNote(newNoteName, data);
    await deleteNote(oldNoteName);
    log('note renamed');
    return true;
  }




// --------------------------------------------------------------------------------------------------------------------------------------------
//// <<<<<<<<<< Get default notes and all of user's notes >>>>>>>>>> \\\\
  static const int _defaultNotesVersion = 1; // bumped: question_list is now a List

  static Future<List<Map<String, dynamic>>> getAllNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final names = await _loadIndex(prefs);
    final savedVersion = prefs.getInt('default_notes_version') ?? 0;

    // Re-seed if no notes exist OR if defaults have been updated
    if (names.isEmpty || savedVersion < _defaultNotesVersion) {
      Map<String, dynamic> defaultNotes = defaultData();
      for (final entry in defaultNotes.entries) {
        await updateNote(entry.key, entry.value);
      }

      // Save the version so this won't re-seed until you bump the number again
      await prefs.setInt('default_notes_version', _defaultNotesVersion);

      // return defaultNotes.values.toList();
      return defaultNotes.values
        .map((v) => v as Map<String, dynamic>)
        .toList();
        }

    // Notes exist and are up to date — load and return them
    final notes = <Map<String, dynamic>>[];
    for (final name in names) {
      final jsonString = prefs.getString(name);
      if (jsonString != null) {
        notes.add(jsonDecode(jsonString) as Map<String, dynamic>);
      }
    }
    return notes;
  }

  
}