import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      "http://172.16.72.235/api"; //Para usar en android cambiar localhost por 10.0.2.2, nose si cambia para IOS

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/index.php?resource=login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(errorBody['message'] ?? 'Error de autenticación');
    }
  }

  Future<Map<String, dynamic>> register(
    String username,
    String email,
    String password,
  ) async {
    final response = await http.post(
      // Apunta al endpoint 'usuario' con el metodo POST
      Uri.parse('$baseUrl/index.php?resource=usuario'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return responseBody;
    } else {
      // Lanza una excepción con el mensaje de error de la API
      throw Exception(
        responseBody['message'] ?? 'Error al registrar el usuario.',
      );
    }
  }
}
