import 'package:flutter/material.dart';

enum ButtonVariant {
  outlined,
  active,
  inactive,
}

class CustomButton extends StatelessWidget {
  final ButtonVariant variant;
  final String text;
  final VoidCallback onClick;

  const CustomButton({
    super.key,
    required this.variant,
    required this.text,
    required this.onClick,
  });
  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    Color? textColor;
    Color? borderColor;

    switch (variant) {
      case ButtonVariant.outlined:
        backgroundColor = Colors.transparent;
        textColor = Colors.black;
        borderColor = Colors.black;
        break;
      case ButtonVariant.active:
        backgroundColor = Colors.black;
        textColor = Colors.white;
        borderColor = Colors.white;
        break;
      case ButtonVariant.inactive:
        backgroundColor = Colors.transparent;
        textColor = Colors.black;
        borderColor = Colors.grey;
        break;
    }

    return ElevatedButton(
      onPressed: onClick,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color?>(backgroundColor),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            return states.contains(MaterialState.pressed)
                ? Colors.transparent
                : null;
          },
        ),
        elevation: MaterialStateProperty.all<double>(0), // Remove elevation
        fixedSize: MaterialStateProperty.all<Size>(
          Size(MediaQuery.of(context).size.width, 50),
        ),
        shadowColor: MaterialStateProperty.all<Color?>(Colors.transparent),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: BorderSide(color: borderColor!),
          ),
        ),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
            fontSize: 18,
            letterSpacing: 3,
            fontWeight: FontWeight.w400,
            color: textColor), // Set text color here
      ),
    );
  }
}
