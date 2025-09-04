import 'package:flutter/material.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  final List<String> allBooks = ["Lógica Proposicional", "Álgebra Lineal"];

  // Lista filtrada
  List<String> filteredBooks = [];

  @override
  void initState() {
    super.initState();
    filteredBooks = List.from(allBooks);
  }

  void filterBooks(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredBooks = List.from(allBooks);
      } else {
        filteredBooks = allBooks
            .where((book) => book.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void addBook(String title) {
    setState(() {
      allBooks.add(title);
      filteredBooks = List.from(allBooks);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 40),
        child: FloatingActionButton(
          backgroundColor: Color(0xFF4E272F),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                final TextEditingController controller =
                    TextEditingController();
                return AlertDialog(
                  backgroundColor: const Color(0xFF1E2A32),
                  title: const Text(
                    "Nuevo Libro",
                    style: TextStyle(color: Colors.white),
                  ),
                  content: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Escribe el nombre del libro",
                      hintStyle: TextStyle(color: Colors.white54),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white38),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),

                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          addBook(controller.text);
                        }
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Agregar",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),

      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFF141F25),
          ),

          // Contenido principal
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Buscador
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      onChanged: filterBooks,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        hintText: "Buscar...",
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search, color: Colors.black54),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 3 / 4,
                          ),
                      itemCount: filteredBooks.length,
                      itemBuilder: (context, index) {
                        return _bookCard(filteredBooks[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookCard(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.pink[200],
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
