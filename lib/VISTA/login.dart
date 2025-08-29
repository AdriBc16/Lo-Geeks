import 'package:app_prueba_flutter/VISTA/home_page.dart';
import 'package:app_prueba_flutter/VISTA/registrer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'api_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  // Clave para controlar la animación de error y el formulario
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Paleta de colores consistente
  static const Color primaryBackgroundColor = Color(
    0xFF141F25,
  ); // Fondo oscuro principal
  static const Color secondaryCardColor = Color(
    0xFF1B252D,
  ); // Color de tarjeta/panel
  static const Color accentColor = Color(
    0xFFFF5C8D,
  ); // Color de acento para botones/iconos
  static const Color textColor = Colors.white; // Color de texto principal
  static const Color hintColor = Colors.white70; // Color para hints de inputs
  static const Color iconColor = Color(0xFF97A5EC); // Color de iconos en inputs

  Future<void> _login() async {
    // Valida el formulario
    if (!_formKey.currentState!.validate()) {
      // Si la validación falla, activar la animación de "shake"
      _formKey.currentState?.widget.animate().shakeX(
        amount: 8,
        duration: 400.ms,
      );
      return;
    }

    // Oculta el teclado
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });

    try {
      await _apiService.login(
        _usernameController.text,
        _passwordController.text,
      );

      // Si el login es exitoso, navega a la HomePage con una transición suave
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomePage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 700),
        ),
      );
    } catch (e) {
      // Si hay un error, muestra un SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll("Exception: ", "")),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 3),
        ),
      );
      // Activa la animación de "shake" en el formulario cuando falla el login
      _formKey.currentState?.widget.animate().shakeX(
        amount: 8,
        duration: 400.ms,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      body: Stack(
        children: [
          // Fondo con gradiente y animación de aparición
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryBackgroundColor,
                  Color(0xFF363C54),
                ], // Un gradiente suave
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ).animate().fadeIn(
            duration: 1200.ms,
          ), // Animación de fade-in para el fondo
          // Contenido centrado con animación de entrada
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 40.0,
              ),
              child: Form(
                key: _formKey, // Asignamos la clave al formulario
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icono/Logo con animación de aparición y escala
                    const Icon(
                          Icons.videogame_asset_outlined,
                          size: 80,
                          color: accentColor,
                        )
                        .animate(delay: 200.ms)
                        .fadeIn(duration: 600.ms)
                        .scale(
                          begin: const Offset(0.5, 0.5),
                          curve: Curves.easeOutBack,
                        ),

                    const SizedBox(height: 20),

                    // Título de bienvenida con animación de deslizamiento
                    const Text(
                          "GeekPlayground",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        )
                        .animate(delay: 400.ms)
                        .fadeIn(duration: 600.ms)
                        .slideY(begin: 0.5, end: 0, curve: Curves.easeOutCubic),

                    const SizedBox(height: 40),

                    // Campo de usuario con animaciones
                    _buildAnimatedTextField(
                      controller: _usernameController,
                      hint: "Usuario",
                      icon: Icons.person_outline,
                      delay: 600.ms,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa tu usuario';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Campo de contraseña con animaciones
                    _buildAnimatedTextField(
                      controller: _passwordController,
                      hint: "Contraseña",
                      icon: Icons.lock_outline,
                      isPassword: true,
                      delay: 800.ms,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa tu contraseña';
                        }
                        return null;
                      },
                      onSubmitted: (_) => _login(), // Login al presionar Enter
                    ),

                    const SizedBox(height: 40),

                    // Botón de Login con indicador de carga y animaciones
                    _buildLoginButton()
                        .animate(delay: 1000.ms)
                        .fadeIn(duration: 600.ms)
                        .slideY(begin: 0.5, end: 0, curve: Curves.easeOutCubic),

                    const SizedBox(height: 20),

                    // Botón para ir a registrarse
                    TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Register(),
                              ),
                            );
                          },
                          child: const Text(
                            "¿No tienes una cuenta? Regístrate aquí.",
                            style: TextStyle(color: iconColor),
                          ),
                        )
                        .animate(delay: 1200.ms)
                        .fadeIn(duration: 600.ms)
                        .slideY(begin: 0.5, end: 0, curve: Curves.easeOutCubic),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget reutilizable y animado para los campos de texto
  Widget _buildAnimatedTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    required Duration delay,
    String? Function(String?)? validator,
    void Function(String)? onSubmitted,
  }) {
    return TextFormField(
          controller: controller,
          obscureText: isPassword,
          style: const TextStyle(color: textColor),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: iconColor),
            hintText: hint,
            hintStyle: const TextStyle(color: hintColor),
            filled: true,
            fillColor: textColor.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            errorStyle: const TextStyle(color: Colors.redAccent),
          ),
          validator: validator,
          onFieldSubmitted: onSubmitted,
        )
        .animate(delay: delay)
        .fadeIn(duration: 600.ms)
        .slideX(begin: -0.5, end: 0, curve: Curves.easeOutCubic);
  }

  // Widget para el botón de login con estado de carga
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
        ),
        onPressed: _isLoading ? null : _login,
        child: _isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: primaryBackgroundColor,
                ),
              )
            : const Text(
                "Iniciar Sesión",
                style: TextStyle(
                  color: primaryBackgroundColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
