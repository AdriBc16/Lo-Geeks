import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo con opacidad
          Opacity(
            opacity: 0.3,
            child: Image.asset(
              "assets/images/background.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // Imagen centrada encima
          Center(
            child: Image.asset(
              "assets/images/registrer.png", // <-- tu imagen encima
              width: 500, // puedes ajustar tamaño
              height: 250,
            ),
          ),
        ],
      ),
    );
  }
}
