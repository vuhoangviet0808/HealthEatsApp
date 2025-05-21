import 'package:flutter/material.dart';
import '../../../../core/themes/theme.dart';

class CategoryRow extends StatefulWidget {
  const CategoryRow({super.key});

  @override
  State<CategoryRow> createState() => _CategoryRowState();
}

class _CategoryRowState extends State<CategoryRow> {
  final cats = const ['Breakfast', 'Lunch', 'Dinner', 'Snack', 'Drinks'];
  int _selected = 0;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: cats.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, i) => ChoiceChip(
            label: Text(cats[i]),
            selected: _selected == i,
            selectedColor: primaryColor.withOpacity(.2),
            labelStyle: TextStyle(
              color: _selected == i ? primaryColor : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
            onSelected: (_) => setState(() => _selected = i),
          ),
        ),
      );
}
