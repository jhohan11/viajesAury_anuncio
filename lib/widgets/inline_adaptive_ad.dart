import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// ANUNCIO ASIGNADO EN CLASE: BANNER ADAPTABLE INTERCALADO (INLINE ADAPTIVE).
///
/// Diferencias importantes:
/// - NO es un banner fijo en el pie de la pantalla.
/// - Va DENTRO de una lista que se desplaza con el dedo.
/// - Se adapta al ANCHO disponible y después obtiene su ALTURA real.
/// - Usamos unidades de PRUEBA oficiales; no generan ingresos.
///
/// Referencia oficial:
/// https://developers.google.com/admob/flutter/banner/inline-adaptive?hl=es-419
class InlineAdaptiveAdCard extends StatefulWidget {
  const InlineAdaptiveAdCard({super.key});

  @override
  State<InlineAdaptiveAdCard> createState() => _InlineAdaptiveAdCardState();
}

class _InlineAdaptiveAdCardState extends State<InlineAdaptiveAdCard> {
  // ID de unidad de prueba OFICIAL para banner Android. No usar IDs reales
  // durante la actividad para evitar tráfico inválido.
  static const String _androidTestUnit =
      'ca-app-pub-3940256099942544/9214589741';
  static const String _iosTestUnit =
      'ca-app-pub-3940256099942544/2435281174';

  BannerAd? _banner;
  AdSize? _realSize;
  double _lastWidth = 0;
  int _requestSerial = 0;
  bool _failed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // MediaQuery refleja cambios en orientación/tamaño del teléfono.
    // Usaremos 16 px de margen a cada lado; ese es el ancho del AdWidget.
    final width = MediaQuery.sizeOf(context).width - 32;
    if ((width - _lastWidth).abs() > 1 && width > 0) {
      _lastWidth = width;
      _loadBanner(width.floor());
    }
  }

  Future<void> _loadBanner(int width) async {
    // Ignorar resultados de peticiones anteriores tras rotación de pantalla.
    final serial = ++_requestSerial;
    final old = _banner;
    _banner = null;
    _realSize = null;
    _failed = false;
    if (old != null) await old.dispose();
    if (!mounted || serial != _requestSerial) return;

    // El plugin de anuncios solo funciona en Android e iOS.
    if (kIsWeb ||
        (defaultTargetPlatform != TargetPlatform.android &&
            defaultTargetPlatform != TargetPlatform.iOS)) {
      return;
    }

    // PASO 1: solicitar tamaño inline adaptive según ancho disponible.
    // Google decide la altura final; aquí todavía NO es la altura real.
    final adaptiveSize =
        AdSize.getCurrentOrientationInlineAdaptiveBannerAdSize(width);

    // PASO 2: crear solicitud de anuncio con unidad de pruebas.
    final ad = BannerAd(
      adUnitId: defaultTargetPlatform == TargetPlatform.android
          ? _androidTestUnit
          : _iosTestUnit,
      size: adaptiveSize,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (loadedAd) async {
          // PASO 3: obtener tamaño REAL una vez que Google carga el anuncio.
          final banner = loadedAd as BannerAd;
          final platformSize = await banner.getPlatformAdSize();
          if (!mounted || serial != _requestSerial) {
            await banner.dispose();
            return;
          }
          if (platformSize == null || platformSize.height <= 0) {
            debugPrint('AdMob: no se recibió la altura del anuncio');
            await banner.dispose();
            if (mounted) setState(() => _failed = true);
            return;
          }
          // PASO 4: actualizar contenedor al alto real. Así no se recorta.
          debugPrint('AdMob: banner inline cargado: '
              '${platformSize.width}x${platformSize.height}');
          setState(() {
            _banner = banner;
            _realSize = platformSize;
            _failed = false;
          });
        },
        onAdFailedToLoad: (failedAd, error) {
          // Fallar la carga NO debe bloquear la lista de destinos.
          debugPrint('AdMob: error al cargar banner inline: $error');
          failedAd.dispose();
          if (mounted && serial == _requestSerial) {
            setState(() {
              _banner = null;
              _realSize = null;
              _failed = true;
            });
          }
        },
      ),
    );
    // PASO 5: enviar la solicitud a AdMob.
    _banner = ad;
    await ad.load();
  }

  @override
  Widget build(BuildContext context) {
    // Este widget se coloca en el ListView ENTRE dos tarjetas de destino.
    final ad = _banner;
    final size = _realSize;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('PUBLICIDAD',
              style: TextStyle(fontSize: 10, letterSpacing: 1.3,
                  fontWeight: FontWeight.w700, color: Colors.black45)),
          const SizedBox(height: 5),
          if (ad != null && size != null)
            // AdWidget muestra el anuncio REAL proporcionado por Google,
            // nunca una imagen que simule falsamente ser un anuncio.
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: SizedBox(
                width: _lastWidth,
                height: size.height.toDouble(),
                child: AdWidget(ad: ad),
              ),
            )
          else
            Container(
              height: 76,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F3F6),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD3E7ED)),
              ),
              child: Text(
                _failed
                    ? 'No se pudo cargar el anuncio de prueba'
                    : 'Cargando anuncio de prueba…',
                style: const TextStyle(color: Color(0xFF52747E), fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    ++_requestSerial;
    _banner?.dispose(); // Liberar recursos para evitar fugas de memoria.
    super.dispose();
  }
}
