// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

// void showEmojiDialog() {
//   String selectedEmoji = "";

//   Get.dialog(
//     Center(
//       child: StatefulBuilder(
//         builder: (context, setState) {
//           return Container(
//             padding: const EdgeInsets.all(16),
//             width: 320,
//             decoration: BoxDecoration(
//               color: const Color(0xFF111C22),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Header
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Select Emoji",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         decoration: TextDecoration.none,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () => Get.back(),
//                       icon: const Icon(Icons.clear, color: Colors.white),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 10),

//                 // Selected emoji preview
//                 Text(selectedEmoji, style: const TextStyle(fontSize: 40)),

//                 const SizedBox(height: 10),

//                 // Emoji picker
//                 SizedBox(
//                   height: 250,
//                   child: EmojiPicker(
//                     onEmojiSelected: (category, emoji) {
//                       setState(() {
//                         selectedEmoji = emoji.emoji;
//                       });
//                     },
//                     config: const Config(
//                       columns: 7,
//                       emojiSizeMax: 32,
//                       verticalSpacing: 0,
//                       horizontalSpacing: 0,
//                       initCategory: Category.SMILEYS,
//                       bgColor: Color(0xFF111C22),
//                       indicatorColor: Colors.blue,
//                       iconColor: Colors.grey,
//                       iconColorSelected: Colors.blue,
//                       backspaceColor: Colors.red,
//                       skinToneDialogBgColor: Colors.white,
//                       enableSkinTones: true,
                      
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 ElevatedButton(
//                   onPressed: () {
//                     // Use selectedEmoji
//                     print("Selected: $selectedEmoji");
//                     Get.back(result: selectedEmoji);
//                   },
//                   child: const Text("Select"),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     ),
//   );
// }
