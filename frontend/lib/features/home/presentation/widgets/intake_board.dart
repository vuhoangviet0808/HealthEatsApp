import 'package:flutter/material.dart';
import '../../../../core/themes/theme.dart';

class IntakeBoard extends StatelessWidget {
  const IntakeBoard({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: thay số liệu thật khi kết nối API
    final items = [
      ('Calories', 660, 2000, Icons.local_fire_department),
      ('Protein', 35, 80, Icons.egg_alt),
      ('Carbs', 120, 300, Icons.rice_bowl),
      ('Fat', 20, 70, Icons.oil_barrel_rounded),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.4),
      itemBuilder: (_, i) {
        final (title, value, max, icon) = items[i];
        final pct = value / max;
        return Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: primaryColor),
                const Spacer(),
                Text('$value / $max',
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 4),
                Text(title, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: pct,
                  color: primaryColor,
                  backgroundColor: secondaryColor,
                  minHeight: 6,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
