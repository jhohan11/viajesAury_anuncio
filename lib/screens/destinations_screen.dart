import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../theme.dart';
import '../widgets/destination_card.dart';
import '../widgets/inline_adaptive_ad.dart';

class DestinationsScreen extends StatefulWidget {
  const DestinationsScreen({super.key});

  @override
  State<DestinationsScreen> createState() => _DestinationsScreenState();
}

class _DestinationsScreenState extends State<DestinationsScreen> {
  String _search = '';

  void _showDetails(Destination destination) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 2, 22, 30),
          child: Column(mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(18),
                child: Image.asset(destination.image,
                    width: double.infinity, height: 185, fit: BoxFit.cover)),
              const SizedBox(height: 15),
              Text(destination.name,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              Text(destination.description),
              const SizedBox(height: 12),
              Wrap(spacing: 6, runSpacing: 6,
                  children: destination.tags.map((tag) => Chip(label: Text(tag))).toList()),
              const SizedBox(height: 10),
              Text('Desde ${formatMoney(destination.price)}',
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: coral)),
              const SizedBox(height: 13),
              SizedBox(width: double.infinity, child: FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(this.context).showSnackBar(const SnackBar(
                    content: Text('Demostración: aún no se realizan reservas reales.'),
                  ));
                },
                child: const Text('Consultar paquete'),
              )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = destinations.where((d) =>
      d.name.toLowerCase().contains(_search.toLowerCase()) ||
      d.country.toLowerCase().contains(_search.toLowerCase())).toList();
    // El banner se coloca después del segundo destino, dentro del listado.
    final showAd = filtered.length >= 2;
    return Scaffold(
      appBar: AppBar(title: const Text('Destinos y paquetes',
          style: TextStyle(fontWeight: FontWeight.w800))),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 13, 16, 7),
          child: TextField(
            onChanged: (value) => setState(() => _search = value),
            decoration: const InputDecoration(
              hintText: 'Buscar destino o país',
              prefixIcon: Icon(Icons.search, color: deepOcean),
            ),
          ),
        ),
        Expanded(child: ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          // +1 representa una posición REAL de anuncio entre los destinos.
          itemCount: filtered.length + (showAd ? 1 : 0),
          itemBuilder: (context, index) {
            if (showAd && index == 2) {
              return const InlineAdaptiveAdCard(key: ValueKey('banner-inline'));
            }
            final destinationIndex = showAd && index > 2 ? index - 1 : index;
            final item = filtered[destinationIndex];
            return DestinationCard(
              key: ValueKey(item.name),
              destination: item,
              onTap: () => _showDetails(item),
            );
          },
        )),
      ]),
    );
  }
}
