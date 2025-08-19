import 'package:flutter/material.dart';

class Terms_conditions extends StatelessWidget {
  const Terms_conditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Terms and Conditions")),

      body: const Center(
        child: Text(
          "Aqui iran los terminos y condiciones",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
