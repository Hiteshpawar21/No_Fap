// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

// class ViewEditNotePage extends StatefulWidget {
//   final String noteId;

//   ViewEditNotePage({required this.noteId});

//   @override
//   _ViewEditNotePageState createState() => _ViewEditNotePageState();
// }

// class _ViewEditNotePageState extends State<ViewEditNotePage> {
//   final _titleController = TextEditingController();
//   final _contentController = TextEditingController();
//   late DocumentReference noteRef;

//   @override
//   void initState() {
//     super.initState();
//     noteRef = FirebaseFirestore.instance.collection('notes').doc(widget.noteId);
//     _loadNote();
//   }

//   Future<void> _loadNote() async {
//     final doc = await noteRef.get();
//     if (doc.exists) {
//       final data = doc.data() as Map<String, dynamic>;
//       _titleController.text = data['title'] ?? '';
//       _contentController.text = data['content'] ?? '';
//     }
//   }

//   Future<void> _saveNote() async {
//     await noteRef.update({
//       'title': _titleController.text.trim(),
//       'content': _contentController.text.trim(),
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: const Color(0xffee4176),
//           toolbarHeight: 70,
//           leading: IconButton(
//             icon: const Icon(TablerIcons.caret_left_filled),
//             color: const Color(0xfffef4f5),
//             iconSize: 24,
//             onPressed: () {
//               // Go back logic
//               Navigator.pop(context);
//             },
//           ),
//           actions: [
//             TextButton(
//                 onPressed: _saveNote,
//                 style: TextButton.styleFrom(
//                     foregroundColor: const Color(0xfffef4f5),
//                     textStyle: const TextStyle(
//                         fontSize: 16,
//                         fontFamily: "Open_Sans",
//                         fontWeight: FontWeight.w500),
//                     padding: const EdgeInsets.only(right: 25)),
//                 child: const Text("SAVE"))
//           ] // Text color),)],
//           ),
//       body: Padding(
//         padding: EdgeInsets.all(25.0),
//         child: Column(
//           children: [
//             TextField(
//               style: const TextStyle(
//                   fontSize: 20,
//                   color: Color(0xff6c7bcc),
//                   fontFamily: "Open_sans",
//                   fontWeight: FontWeight.w500),
//               controller: _titleController,
//               decoration: const InputDecoration(
//                 border: InputBorder.none, // Remove the underline
//                 focusedBorder:
//                     InputBorder.none, // Remove the underline when focused
//                 enabledBorder:
//                     InputBorder.none, // Remove the underline when enabled
//               ),
//             ),
//             Expanded(
//               child: TextField(
//                 style: const TextStyle(
//                     fontSize: 14,
//                     color: Color(0xff6c7bcc),
//                     fontFamily: "Open_sans",
//                     fontWeight: FontWeight.w500),
//                 controller: _contentController,
//                 decoration: const InputDecoration(
//                   border: InputBorder.none, // Remove the underline
//                   focusedBorder:
//                       InputBorder.none, // Remove the underline when focused
//                   enabledBorder:
//                       InputBorder.none, // Remove the underline when enabled
//                 ),
//                 maxLines: null,
//                 expands: true,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class ViewEditNotePage extends StatefulWidget {
  final int noteIndex;
  final Map<String, dynamic> note;

  ViewEditNotePage({required this.noteIndex, required this.note});

  @override
  _ViewEditNotePageState createState() => _ViewEditNotePageState();
}

class _ViewEditNotePageState extends State<ViewEditNotePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note['title'] ?? '';
    _contentController.text = widget.note['content'] ?? '';
  }

  Future<void> _saveNote() async {
    final prefs = await SharedPreferences.getInstance();
    final String? notesString = prefs.getString('notes');

    if (notesString == null) return;

    List<dynamic> notes = jsonDecode(notesString);
    if (widget.noteIndex < 0 || widget.noteIndex >= notes.length) return;

    notes[widget.noteIndex] = {
      'title': _titleController.text.trim(),
      'content': _contentController.text.trim(),
      'timestamp': DateTime.now().toIso8601String(),
    };

    await prefs.setString('notes', jsonEncode(notes));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffee4176),
        toolbarHeight: 70,
        leading: IconButton(
          icon: const Icon(TablerIcons.caret_left_filled),
          color: const Color(0xfffef4f5),
          iconSize: 24,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _saveNote,
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xfffef4f5),
              textStyle: const TextStyle(
                  fontSize: 16,
                  fontFamily: "Open_Sans",
                  fontWeight: FontWeight.w500),
              padding: const EdgeInsets.only(right: 25),
            ),
            child: const Text("SAVE"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xff6c7bcc),
                  fontFamily: "Open_sans",
                  fontWeight: FontWeight.w500),
              controller: _titleController,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
            Expanded(
              child: TextField(
                style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff6c7bcc),
                    fontFamily: "Open_sans",
                    fontWeight: FontWeight.w500),
                controller: _contentController,
                decoration: const InputDecoration(border: InputBorder.none),
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
