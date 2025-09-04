import 'package:flutter/material.dart';
import 'api_service.dart';

class Game1 extends StatefulWidget {
  const Game1({super.key});

  @override
  State<Game1> createState() => _Game1State();
}

class _Game1State extends State<Game1> {
  List<Map<String, dynamic>> _questions = [];
  bool _loading = true;
  final ApiService _apiService = ApiService();

  int _current = 0;
  int _selected = -1;
  bool _answered = false;
  bool _isCorrect = false;
  int _hearts = 3;
  int _xp = 0;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      final qs = await _apiService.fetchQuestions("logic");
      // Reordenar opciones para cada pregunta
      for (var q in qs) {
        final options = [
          q["option1"],
          q["option2"],
          q["option3"],
          q["option4"],
        ];

        final correctIndex = q["correctIndex"] as int;
        final correctAnswer = options[correctIndex];

        // Mezclar opciones
        options.shuffle();

        // Actualizar pregunta con nuevo orden
        q["option1"] = options[0];
        q["option2"] = options[1];
        q["option3"] = options[2];
        q["option4"] = options[3];
        q["correctIndex"] = options.indexOf(correctAnswer);
      }
      setState(() {
        _questions = qs;
        _loading = false;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  void _onSelect(int index) {
    if (_answered) return;
    setState(() => _selected = index);
  }

  void _onCheck() {
    if (_selected == -1) return;
    final correct = _questions[_current]["correctIndex"] as int;
    setState(() {
      _answered = true;
      _isCorrect = _selected == correct;
      if (_isCorrect) {
        _xp += 10;
      } else {
        _hearts = (_hearts > 0) ? _hearts - 1 : 0;
      }
    });
  }

  void _onContinue() {
    if (_current < _questions.length - 1 && _hearts > 0) {
      setState(() {
        _current++;
        _selected = -1;
        _answered = false;
        _isCorrect = false;
      });
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Text('Lección terminada'),
          content: Text('XP ganado: $_xp\nCorazones restantes: $_hearts'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _current = 0;
                  _selected = -1;
                  _answered = false;
                  _isCorrect = false;
                  _hearts = 3;
                  _xp = 0;
                });
              },
              child: const Text('Reiniciar'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final q = _questions[_current];
    final options = [q["option1"], q["option2"], q["option3"], q["option4"]];
    final correct = q["correctIndex"] as int;
    final progress = (_current + 1) / _questions.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text('Lógica Proposicional'),
        centerTitle: true,
        actions: [
          Row(
            children: [
              const Icon(Icons.flash_on),
              const SizedBox(width: 4),
              Text('$_xp'),
              const SizedBox(width: 12),
              const Icon(Icons.favorite, color: Colors.red),
              const SizedBox(width: 4),
              Text('$_hearts'),
              const SizedBox(width: 12),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: LinearProgressIndicator(value: progress),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                q["prompt"] as String,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              ...List.generate(options.length, (i) {
                final isSelected = _selected == i;
                Color borderColor = Colors.grey.shade300;
                if (_answered) {
                  if (i == correct) {
                    borderColor = Colors.green;
                  } else if (isSelected && i != correct) {
                    borderColor = Colors.red;
                  }
                } else if (isSelected) {
                  borderColor = Colors.blue;
                }

                return GestureDetector(
                  onTap: () => _onSelect(i),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor, width: 2),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Text(
                      options[i],
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                );
              }),
              const Spacer(),
              ElevatedButton(
                onPressed: _answered ? _onContinue : _onCheck,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: _answered
                      ? (_isCorrect ? Colors.green : Colors.red)
                      : Colors.blue,
                ),
                child: Text(
                  _answered ? 'Continuar' : 'Comprobar',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
