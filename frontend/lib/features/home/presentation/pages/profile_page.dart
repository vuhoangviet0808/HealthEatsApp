import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          'Your profile coming soon!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      );
}
