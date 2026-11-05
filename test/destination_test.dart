import 'package:flutter_test/flutter_test.dart';
import 'package:viajes_aury/models/destination.dart';

void main() {
  test('Hay destinos para mostrar en la lista', () {
    expect(destinations.length, greaterThanOrEqualTo(4));
  });
  test('Cada destino tiene imagen, precio y nombre', () {
    for (final destination in destinations) {
      expect(destination.image, isNotEmpty);
      expect(destination.price, greaterThan(0));
      expect(destination.name, isNotEmpty);
    }
  });
  test('Los precios se presentan en pesos mexicanos', () {
    expect(formatMoney(8490), '\$8,490 MXN');
  });
}
