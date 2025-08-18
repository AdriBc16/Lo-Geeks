import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectIndex = 0;

  //final List<Widget> screens = [Home(),Games(),Profile()];

  void onItemTap(int index) {
    setState(() {
      selectIndex = index;
    });
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
                Navigator.pop(context);
                onItemTap(0);
              },
            ),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                onItemTap(1);
              },
            ),

            ListTile(
              leading: Icon(Icons.description),
              title: Text("Terms and conditions"),
              onTap: () {
                Navigator.pop(context);
                onItemTap(2);
              },
            ),

            ListTile(
              leading: Icon(Icons.help),
              title: Text("Help"),
              onTap: () {
                Navigator.pop(context);
                onItemTap(2);
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
