// home_page.dart
import 'package:app_prueba_flutter/VISTA/help.dart';
import 'package:app_prueba_flutter/VISTA/library.dart';
import 'package:app_prueba_flutter/VISTA/option.dart';
import 'package:app_prueba_flutter/VISTA/profile.dart';
import 'package:app_prueba_flutter/VISTA/settings.dart';
import 'package:app_prueba_flutter/VISTA/terms_condition.dart';
import 'package:flutter/material.dart';
import 'games_home_page.dart';
import 'package:app_prueba_flutter/VISTA/subir_archivo.dart';

class HomePage extends StatefulWidget {
  final String nombreUsuario;
  const HomePage({super.key, required this.nombreUsuario});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late final List<Widget> _screens;
  final PageStorageBucket _bucket = PageStorageBucket();

  static const _bg = Color(0xFF0F1620);
  static const _surface = Color(0xFF141F25);
  static const _primary = Color(0xFFFF5C8D);
  static const _secondary = Color(0xFF97A5EC);
  static const _onSurface = Colors.white;

  @override
  void initState() {
    super.initState();
    _screens = [
      const GamesHome(key: PageStorageKey('games')),
      const Library(key: PageStorageKey('library')),
      Profile(
        key: PageStorageKey('profile'),
        nombreUsuario: widget.nombreUsuario,
      ),
    ];
  }

  void _onTap(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: _bg,
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: _surface,
          indicatorColor: _primary.withOpacity(0.18),
          elevation: 12,
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          iconTheme: WidgetStateProperty.all(const IconThemeData(size: 26)),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: _secondary),
          titleTextStyle: TextStyle(
            color: _secondary,
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
      ),
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(title: const Text('LoGeeks')),
        drawer: _buildDrawer(context),
        body: Stack(
          children: [
            // Fondo decorativo
            Positioned(
              left: -80,
              top: -40,
              child: _GlowCircle(
                color: _secondary.withOpacity(0.18),
                size: 220,
              ),
            ),
            Positioned(
              right: -60,
              bottom: -20,
              child: _GlowCircle(color: _primary.withOpacity(0.14), size: 180),
            ),
            PageStorage(
              bucket: _bucket,
              child: IndexedStack(index: _selectedIndex, children: _screens),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            child: NavigationBar(
              height: 66,
              backgroundColor: const Color(
                0xFF1E2537,
              ), // Fondo más claro que el Scaffold
              indicatorColor: const Color(
                0xFFFF5C8D,
              ).withOpacity(0.15), // Rosa suave al seleccionar
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onTap,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined, color: Color(0xFF97A5EC)),
                  selectedIcon: Icon(
                    Icons.home_rounded,
                    color: Color(0xFFFF5C8D),
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.menu_book_outlined,
                    color: Color(0xFF97A5EC),
                  ),
                  selectedIcon: Icon(
                    Icons.menu_book_rounded,
                    color: Color(0xFFFF5C8D),
                  ),
                  label: 'Library',
                ),
                //NavigationDestination(
                //  icon: Icon(Icons.folder_open_outlined, color: _secondary),
                //  selectedIcon: Icon(Icons.folder_rounded, color: _primary),
                //  label: 'Archivo',
                //),
                NavigationDestination(
                  icon: Icon(
                    Icons.person_outline_rounded,
                    color: Color(0xFF97A5EC),
                  ),
                  selectedIcon: Icon(
                    Icons.person_rounded,
                    color: Color(0xFFFF5C8D),
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: _surface,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFF2A2F45), Color(0xFF363C54)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                image: const DecorationImage(
                  image: AssetImage('assets/images/drawer.png'),
                  fit: BoxFit.cover,
                  opacity: 0.15,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0x33FFFFFF),
                    child: Icon(
                      Icons.sports_esports_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Hola, ${widget.nombreUsuario}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _onSurface,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _DrawerItem(
              icon: Icons.home_rounded,
              label: 'Home',
              onTap: () {
                Navigator.pop(context);
                _onTap(0);
              },
            ),
            _DrawerItem(
              icon: Icons.description_rounded,
              label: 'Términos y condiciones',
              onTap: () => _navigateTo(context, const Terms_conditions()),
            ),
            _DrawerItem(
              icon: Icons.help_center_rounded,
              label: 'Ayuda',
              onTap: () => _navigateTo(context, const Help()),
            ),
            const Divider(height: 24, color: Color(0x22FFFFFF)),
            _DrawerItem(
              icon: Icons.settings_rounded,
              label: 'Ajustes',
              onTap: () => _navigateTo(context, const Settings()),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0x22FFFFFF),
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _navigateTo(context, const Option()),
                icon: const Icon(Icons.logout_rounded),
                label: const Text(
                  'Cerrar sesión',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/// Fondo de círculos difusos
class _GlowCircle extends StatelessWidget {
  final Color color;
  final double size;
  const _GlowCircle({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: size * 0.6,
              spreadRadius: size * 0.25,
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: onTap,
    );
  }
}
