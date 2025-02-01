import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/theme.dart';

class LogoScreen extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      context.go('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8, 
              height: MediaQuery.of(context).size.width * 0.8, 
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo2.webp'),
                  fit: BoxFit.contain, 
                ),
              ),
            ),

            SizedBox(height: 20), 
            Text(
              "HealthEats",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white, 
                shadows: [
                  Shadow(blurRadius: 4, color: Colors.black.withOpacity(0.3)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
