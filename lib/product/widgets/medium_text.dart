
import 'package:book_store_mobile/product/color/project_colors.dart';
import 'package:book_store_mobile/product/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class MediumText extends StatelessWidget {
  const MediumText({
    super.key, required this.text,this.color = ProjectColors.cosmicVoid,
  });
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: context.textTheme().bodyLarge?.copyWith(
      fontWeight: FontWeight.w600,
      color: color
    ),);
  }
}
