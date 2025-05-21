import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) => TextField(
        decoration: InputDecoration(
          hintText: 'Search healthy recipes…',
          prefixIcon: const Icon(Icons.search),
        ),
      );
}
