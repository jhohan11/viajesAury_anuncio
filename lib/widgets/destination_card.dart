import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../theme.dart';

class DestinationCard extends StatelessWidget {
  const DestinationCard({super.key, required this.destination, required this.onTap});
  final Destination destination;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(destination.image, width: 114, height: 116,
                  fit: BoxFit.cover),
            ),
            const SizedBox(width: 13),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(destination.name,
                    style: const TextStyle(fontSize: 19, color: ink, fontWeight: FontWeight.w800)),
                const SizedBox(height: 3),
                Text(destination.country, style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 7),
                Row(children: [
                  const Icon(Icons.calendar_month_outlined, size: 15, color: deepOcean),
                  const SizedBox(width: 4),
                  Text('${destination.days} días · ${destination.days - 1} noches',
                      style: const TextStyle(fontSize: 12)),
                ]),
                const SizedBox(height: 5),
                const Row(children: [
                  Icon(Icons.flight_takeoff, size: 15, color: deepOcean),
                  SizedBox(width: 4),
                  Text('Paquete turístico', style: TextStyle(fontSize: 12)),
                ]),
                const SizedBox(height: 6),
                Text(formatMoney(destination.price),
                    style: const TextStyle(fontSize: 16, color: coral, fontWeight: FontWeight.w900)),
              ],
            )),
            const Icon(Icons.chevron_right, color: deepOcean),
          ]),
        ),
      ),
    );
  }
}
