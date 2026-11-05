import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onExplore, required this.onAbout});
  final VoidCallback onExplore;
  final VoidCallback onAbout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(children: [
          Icon(Icons.flight_takeoff, color: coral, size: 29),
          SizedBox(width: 8),
          Text('Viajes', style: TextStyle(color: deepOcean, fontWeight: FontWeight.w900)),
          Text('Aury', style: TextStyle(color: coral, fontWeight: FontWeight.w900)),
        ]),
        actions: [
          IconButton(tooltip: 'Información', onPressed: onAbout,
              icon: const Icon(Icons.info_outline)),
        ],
      ),
      body: ListView(padding: const EdgeInsets.only(bottom: 20), children: [
        Stack(children: [
          Image.asset('assets/images/hero.png',
              height: 238, width: double.infinity, fit: BoxFit.cover),
          Container(
            height: 238,
            decoration: const BoxDecoration(gradient: LinearGradient(
                begin: Alignment.centerLeft, end: Alignment.centerRight,
                colors: [Color(0xC4005367), Color(0x10005367)])),
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 26),
            alignment: Alignment.centerLeft,
            child: const SizedBox(width: 225, child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('¡Hola, viajero!', style: TextStyle(
                    fontSize: 29, color: Colors.white, fontWeight: FontWeight.w900)),
                SizedBox(height: 8),
                Text('Descubre nuevos lugares. Vive historias inolvidables.',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              ],
            )),
          ),
        ]),
        const Padding(
          padding: EdgeInsets.fromLTRB(18, 22, 18, 13),
          child: Text('¿Qué quieres explorar?', style: TextStyle(
              fontSize: 21, color: ink, fontWeight: FontWeight.w900)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.count(
            crossAxisCount: 2, shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 11, crossAxisSpacing: 11, childAspectRatio: 1.8,
            children: [
              _QuickTile('Destinos', Icons.beach_access, ocean, onExplore),
              _QuickTile('Promociones', Icons.local_offer, coral, onExplore),
              _QuickTile('Paquetes', Icons.luggage, deepOcean, onExplore),
              _QuickTile('Nosotros', Icons.public, const Color(0xFFEA970A), onAbout),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.fromLTRB(18, 25, 18, 12),
          child: Text('Destino destacado', style: TextStyle(
              fontSize: 21, color: ink, fontWeight: FontWeight.w900))),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(clipBehavior: Clip.antiAlias,
            child: Stack(children: [
              Image.asset('assets/images/cancun.png', height: 210,
                  width: double.infinity, fit: BoxFit.cover),
              Container(height: 210,
                decoration: const BoxDecoration(gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xB9003640)])),
                padding: const EdgeInsets.all(17),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end, children: [
                    const Text('CANCÚN', style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w900, fontSize: 25)),
                    const Text('Sol, playa y mucho más',
                        style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 7),
                    Align(alignment: Alignment.centerLeft,
                      child: FilledButton.icon(onPressed: onExplore,
                          style: FilledButton.styleFrom(backgroundColor: coral),
                          icon: const Icon(Icons.arrow_forward, size: 17),
                          label: const Text('Ver paquetes'))),
                  ]),
              ),
            ]),
          )),
        Padding(padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
            child: Text('Paquetes desde ${formatMoney(destinations.first.price)}',
                style: const TextStyle(color: deepOcean, fontWeight: FontWeight.w700))),
      ]),
    );
  }
}

class _QuickTile extends StatelessWidget {
  const _QuickTile(this.label, this.icon, this.color, this.onTap);
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    child: InkWell(onTap: onTap, child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 27),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w800, color: ink)),
      ],
    )),
  );
}
