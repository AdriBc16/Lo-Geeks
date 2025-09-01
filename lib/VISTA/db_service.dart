import 'dart:convert';
import 'package:http/http.dart' as http;

class DBService {
  static const String _baseUrl = "http://localhost/api";

  static Future<List<Map<String, dynamic>>> fetchQuestions(String tipo) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/endpoints/questions.php?type=$tipo"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((q) {
        return {
          "id": int.tryParse(q["id"].toString()) ?? 0,
          "prompt": q["prompt"] ?? "",
          "option1": q["option1"] ?? "",
          "option2": q["option2"] ?? "",
          "option3": q["option3"] ?? "",
          "option4": q["option4"] ?? "",
          "correctIndex": int.tryParse(q["correctIndex"].toString()) ?? 0,
        };
      }).toList();
    } else {
      print("Error fetchQuestions: ${response.statusCode} ${response.body}");
      throw Exception("Error al cargar preguntas");
    }
  }

  static Future<String> getExplanation({
    required String prompt,
    required String selectedOption,
    required String correctOption,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/endpoints/explain.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "prompt": prompt,
          "selectedOption": selectedOption,
          "correctOption": correctOption,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["explanation"] ?? "No hay explicación disponible.";
      } else {
        print("Error getExplanation: ${response.statusCode} ${response.body}");
        return "Error al generar explicación.";
      }
    } catch (e) {
      print("Exception getExplanation: $e");
      return "Error al generar explicación: $e";
    }
  }
}
