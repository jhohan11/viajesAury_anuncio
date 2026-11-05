/// Datos locales para la demostración. No realiza reservas ni pagos reales.
class Destination {
  const Destination({
    required this.name,
    required this.country,
    required this.image,
    required this.days,
    required this.price,
    required this.description,
    required this.tags,
  });

  final String name;
  final String country;
  final String image;
  final int days;
  final int price;
  final String description;
  final List<String> tags;
}

const destinations = <Destination>[
  Destination(
    name: 'Cancún', country: 'México', image: 'assets/images/cancun.png',
    days: 4, price: 8490,
    description: 'Mar turquesa, arena blanca y días de descanso frente al Caribe.',
    tags: ['Vuelo incluido', 'Hotel', 'Playa'],
  ),
  Destination(
    name: 'París', country: 'Francia', image: 'assets/images/paris.png',
    days: 6, price: 24990,
    description: 'Una aventura cultural entre monumentos, museos y cafés.',
    tags: ['Vuelo incluido', 'Hotel', 'Cultura'],
  ),
  Destination(
    name: 'Chiapas', country: 'México', image: 'assets/images/chiapas.png',
    days: 5, price: 7890,
    description: 'Cascadas, naturaleza y paisajes espectaculares.',
    tags: ['Hotel', 'Tours', 'Naturaleza'],
  ),
  Destination(
    name: 'Nueva York', country: 'Estados Unidos', image: 'assets/images/new_york.png',
    days: 5, price: 19990,
    description: 'Descubre la energía de la ciudad que nunca duerme.',
    tags: ['Vuelo incluido', 'Hotel', 'Ciudad'],
  ),
  Destination(
    name: 'Santorini', country: 'Grecia', image: 'assets/images/santorini.png',
    days: 7, price: 32990,
    description: 'Atardeceres únicos y arquitectura junto al mar Egeo.',
    tags: ['Vuelo incluido', 'Hotel', 'Romance'],
  ),
];

String formatMoney(int amount) => '\$${amount.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',')} MXN';
