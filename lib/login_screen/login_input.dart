import 'package:flutter/material.dart';

class LoginInput extends StatefulWidget {
  const LoginInput({
    super.key,
    required this.icon,
    required this.hint,
    this.obscureText = false,
    this.enabled = true,
    required this.controller,
  });

  final IconData icon;
  final String hint;
  final bool obscureText;
  final bool enabled;
  final TextEditingController controller;

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  bool _showClearButton = false;

  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {
        _showClearButton = widget.controller.text.isNotEmpty;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    IconButton? clearWidget;
    if (_showClearButton) {
      clearWidget = IconButton(
        icon: const Icon(Icons.clear_sharp),
        onPressed: () {
          widget.controller.clear();
        },
      );
    }
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(35.0),
      ),
    );
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      enabled: widget.enabled,
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.icon,
        ),
        suffixIcon: clearWidget,
        enabledBorder: border,
        disabledBorder: border,
        focusedBorder: border,
        hintText: widget.hint,
        hintStyle: const TextStyle(fontSize: 14),
        contentPadding: const EdgeInsets.all(10),
      ),
    );
  }
}