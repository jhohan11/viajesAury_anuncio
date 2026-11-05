# ViajesAury · Flutter + Google AdMob

Demo académica Android de una agencia de viajes ficticia. Incluye **4 pantallas** (splash animado, dashboard, lista de destinos con publicidad intercalada e información), navegación, tarjetas con ilustraciones locales, búsqueda, detalle de paquetes y banner adaptable **inline** de prueba.

## Requisitos

- Windows con Flutter 3.47.9 o superior compatible con Dart >=3.10, Android Studio y Android SDK configurados.
- Dispositivo Android o emulador y conexión a Internet para que Google descargue anuncios de prueba.
- Visual Studio Code (extensiones Flutter y Dart) o Android Studio.

## Inicio rápido (Windows PowerShell)

Descomprime el ZIP, abre la carpeta `ViajesAury` en VS Code y ejecuta:

```powershell
flutter doctor
Set-ExecutionPolicy -Scope Process Bypass
.\configurar_android.ps1
flutter devices
flutter run
```

El script ejecuta `flutter create --platforms android .` para generar la estructura Android oficial necesaria (este entorno no dispone del SDK Flutter para incluirla ya generada), configura el identificador de aplicación AdMob de prueba en `AndroidManifest.xml` y descarga dependencias. El código Dart y las imágenes **ya están completos**.

Si prefieres hacerlo manualmente:

```powershell
flutter create --project-name viajes_aury --platforms android .
```

Luego agrega DENTRO del elemento `<application>` de `android/app/src/main/AndroidManifest.xml`:

```xml
<meta-data android:name="com.google.android.gms.ads.APPLICATION_ID"
           android:value="ca-app-pub-3940256099942544~3347511713" />
```

Y agrega DENTRO del elemento `<manifest>`, pero FUERA de `<application>`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

Ejecuta `flutter pub get` y `flutter run`.

## Dónde está la integración del anuncio

- `lib/main.dart`: inicializa `MobileAds.instance.initialize()`.
- `lib/widgets/inline_adaptive_ad.dart`: **implementación comentada paso a paso**. Usa `AdSize.getCurrentOrientationInlineAdaptiveBannerAdSize`, `BannerAd`, `BannerAdListener`, `getPlatformAdSize()`, `AdWidget` y `dispose()`.
- `lib/screens/destinations_screen.dart`: agrega el widget después del segundo destino en `ListView.builder` y permite desplazarlo con el resto de las tarjetas.
- `android/app/src/main/AndroidManifest.xml`: identificador de aplicación de prueba insertado por el script.

**Unidad de anuncio de prueba Android:** `ca-app-pub-3940256099942544/9214589741`.
**ID de aplicación de prueba:** `ca-app-pub-3940256099942544~3347511713`.
No son lo mismo: el que contiene `/` es de unidad; el que contiene `~` identifica la aplicación.

El anuncio es proporcionado por Google en tiempo real, NO un banner falso dibujado. Si falla la red, se muestra un mensaje y el listado permanece funcional. Ninguno de los paquetes realiza reservas reales ni pagos. Los precios y las descripciones son ficticios.

## Comprobación

```powershell
flutter analyze
flutter test
flutter run
```

Se recomienda probar en Android 10 o superior. No ejecutes la demo para verificar anuncios en Chrome, Windows ni Linux: el plugin AdMob no funciona en esas plataformas.

## Commits para la práctica

```powershell
git init
git add .
git commit -m "chore: crear app Flutter ViajesAury"
# Después de verificar o modificar la integración de la publicidad:
git add .
git commit -m "feat: integrar banner adaptable inline de AdMob"
```

En una aplicación real hay que configurar consentimiento y privacidad según el contexto geográfico y la publicación. No reemplaces los IDs de prueba por reales hasta estar listo para cumplir con las políticas de AdMob.

## Referencias
- https://developers.google.com/admob/flutter/quick-start?hl=es-419
- https://developers.google.com/admob/flutter/banner/inline-adaptive?hl=es-419
- https://developers.google.com/admob/android/test-ads?hl=es-419
