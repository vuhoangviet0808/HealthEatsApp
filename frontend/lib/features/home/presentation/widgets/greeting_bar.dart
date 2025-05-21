import 'package:flutter/material.dart';

class GreetingBar extends StatelessWidget {
  const GreetingBar({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Good morning, Alice 👋',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 6),
          Text('Track your meals and stay healthy!',
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      );
}
