import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),

      body: const Center(
        child: Text(
          "Aqui iran botones de cambiar nombre, datos personales , cambiar contrasenia , no se que mas puede tener, total el profe no se fijara tanto en esto pero para tenerlo ahi",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
