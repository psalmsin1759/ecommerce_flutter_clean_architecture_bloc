import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? headerText;
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final TextInputType keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    this.headerText,
    required this.controller,
    required this.hintText,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.headerText != null && widget.headerText!.isNotEmpty) ...[
          Text(
            widget.headerText!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
        ],

        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ? _obscureText : false,
          validator: widget.validator,
          decoration: InputDecoration(
            prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
            hintText: widget.hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
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
      ],
    );
  }
}
