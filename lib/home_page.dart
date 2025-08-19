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
        title: Text('Lo-Geeks', style: TextStyle(color: Color(0xFF84525F))),
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFFFFFCED),
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
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                onItemTap(0);
              },
            ),

            ListTile(
              leading: Icon(Icons.book),
              title: Text("Library"),
              onTap: () {
                navigateTo(context, const Library());
              },
            ),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                navigateTo(context, const Settings());
              },
            ),

            ListTile(
              leading: Icon(Icons.description),
              title: Text("Terms and conditions"),
              onTap: () {
                navigateTo(context, const Terms_conditions());
              },
            ),

            ListTile(
              leading: Icon(Icons.help),
              title: Text("Help"),
              onTap: () {
                navigateTo(context, const Help());
              },
            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log out"),
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
          // Imagen de fondo con 30% transparencia
          Opacity(
            opacity: 0.3, // 30% visible
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
        currentIndex: selectIndex,
        onTap: onItemTap,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.games), label: 'Games'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
