import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Help and frequently asked questions")),

      body: const Center(
        child: Text(
          "Aqui iran las preguntas frecuentes y ayuda para que sepan como usar la app",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
