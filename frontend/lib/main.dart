import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection.dart';
import 'features/authentication/presentation/pages/login_page.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();                    // ← quan trọng
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthEats',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      // Bao BlocProvider cấp cao để các screen con dùng chung
      home: BlocProvider<AuthBloc>(
        create: (_) => sl<AuthBloc>(),
        child: const LoginPage(),
      ),
    );
  }
}
