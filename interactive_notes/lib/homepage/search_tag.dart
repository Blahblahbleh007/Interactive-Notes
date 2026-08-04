import 'package:flutter/material.dart';
// import 'dart:developer';
import 'package:interactive_notes/notes_editor/editors_body.dart'; // file
import 'package:interactive_notes/homepage/app_bar.dart'; // file

/// Maps a lowercased tag -> list of (noteName, questionIndex) pairs.
/// Build this once after loading/updating data, not on every search.
Map<String, List<MapEntry<String, int>>> buildTagIndex(List<Map<String, dynamic>> notes) {
  final Map<String, List<MapEntry<String, int>>> index = {};

  for (final noteEntry in notes) {
    final noteName = noteEntry['note_name'];
    final questionList = noteEntry['question_list'] as List;

    for (int i = 0; i < questionList.length; i++) {
      final tags = (questionList[i]['tags'] as List).cast<String>();

      for (final tag in tags) {
        final key = tag.toLowerCase();
        index.putIfAbsent(key, () => []).add(MapEntry(noteName, i));
      }
    }
    // log(noteEntry.toString());
  }

  return index;
}



/// Returns full question details for every question matching ANY of [searchTags].
/// matchAll: true  -> question must contain ALL searchTags
/// matchAll: false -> question must contain AT LEAST ONE searchTag
List<Map<String, dynamic>> searchQuestionsByTags({
  required List<Map<String, dynamic>> notes,
  required Map<String, List<MapEntry<String, int>>> tagIndex,
  required List<String> searchTags,
  bool matchAll = false,
}) {
  if (searchTags.isEmpty) return [];

  final normalizedTags = searchTags.map((t) => t.toLowerCase()).toList();

  final Map<String, int> matchCount = {}; // key: "noteName|index"
  final Map<String, MapEntry<String, int>> refLookup = {};

  for (final tag in normalizedTags) {
    final refs = tagIndex[tag];
    if (refs == null) continue;

    for (final ref in refs) {
      final key = '${ref.key}|${ref.value}';
      matchCount[key] = (matchCount[key] ?? 0) + 1;
      refLookup[key] = ref;
    }
  }

  // Build a name -> note lookup once, instead of scanning the list per result.
  final Map<String, Map<String, dynamic>> notesByName = {
    for (final n in notes) n['note_name'] as String: n,
  };

  final results = <Map<String, dynamic>>[];

  matchCount.forEach((key, count) {
    final isMatch = matchAll ? count == normalizedTags.length : count > 0;
    if (!isMatch) return;

    final ref = refLookup[key]!;
    final noteName = ref.key;     // fixed: was ref['note_name']
    final questionIndex = ref.value;

    final note = notesByName[noteName];
    if (note == null) return; // note no longer exists, skip stale index entry

    final questionList = note['question_list'] as List;
    if (questionIndex < 0 || questionIndex >= questionList.length) return;

    final question = questionList[questionIndex] as Map<String, dynamic>;

    results.add({
      'note_name': noteName,
      'question': question['question'],
      'answer': question['answer'],
      'explanation': question['explanation'],
      'tags': question['tags'],
      'wrong_ans': question['wrong_ans'],
    });
  });

  return results;
}

//-------------------------------------------------

// for (final m in matches) {
//   print('${m['note_name']}: ${m['question']} -> ${m['answer']}');
// }
class SearchPage extends StatefulWidget {
  final List<Map<String, dynamic>> notes; // fixed: matches buildTagIndex's expected type

  const SearchPage({super.key, required this.notes});

  @override
  State<SearchPage> createState() => _SearchPageState(); // fixed: convention is "...State"
}



class _SearchPageState extends State<SearchPage> {
  late final Map<String, List<MapEntry<String, int>>> tagIndex;
  final controller = TextEditingController();
  List<Map<String, dynamic>> _results = [];

  @override
  void initState() {
    super.initState();
    tagIndex = buildTagIndex(widget.notes);
    // log(tagIndex.toString()); //e.g. log: {addition: [MapEntry(Basic Math: 0), MapEntry(Advanced Math: 2)], differentiation: [MapEntry(Advanced Math: 0)], multiplication: [MapEntry(Advanced Math: 1)], division: [MapEntry(Advanced Math: 2)]}
  }

  @override
  void dispose() {
    controller.dispose(); // fixed: was never disposed, leaks resources
    super.dispose();
  }

  void _runSearch(String input) {
    final searchTags = parseTags(input); // reuse your existing tag-parsing logic

    setState(() {
      _results = searchTags.isEmpty
          ? []
          : searchQuestionsByTags(
              notes: widget.notes,
              tagIndex: tagIndex,
              searchTags: searchTags,
              matchAll: false, // OR-match; flip to true if you want AND-match
            );
    });
  }

  List<String> parseTags(String input) {
    return input
      .trim()
      .split(RegExp(r'\s+'))
      .where((t) => RegExp(r'^#[a-z0-9_]+$').hasMatch(t))
      .map((t) => t.substring(1))
      .toList();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: 'Search by tag',
          onToggleDisplay: null,
        ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              inputFormatters: [TagInputFormatter()], // reuse your existing formatter
              decoration: InputDecoration(
                hintText: '#math #addition',
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              onChanged: _runSearch, // fixed: search now actually runs as user types
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _results.isEmpty
                  ? const Center(child: Text('No matches yet'))
                  : ListView.builder(
                      itemCount: _results.length,
                      itemBuilder: (context, index) => _ResultCard(result: _results[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}





// --------------------------------------------------------------------------------------------------------------------------------------------


// class _ResultCard extends StatefulWidget {
//   final Map<String, dynamic> result;

//   const _ResultCard({required this.result});

//   @override
//   State<_ResultCard> createState() => _ResultCardState();
// }

// class _ResultCardState extends State<_ResultCard> {
//   bool _expanded = false;

//   @override
//   Widget build(BuildContext context) {
//     final r = widget.result;
//     final explanation = (r['explanation'] ?? '') as String;

//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(r['question'] ?? '', style: Theme.of(context).textTheme.titleMedium),
//             const SizedBox(height: 4),
//             Text('Note: ${r['note_name']}\nAnswer: ${r['answer']}'),
//             if (explanation.isNotEmpty) ...[
//               const SizedBox(height: 8),
//               AnimatedCrossFade(
//                 duration: const Duration(milliseconds: 200),
//                 crossFadeState:
//                     _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
//                 firstChild: Text(
//                   explanation,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 secondChild: Text(explanation),
//               ),
//               GestureDetector(
//                 onTap: () => setState(() => _expanded = !_expanded),
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 4),
//                   child: Text(
//                     _expanded ? 'Show less' : 'Read more',
//                     style: TextStyle(
//                       color: Theme.of(context).colorScheme.primary,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
class _ResultCard extends StatefulWidget {
  final Map<String, dynamic> result;

  const _ResultCard({required this.result});

  @override
  State<_ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<_ResultCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final r = widget.result;
    final explanation = (r['explanation'] ?? '') as String;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(r['question'] ?? '', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text('Note: ${r['note_name']}\nAnswer: ${r['answer']}'),
            if (explanation.isNotEmpty) ...[
              const SizedBox(height: 8),
              if (_expanded) Text('Details: $explanation'), // fixed: only renders when expanded
              GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _expanded ? 'Show less' : 'Read more',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}