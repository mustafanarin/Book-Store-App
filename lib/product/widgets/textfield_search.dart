
import 'package:book_store_mobile/product/color/project_colors.dart';
import 'package:flutter/material.dart';

class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch({
    super.key,
    required this.tfSearchController, this.onChanged,
  });

  final TextEditingController tfSearchController;
  final String searchText = "Search";
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: tfSearchController,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: searchText,
        suffixIcon: const Icon(Icons.tune),
        prefixIcon: const Icon(Icons.search),
      ),
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
      color: ProjectColors.cosmicVoid
     )
    );
  }
}

