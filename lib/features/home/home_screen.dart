import 'package:flutter/material.dart';
import 'package:qrone/features/home/home_controller.dart';
import 'package:qrone/main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = container.get<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => controller.logout(),
          ),
        ],
      ),
      body:   Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              controller.logout()
;            }, child: Text('Sign out')),
            Text('Home Screen'),
          ],
        ),
      ),
    );
  }
}