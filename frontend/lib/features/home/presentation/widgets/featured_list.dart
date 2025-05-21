import 'package:flutter/material.dart';
import 'recipe_card.dart';

class FeaturedList extends StatelessWidget {
  const FeaturedList({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: thay dữ liệu thật bằng fetch từ API/HomeBloc
    final sample = [
      ('Avocado Salad', 320, 'assets/images/recipe_1.webp'),
      ('Berry Smoothie', 180, 'assets/images/recipe_2.webp'),
      ('Grilled Chicken', 450, 'assets/images/recipe_3.webp'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Featured Recipes',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: sample.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (_, i) => RecipeCard(
              title: sample[i].$1,
              kcal: sample[i].$2,
              imagePath: sample[i].$3,
            ),
          ),
        ),
      ],
    );
  }
}
