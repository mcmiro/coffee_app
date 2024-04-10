import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller; // Add controller parameter

  const InputField({
    super.key,
    required this.labelText,
    this.controller, // Initialize controller parameter
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // Use the provided controller
      decoration: InputDecoration(
        labelText: labelText,
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 43, 43, 43),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
