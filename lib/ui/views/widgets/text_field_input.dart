import 'package:flutter/material.dart';

class TextFieldInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final int? maxLines;
  final String? Function(String?)? validator;

  const TextFieldInput({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.obscureText = false,
    this.maxLines,
    this.validator,
  }) : super(key: key);

  @override
  _TextFieldInputState createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  late bool _isObscure;


  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText;

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child:  TextFormField(
        controller: widget.controller,
        obscureText: _isObscure,
        maxLines: widget.obscureText ? 1 : widget.maxLines,
        decoration: InputDecoration(
          hintText: widget.hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:   BorderSide(color: Colors.grey[300]!,)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color:  Colors.grey[300]!,)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:  BorderSide(color: Colors.grey[300]!,)
          ),
          suffixIcon: widget.obscureText
              ? IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey[600],
            ),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          )
              : null,
        ),
        validator: widget.validator,
      ),
    );
  }
}