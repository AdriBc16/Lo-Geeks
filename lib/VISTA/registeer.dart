import 'package:app_prueba_flutter/VISTA/login.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Controladores y claves
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  // Control de visibilidad de la contraseña
  bool _obscurePassword = true;

  // Paleta de colores consistente con el Login
  static const Color primaryBackgroundColor = Color(0xFF141F25);
  static const Color accentColor = Color(
    0xFF424690,
  ); // Un color distinto para el botón de registro
  static const Color textColor = Colors.white;
  static const Color hintColor = Colors.white70;
  static const Color iconColor = Color(0xFF97A5EC);

  Future<void> _register() async {
    // Si el formulario no es válido, activa la animación de "shake"
    if (!_formKey.currentState!.validate()) {
      _formKey.currentState?.widget.animate().shakeX(
        amount: 8,
        duration: 400.ms,
      );
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });

    try {
      await _apiService.register(
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Registro exitoso! Por favor, inicia sesión.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      // Navega a la pantalla de login y elimina la de registro del historial
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => const Login()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll("Exception: ", "")),
          backgroundColor: Colors.redAccent,
        ),
      );
      // También aplica "shake" si la API devuelve un error
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
      // Usamos un AppBar para tener un botón de "atrás" automático
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Título con animación
                const Text(
                      "Crear Cuenta",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.5, end: 0, curve: Curves.easeOutCubic),

                const SizedBox(height: 10),

                const Text(
                      "Únete a la comunidad de GeekPlayground.",
                      style: TextStyle(color: hintColor, fontSize: 16),
                    )
                    .animate(delay: 200.ms)
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.5, end: 0, curve: Curves.easeOutCubic),

                const SizedBox(height: 40),

                // Campo de Usuario
                _buildAnimatedTextField(
                  controller: _usernameController,
                  hint: "Usuario",
                  icon: Icons.person_outline,
                  delay: 400.ms,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa un nombre de usuario';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Campo de Email
                _buildAnimatedTextField(
                  controller: _emailController,
                  hint: "Email",
                  icon: Icons.email_outlined,
                  delay: 600.ms,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        !value.contains('@') ||
                        !value.contains('.')) {
                      return 'Por favor, ingresa un email válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Campo de Contraseña
                _buildAnimatedTextField(
                  controller: _passwordController,
                  hint: "Contraseña",
                  icon: Icons.lock_outline,
                  delay: 800.ms,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.length < 4) {
                      return 'La contraseña debe tener al menos 4 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),

                // Botón de Registro
                _buildRegisterButton()
                    .animate(delay: 1000.ms)
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.5, end: 0, curve: Curves.easeOutCubic),
              ],
            ),
          ),
        ),
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
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
          controller: controller,
          obscureText: isPassword ? _obscurePassword : false,
          // obscureText: isPassword,
          keyboardType: keyboardType,
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
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: iconColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  )
                : null,
          ),
          validator: validator,
        )
        .animate(delay: delay)
        .fadeIn(duration: 600.ms)
        .slideX(begin: 0.5, end: 0, curve: Curves.easeOutCubic);
  }

  // Widget para el botón de registro con estado de carga
  Widget _buildRegisterButton() {
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
        onPressed: _isLoading ? null : _register,
        child: _isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: textColor,
                ),
              )
            : const Text(
                "Crear Cuenta",
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
