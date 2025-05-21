import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final int kcal;
  final String imagePath; // asset hoặc url

  const RecipeCard({
    super.key,
    required this.title,
    required this.kcal,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 160,
        child: InkWell(
          onTap: () {}, // TODO: mở trang chi tiết
          child: Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    imagePath,
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.local_fire_department,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text('$kcal kcal',
                              style: const TextStyle(color: Colors.black54)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
