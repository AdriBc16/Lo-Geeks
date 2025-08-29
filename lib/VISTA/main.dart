import 'package:app_prueba_flutter/VISTA/login.dart';
import 'package:app_prueba_flutter/VISTA/option.dart';
import 'package:app_prueba_flutter/VISTA/registrer.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: const Login());
  }
}
