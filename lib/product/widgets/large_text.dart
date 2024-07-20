import 'package:book_store_mobile/product/color/project_colors.dart';
import 'package:book_store_mobile/product/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class LargeText extends StatelessWidget {
  const LargeText({
    super.key, required this.text
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: context.textTheme().titleLarge?.copyWith(
      fontWeight: FontWeight.w700,
      color: ProjectColors.cosmicVoid
    ),);
  }
}