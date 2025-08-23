import 'package:flutter/material.dart';

class Terms_conditions extends StatelessWidget {
  const Terms_conditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms and Conditions"),
        backgroundColor: const Color(0xFF141F25),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(
        color: const Color(0xFF141F25),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: const Text("""
📜 Términos y Condiciones de Lo-Geeks
Fecha de vigencia: [poner fecha]

1. Introducción
Bienvenido a Lo-Geeks. Al acceder y utilizar nuestra aplicación, usted acepta estos Términos y Condiciones (“Términos”), así como nuestra Política de Privacidad. Estos Términos regulan el uso de la aplicación móvil, el sitio web y cualquier servicio relacionado ofrecido por Lo-Geeks Team. Si utiliza los Servicios en nombre de una institución educativa, declara que tiene autoridad para aceptar estos Términos.

2. Uso de la Aplicación
- Debe tener al menos 13 años para usar Lo-Geeks.
- Si es menor de edad, necesita consentimiento de un tutor legal.
- Lo-Geeks es con fines educativos y recreativos. Está prohibido usarla con fines ilícitos o que infrinjan derechos de terceros.

3. Cuenta y Seguridad
- Para acceder a juegos, estadísticas y biblioteca deberá registrarse.
- Usted es responsable de la seguridad de sus credenciales.
- En caso de uso no autorizado o robo de credenciales, notifíquelo de inmediato.

4. Contenido de Usuario
- Los usuarios pueden subir archivos a la Biblioteca.
- Usted conserva los derechos de autor, pero nos otorga licencia gratuita para almacenar y procesar dicho contenido.
- Está prohibido subir contenido violento, ilegal o que infrinja derechos de autor.

5. Juegos, Puntuaciones y Estadísticas
- Los juegos generan puntajes acumulativos que reflejan su progreso.
- El puntaje no tiene valor monetario.
- No se permite manipular ni alterar el sistema de estadísticas.

6. Biblioteca e Inteligencia Artificial
- Los archivos subidos podrán ser procesados por IA para generar nuevas preguntas.
- Nos reservamos el derecho de eliminar contenido que no cumpla las normas.
- El contenido generado es educativo y no sustituye asesoría académica oficial.

7. Propiedad Intelectual
- Todo el software, juegos y diseños de Lo-Geeks pertenecen a sus desarrolladores.
- Está prohibido copiar, modificar o descompilar la aplicación.

8. Limitación de Responsabilidad
- Lo-Geeks se ofrece “tal cual”, sin garantías de estar libre de errores.
- No somos responsables de pérdidas de datos o daños derivados del uso.

9. Terminación de Cuentas
- Puede eliminar su cuenta en cualquier momento.
- Nos reservamos el derecho de suspender cuentas que incumplan estos Términos.

10. Cambios en los Términos
Podemos actualizar estos Términos en cualquier momento. Notificaremos cambios relevantes dentro de la aplicación.

11. Ley Aplicable
Estos Términos se rigen por las leyes de [país/jurisdicción]. Las disputas se resolverán en tribunales competentes de esa jurisdicción.

12. Contacto
Para dudas sobre los Términos, escríbanos a: [correo de contacto].
""", style: TextStyle(fontSize: 16, color: Colors.white, height: 1.5)),
        ),
      ),
    );
  }
}
