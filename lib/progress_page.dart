// import 'package:flutter/material.dart';
// import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:no_fap/notes_list_page.dart';
// import 'package:no_fap/upload_image_page.dart';
// import 'package:no_fap/write_notes_page.dart';

// class ProgressPage extends StatefulWidget {
//   @override
//   _ProgressPageState createState() => _ProgressPageState();
// }

// class _ProgressPageState extends State<ProgressPage> {
//   DateTime? startDate;
//   List<String> status = [];
//   int _selectedIndex = -1;

//   void _navigateToPage(int index) {
//     if (_selectedIndex == index) // prevent re-navigation to same page
//       setState(() => _selectedIndex = index);

//     Widget page;
//     switch (index) {
//       case 0:
//         page = NotesListPage();
//         break;
//       case 1:
//         page = WriteNotePage();
//         break;
//       case 2:
//         page = const GalleryPage();
//         break;
//       default:
//         return;
//     }

//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => page),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadProgress();
//   }

// Future<void> _loadProgress() async {
//   final prefs = await SharedPreferences.getInstance();
//   final startDateMillis = prefs.getInt('start_date');
  
//   if (startDateMillis == null) {
//     // If no date exists, set it to today and save
//     startDate = DateTime.now();
//     await prefs.setInt('start_date', startDate!.millisecondsSinceEpoch);
//   } else {
//     startDate = DateTime.fromMillisecondsSinceEpoch(startDateMillis);
//   }

//   int daysPassed = DateTime.now().difference(startDate!).inDays;

//   List<String> list = List.generate(50, (index) {
//     if (index < daysPassed) return "Completed";
//     if (index == daysPassed) return "In progress";
//     return "Pending";
//   });

//   setState(() {
//     status = list;
//   });

//   // Optionally save last opened timestamp
//   await prefs.setInt('last_opened', DateTime.now().millisecondsSinceEpoch);
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('NO FAP'),
//         centerTitle: true,
//         titleTextStyle: const TextStyle(
//             fontFamily: "Open_Sans",
//             fontWeight: FontWeight.w700,
//             fontSize: 24,
//             color: Color(0xfffef4f5)),
//         backgroundColor: const Color(0xffee4176),
//         toolbarHeight: 70,
//         // actions: [IconButton(icon: Icon(Icons.delete), onPressed: _resetChallenge)],
//         leading: const Icon(
//           TablerIcons.menu_2,
//           color: Color(0xfffef4f5),
//           size: 24,
//         ),
//       ),
//       backgroundColor: const Color(0xffffffff),
//       body: ListView.builder(
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
//         itemCount: status.length,
//         itemBuilder: (context, index) {
//           final isCompleted = status[index] == "Completed";

//           Color containerColor;
//           Color borderColor;
//           Color textColor;
//           FontWeight fontWeight;
//           double fontSize;

//           switch (status[index]) {
//             case "Completed":
//               containerColor = const Color(0xffaac0f9);
//               borderColor = const Color(0xffaac0f9);
//               textColor = const Color(0xfffef4f5);
//               fontWeight = FontWeight.w700;
//               fontSize = 14;
//               break;
//             case "In progress":
//               containerColor = const Color(0xff6c7bcc);
//               borderColor = const Color(0xff6c7bcc);
//               textColor = const Color(0xfffef4f5);
//               fontWeight = FontWeight.w700;
//               fontSize = 14;
//               break;
//             default:
//               containerColor = const Color(0xffffffff);
//               borderColor = const Color(0xff6c7bcc);
//               textColor = const Color(0xffaac0f9);
//               fontWeight = FontWeight.normal;
//               fontSize = 14;
//           }

