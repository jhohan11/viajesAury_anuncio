import 'package:flutter/material.dart';
import '../theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Información',
      style: TextStyle(fontWeight: FontWeight.w800))),
    body: ListView(padding: const EdgeInsets.only(bottom: 25), children: [
      Image.asset('assets/images/santorini.png',
        height: 205, width: double.infinity, fit: BoxFit.cover),
      Padding(padding: const EdgeInsets.fromLTRB(18, 18, 18, 10), child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Row(children: [
            Icon(Icons.flight_takeoff, color: coral, size: 32),
            SizedBox(width: 10),
            Text('Viajes', style: TextStyle(fontSize: 29,
                color: deepOcean, fontWeight: FontWeight.w900)),
            Text('Aury', style: TextStyle(fontSize: 29,
                color: coral, fontWeight: FontWeight.w900)),
          ]),
          const SizedBox(height: 9),
          const Text('Tu agencia de viajes en la palma de tu mano.',
              style: TextStyle(fontSize: 16, color: ink)),
          const SizedBox(height: 10),
          const Text('ViajesAury es una agencia ficticia creada para una '
              'demostración académica de Flutter y Google AdMob. '
              'Explora destinos, descubre paquetes y conoce cómo '
              'se integra publicidad dentro del contenido.'),
          const SizedBox(height: 16),
          const _InfoCard(Icons.track_changes, 'Misión',
            'Inspirar a las personas a descubrir el mundo mediante '
            'experiencias claras, accesibles y memorables.'),
          const _InfoCard(Icons.visibility_outlined, 'Visión',
            'Ser una referencia en experiencias de viaje digitales, '
            'destacando por usabilidad, confianza e innovación.'),
          const _InfoCard(Icons.favorite_outline, 'Valores',
            'Servicio, transparencia, respeto, responsabilidad e innovación.'),
          const _InfoCard(Icons.campaign_outlined, 'Sobre el anuncio',
            'En la lista de destinos se usa un banner adaptable intercalado '
            'que forma parte del desplazamiento vertical. '
            'La publicidad es una unidad oficial de prueba de Google AdMob.'),
          const SizedBox(height: 14),
          const Text('Nota: precios e itinerarios son ejemplos de demostración.',
              style: TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      )),
    ]),
  );
}

class _InfoCard extends StatelessWidget {
  const _InfoCard(this.icon, this.title, this.description);
  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 11),
    child: Padding(padding: const EdgeInsets.all(15), child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(backgroundColor: const Color(0xFFE3F5F4),
            child: Icon(icon, color: deepOcean)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 17,
                fontWeight: FontWeight.w800, color: ink)),
            const SizedBox(height: 5),
            Text(description),
          ],
        )),
      ],
    )),
  );
}
