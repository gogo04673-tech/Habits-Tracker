import 'package:flutter/material.dart';

class TextFiledForm extends StatefulWidget {
  const TextFiledForm({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.stateIcon = false,
    this.maxLines = 1, // Add this
    this.minLines, // Add this
  });

  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool stateIcon;
  final int maxLines; // Add this
  final int? minLines;

  @override
  State<TextFiledForm> createState() => _TextFormFiledState();
}

class _TextFormFiledState extends State<TextFiledForm> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        obscureText: _obscureText,
        maxLines: widget.maxLines, // Add this
        minLines: widget.minLines, // Add this
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          decoration: TextDecoration.none,
        ),
        cursorColor: const Color.fromARGB(255, 156, 156, 156),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Color(0xFF7393a4), fontSize: 14),
          filled: true,
          fillColor: const Color(0xFF243b47),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          suffixIcon: widget.stateIcon
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: const Color(0xFF7393a4),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
