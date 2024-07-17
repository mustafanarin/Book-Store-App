
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
        suffixIcon: Icon(Icons.tune),
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}

