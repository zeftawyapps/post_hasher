import 'package:flutter/material.dart';
import 'package:post_hasher/screens/main_screen.dart';
class LounchApp extends StatelessWidget {
  const LounchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}