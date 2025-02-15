import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'core/themes/theme.dart'; // Import theme
import 'features/authentication/presentation/logo_screen.dart';
import 'features/authentication/presentation/login_screen.dart';

void main() {
  runApp(MyApp());
}

// Cấu hình điều hướng bằng GoRouter
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => LogoScreen()),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
  ],
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: appTheme, // Áp dụng theme
    );
  }
}
