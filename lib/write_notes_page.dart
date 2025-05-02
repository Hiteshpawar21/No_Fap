// import 'package:flutter/material.dart';
// import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class WriteNotePage extends StatelessWidget {
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController contentController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: const Color(0xffee4176),
//         elevation: 0,
//         toolbarHeight: 70,
//         leading: IconButton(
//           icon: const Icon(TablerIcons.caret_left_filled),
//           color: const Color(0xfffef4f5),
//           iconSize: 24,
//           onPressed: () {
//             // Go back logic
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text(
//           'WRITE NOTES',
//           style: TextStyle(
//               fontWeight: FontWeight.w700,
//               color: Color(0xfffef4f5),
//               fontSize: 24,
//               fontFamily: 'Open_Sans'),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(30),
//         child: Column(
//           children: [
//             TextField(
//               controller: titleController,
//               decoration: const InputDecoration(
//                 labelText: 'Title',
//                 labelStyle: TextStyle(
//                   color: Color(0xffaac0f9),
//                   fontSize: 12,
//                   fontFamily: 'Open_Sans',
//                   fontWeight: FontWeight.w600,
//                 ),
//                 border: InputBorder.none, // Remove the underline
//                 focusedBorder:
//                     InputBorder.none, // Remove the underline when focused
//                 enabledBorder:
//                     InputBorder.none, // Remove the underline when enabled
//               ),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: TextField(
//                 controller: contentController,
//                 maxLines: null,
//                 expands: true,
//                 textAlignVertical: TextAlignVertical.top,
//                 decoration: const InputDecoration(
//                   labelText: 'Content',
//                   labelStyle: TextStyle(
//                     color: Color(0xffaac0f9),
//                     fontSize: 12,
//                     fontFamily: 'Open_Sans',
//                     fontWeight: FontWeight.w600,
//                   ),
//                   alignLabelWithHint: true,
//                   border: InputBorder.none, // Remove the underline
//                   focusedBorder:
//                       InputBorder.none, // Remove the underline when focused
//                   enabledBorder:
//                       InputBorder.none, // Remove the underline when enabled
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Container(
//         height: 50,
//         color: const Color(0xffee4176),
//         child: TextButton(
//           // onPressed: () {
//           //   // Save logic
//           //   final title = titleController.text;
//           //   final content = contentController.text;
//           //   print('Saved Note:\nTitle: $title\nContent: $content');
//           // },
//           onPressed: () async {
//             final title = titleController.text.trim();
//             final content = contentController.text.trim();

//             if (title.isEmpty && content.isEmpty) return;

//             await FirebaseFirestore.instance.collection('notes').add({
//               'title': title,
//               'content': content,
//               'timestamp': FieldValue.serverTimestamp(),
//             });

//             Navigator.pop(context);
//           },
//           child: const Text(
//             'SAVE',
//             style: TextStyle(
//               color: Color(0xfffef4f5),
//               fontSize: 12,
//               fontFamily: 'Open_Sans',
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class WriteNotePage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  Future<void> _saveNote(BuildContext context) async {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isEmpty && content.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    final String? existingNotes = prefs.getString('notes');
    List<dynamic> notes = existingNotes != null ? jsonDecode(existingNotes) : [];

    notes.insert(0, {
      'title': title,
      'content': content,
      'timestamp': DateTime.now().toIso8601String(),
    });

    await prefs.setString('notes', jsonEncode(notes));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xffee4176),
        elevation: 0,
        toolbarHeight: 70,
        leading: IconButton(
          icon: const Icon(TablerIcons.caret_left_filled),
          color: const Color(0xfffef4f5),
          iconSize: 24,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'WRITE NOTES',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xfffef4f5),
              fontSize: 24,
              fontFamily: 'Open_Sans'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  color: Color(0xffaac0f9),
                  fontSize: 12,
                  fontFamily: 'Open_Sans',
                  fontWeight: FontWeight.w600,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: contentController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  labelStyle: TextStyle(
                    color: Color(0xffaac0f9),
                    fontSize: 12,
                    fontFamily: 'Open_Sans',
                    fontWeight: FontWeight.w600,
                  ),
                  alignLabelWithHint: true,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: const Color(0xffee4176),
        child: TextButton(
          onPressed: () => _saveNote(context),
          child: const Text(
            'SAVE',
            style: TextStyle(
              color: Color(0xfffef4f5),
              fontSize: 12,
              fontFamily: 'Open_Sans',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
