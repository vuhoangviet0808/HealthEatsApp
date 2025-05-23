import 'package:flutter/material.dart';
import 'package:frontend/features/home/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

import 'core/themes/theme.dart';
import 'logo_screen.dart';
import 'features/authentication/presentation/pages/login_page.dart';

final _router = GoRouter(
  initialLocation: '/',                 // mở app chạy Logo trước
  routes: [
    GoRoute(
      path: '/',
      // pageBuilder: (_, __) => const NoTransitionPage(child: HomePage()),
      pageBuilder: (_, __) => const NoTransitionPage(child: LogoScreen()),
    ),
    GoRoute(
      path: '/login',
      builder: (_, __) => const LoginPage(),
    ),
    GoRoute(path: '/home',    builder: (_, __) => const HomePage()),
  ],
);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'HealthEats',
      theme: appTheme,                  
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
