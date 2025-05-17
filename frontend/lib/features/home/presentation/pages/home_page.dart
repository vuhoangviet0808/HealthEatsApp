import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});
  @override Widget build(BuildContext ctx)=>Scaffold(
      appBar: AppBar(title: const Text('HealthEats App')),
      body: const Center(child: Text('Home Screen')));
}
