
import 'package:book_store_mobile/product/color/project_colors.dart';
import 'package:flutter/material.dart';

class MediumText extends StatelessWidget {
  const MediumText({
    super.key, required this.text,this.color = ProjectColors.cosmicVoid,
  });
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: color));
  }
}
