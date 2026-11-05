import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'screens/about_screen.dart';
import 'screens/destinations_screen.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // INICIO DE ADMOB: el SDK se inicializa ANTES de solicitar cualquier anuncio.
  // Solo Android/iOS: Google Mobile Ads NO funciona en web/escritorio.
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
       defaultTargetPlatform == TargetPlatform.iOS)) {
    await MobileAds.instance.initialize();
  }

  runApp(const ViajesAuryApp());
}

class ViajesAuryApp extends StatelessWidget {
  const ViajesAuryApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'ViajesAury',
    theme: buildTheme(),
    debugShowCheckedModeBanner: false,
    home: const AppShell(),
  );
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  bool _showSplash = true;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return SplashScreen(onComplete: () => setState(() => _showSplash = false));
    }
    final tabs = [
      HomeScreen(onExplore: () => setState(() => _index = 1),
        onAbout: () => setState(() => _index = 2)),
      const DestinationsScreen(),
      const AboutScreen(),
    ];
    return Scaffold(
      body: IndexedStack(index: _index, children: tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore), label: 'Destinos'),
          NavigationDestination(icon: Icon(Icons.info_outline),
              selectedIcon: Icon(Icons.info), label: 'Información'),
        ],
      ),
    );
  }
}
