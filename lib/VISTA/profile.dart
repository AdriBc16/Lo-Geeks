import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String nombreUsuario;
  const Profile({super.key, required this.nombreUsuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141F25), // Fondo oscuro
      body: SafeArea(
        child: Column(
          children: [
            // Avatar circular
            const SizedBox(height: 40),

            CircleAvatar(
              radius: 80,
              backgroundColor: const Color(0xFFB7E1B5),
              child: const Icon(
                Icons.person,
                size: 80, // tamaño del ícono dentro del círculo
                color: Colors.white70, // color del ícono
              ),
            ),

            const SizedBox(height: 40),

            // Nombre de usuario
            Text(
              nombreUsuario,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            // Caja de estadísticas
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFBBD5F5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    "Estadísticas",
                    style: TextStyle(
                      color: Color(0xFF363C54),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Filas con estadísticas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _statBox("100", "datos"),
                      _statBox("100", "datos"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para cada cajita de estadísticas
  Widget _statBox(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: 100,
      decoration: BoxDecoration(
        color: const Color(0xFF97A5EC),
        borderRadius: BorderRadius.circular(15), // cuadros pequenios
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF363C54),
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF363C54)),
          ),
        ],
      ),
    );
  }
}
