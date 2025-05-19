import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogoScreen extends StatefulWidget {
  const LogoScreen({super.key});
  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  late final Timer _t;

  @override
  void initState() {
    super.initState();
    _t = Timer(const Duration(seconds: 3), () {
      if (mounted) context.go('/login');
    });
  }

  @override
  void dispose() {
    _t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo2.webp',
                width: size,
                height: size,
                fit: BoxFit.contain),
            const SizedBox(height: 20),
            Text('HealthEats',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
