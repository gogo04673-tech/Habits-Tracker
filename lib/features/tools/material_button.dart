// import 'package:flutter/material.dart';

// class ButtonMaterial extends StatefulWidget {
//   const ButtonMaterial({super.key, required this.title, required this.changeColor, this.onTap});
//   final String title;
//   final bool changeColor ;
//   final void Function()? onTap;

//   @override
//   State<ButtonMaterial> createState() => _ButtonMaterial();
// }

// class _ButtonMaterial extends State<ButtonMaterial> {

//   void Function()? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       highlightColor: Colors.transparent,
//       splashColor: Colors.transparent,

//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 10),
//         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//         decoration: BoxDecoration(
//           color: widget.changeColor ? const Color(0xFF47b5eb) : Colors.transparent,
//           borderRadius: BorderRadius.circular(15),
//           border: BoxBorder.all(color: Colors.white),
//         ),
//         child: Text(
//           widget.title,
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ButtonMaterial extends StatefulWidget {
  const ButtonMaterial({
    super.key,
    required this.title,
    required this.changeColor,
    this.onTap,
  });

  final String title;
  final bool changeColor;
  final void Function()? onTap;

  @override
  State<ButtonMaterial> createState() => _ButtonMaterial();
}

class _ButtonMaterial extends State<ButtonMaterial> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: widget.changeColor
              ? const Color(0xFF47b5eb)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white), // fixed this line too
        ),
        child: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
