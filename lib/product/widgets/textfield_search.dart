
import 'package:flutter/material.dart';

class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch({
    super.key,
    required this.tfSearchController,
  });

  final TextEditingController tfSearchController;
  final String searchText = "Search";

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: tfSearchController,
      decoration: InputDecoration(
        hintText: searchText,
        suffixIcon: Icon(Icons.tune),
        prefixIcon: Icon(Icons.search)
      ),
    );
  }
}

