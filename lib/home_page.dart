import 'package:app_prueba_flutter/help.dart';
import 'package:app_prueba_flutter/library.dart';
import 'package:app_prueba_flutter/settings.dart';
import 'package:app_prueba_flutter/terms_condition.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectIndex = 0;

  final List<Widget> screens = const [];

  void onItemTap(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  void navigateTo(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nombre de la App',
          style: TextStyle(color: Color(0xFF97A5EC)),
        ),
        backgroundColor: Color(0xFF141F25),
        iconTheme: IconThemeData(color: Color(0xFF97A5EC)),
      ),

      drawer: Drawer(
        backgroundColor: Color(0xFF363C54),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/drawer.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: null,
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onTap: () {
                Navigator.pop(context);
                onItemTap(0);
              },
            ),

            ListTile(
              leading: const Icon(Icons.description, color: Colors.white),
              title: Text(
                "Terms and conditions",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onTap: () {
                navigateTo(context, const Terms_conditions());
              },
            ),

            ListTile(
              leading: const Icon(Icons.help, color: Colors.white),
              title: Text(
                "Help",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onTap: () {
                navigateTo(context, const Help());
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: Text(
                "Log out",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onTap: () {
                Navigator.pop(context);
                onItemTap(2);
              },
            ),
          ],
        ),
      ),

      body: Stack(
        children: [
          Container(color: Color(0xFF141F25)),

          Opacity(
            opacity: 0.1,
            child: Image.asset(
              "assets/images/background.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF141F25),
        currentIndex: selectIndex,
        onTap: onItemTap,
        selectedItemColor: const Color(
          0xFFFF5C8D,
        ), // color de icono y label seleccionado
        unselectedItemColor: const Color(
          0xFF97A5EC,
        ), // color de icono y label NO seleccionado
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