//           return Container(
//             height: 60,
//             margin: const EdgeInsets.only(bottom: 12),
//             padding: const EdgeInsets.symmetric(horizontal: 14),
//             decoration: BoxDecoration(
//               color: containerColor,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: borderColor, width: 1.0),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Day ${index + 1}",
//                       style: TextStyle(
//                         fontFamily: "Open_Sans",
//                         color: textColor,
//                         fontSize: fontSize,
//                         fontWeight: fontWeight,
//                       ),
//                     ),
//                     Text(
//                       status[index],
//                       style: TextStyle(
//                         fontFamily: "Open_Sans",
//                         color: textColor,
//                         fontSize: fontSize,
//                         fontWeight: fontWeight,
//                       ),
//                     ),
//                   ],
//                 ),
//                 if (isCompleted)
//                   const Icon(
//                     TablerIcons.square_rounded_check_filled,
//                     size: 30,
//                     color: Color(0xfffef4f5),
//                   ),
//               ],
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: BottomAppBar(
//         height: 60,
//         color: const Color(0xFFee4176),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 32,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               IconButton(
//                 icon: const Icon(TablerIcons.notes, color: Color(0xfffef4f5)),
//                 onPressed: () => _navigateToPage(0),
//               ),
//               IconButton(
//                 icon: const Icon(TablerIcons.plus, color: Color(0xfffef4f5)),
//                 onPressed: () => _navigateToPage(1),
//               ),
//               IconButton(
//                 icon: const Icon(TablerIcons.photo_plus,
//                     color: Color(0xfffef4f5)),
//                 onPressed: () => _navigateToPage(2),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:no_fap/notes_list_page.dart';
import 'package:no_fap/upload_image_page.dart';
import 'package:no_fap/write_notes_page.dart';

class ProgressPage extends StatefulWidget {
  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  DateTime? startDate;
  List<String> status = [];
  int _selectedIndex = -1;

  void _navigateToPage(int index) {
    if (_selectedIndex == index) return;

    setState(() => _selectedIndex = index);

    Widget page;
    switch (index) {
      case 0:
        page = NotesListPage();
        break;
      case 1:
        page = WriteNotePage();
        break;
      case 2:
        page = const GalleryPage();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  // Future<void> _loadProgress() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final startDateMillis = prefs.getInt('start_date');

  //   if (startDateMillis == null) {
  //     startDate = DateTime.now();
  //     await prefs.setInt('start_date', startDate!.millisecondsSinceEpoch);
  //   } else {
  //     startDate = DateTime.fromMillisecondsSinceEpoch(startDateMillis);
  //   }

  //   int daysPassed = DateTime.now().difference(startDate!).inDays;

  //   List<String> list = List.generate(50, (index) {
  //     if (index < daysPassed) return "Completed";
  //     if (index == daysPassed) return "In progress";
  //     return "Pending";
  //   });

  //   setState(() {
  //     status = list;
  //   });

  //   await prefs.setInt('last_opened', DateTime.now().millisecondsSinceEpoch);
  // }

Future<void> _loadProgress() async {
  final prefs = await SharedPreferences.getInstance();
  final startDateMillis = prefs.getInt('start_date');

  if (startDateMillis == null) {
    startDate = DateTime.now();
    await prefs.setInt('start_date', startDate!.millisecondsSinceEpoch);
  } else {
    startDate = DateTime.fromMillisecondsSinceEpoch(startDateMillis);
  }

  int daysPassed = DateTime.now().difference(startDate!).inDays;

  List<String> list = List.generate(50, (index) {
    if (index < daysPassed) return "Completed";
    if (index == daysPassed) return "In progress";
    return "Pending";
  });

  setState(() {
    status = list;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NO FAP'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            fontFamily: "Open_Sans",
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Color(0xfffef4f5)),
        backgroundColor: const Color(0xffee4176),
        toolbarHeight: 70,
        leading: const Icon(
          TablerIcons.menu_2,
          color: Color(0xfffef4f5),
          size: 24,
        ),
      ),
      backgroundColor: const Color(0xffffffff),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
        itemCount: status.length,
        itemBuilder: (context, index) {
          final isCompleted = status[index] == "Completed";

          Color containerColor;
          Color borderColor;
          Color textColor;
          FontWeight fontWeight;
          double fontSize;

          switch (status[index]) {
            case "Completed":
              containerColor = const Color(0xffaac0f9);
              borderColor = const Color(0xffaac0f9);
              textColor = const Color(0xfffef4f5);
              fontWeight = FontWeight.w700;
              fontSize = 14;
              break;
            case "In progress":
              containerColor = const Color(0xff6c7bcc);
              borderColor = const Color(0xff6c7bcc);
              textColor = const Color(0xfffef4f5);
              fontWeight = FontWeight.w700;
              fontSize = 14;
              break;
            default:
              containerColor = const Color(0xffffffff);
              borderColor = const Color(0xff6c7bcc);
              textColor = const Color(0xffaac0f9);
              fontWeight = FontWeight.normal;
              fontSize = 14;
          }

          return Container(
            height: 60,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor, width: 1.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Day ${index + 1}",
                      style: TextStyle(
                        fontFamily: "Open_Sans",
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                      ),
                    ),
                    Text(
                      status[index],
                      style: TextStyle(
                        fontFamily: "Open_Sans",
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                      ),
                    ),
                  ],
                ),
                if (isCompleted)
                  const Icon(
                    TablerIcons.square_rounded_check_filled,
                    size: 30,
                    color: Color(0xfffef4f5),
                  ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: const Color(0xFFee4176),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(TablerIcons.notes, color: Color(0xfffef4f5)),
                onPressed: () => _navigateToPage(0),
              ),
              IconButton(
                icon: const Icon(TablerIcons.plus, color: Color(0xfffef4f5)),
                onPressed: () => _navigateToPage(1),
              ),
              IconButton(
                icon: const Icon(TablerIcons.photo_plus,
                    color: Color(0xfffef4f5)),
                onPressed: () => _navigateToPage(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
