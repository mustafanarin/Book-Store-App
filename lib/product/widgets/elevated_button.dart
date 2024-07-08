import 'package:book_store_mobile/product/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class ElevatedButtonProject extends StatelessWidget {
  const ElevatedButtonProject({
    super.key, required this.text, this.onPressed, required this.backgroundColor, required this.textColor,
  });
  final String text;
  final void Function()? onPressed;
  final Color backgroundColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.buttonHeight,
      width: context.dynamicWidht(1),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor
        ),
        onPressed: onPressed,
         child: Text(text,style: TextStyle(color: textColor),)),
    );
  }
}