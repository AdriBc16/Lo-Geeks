import 'package:app_prueba_flutter/VISTA/home_page.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo oscuro
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFF141F25),
          ),

          // Imagen de fondo con opacidad
          Opacity(
            opacity: 0.1,
            child: Image.asset(
              "assets/images/background.png", // tu fondo
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // Contenido principal
          Column(
            children: [
              const SizedBox(height: 50), // avatar más arriba
              // Imagen circular (avatar)
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, size: 50, color: Colors.grey),
                ),
              ),

              const SizedBox(height: 30),

              // Campos y botón centrados pero subidos un poco
              Expanded(
                child: Align(
                  alignment: const Alignment(
                    0,
                    -0.2,
                  ), // mueve el bloque hacia arriba
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Texto Login
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFEFB9C8),
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Campo usuario
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "User",
                              hintStyle: const TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: const Color(0xFFFF5C8D),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Campo password
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextField(
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: const TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: const Color(0xFFFF5C8D),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),

                        // Botón login
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEFB9C8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 100,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            // Acción login
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50), // espacio final opcional
            ],
          ),
        ],
      ),
    );
  }
}
