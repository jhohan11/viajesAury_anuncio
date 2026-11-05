# Configura la estructura nativa Android y el ID de app AdMob de PRUEBA.
# Ejecutar en PowerShell dentro de la carpeta ViajesAury.
$ErrorActionPreference = "Stop"
if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
  throw "No se encontró Flutter en PATH. Ejecuta 'flutter doctor' y configura Flutter primero."
}
Write-Host "[1/4] Generando estructura oficial Android de Flutter..." -ForegroundColor Cyan
flutter create --project-name viajes_aury --platforms android .
if ($LASTEXITCODE -ne 0) { throw "flutter create falló." }

Write-Host "[2/4] Configurando AndroidManifest.xml con AdMob de prueba..." -ForegroundColor Cyan
$manifest = Join-Path $PWD 'android\app\src\main\AndroidManifest.xml'
$content = Get-Content -Raw -Encoding UTF8 $manifest
if ($content -notmatch 'com.google.android.gms.ads.APPLICATION_ID') {
  $meta = @'
        <!-- Identificador oficial de la APP DE PRUEBA de AdMob. NO es el ID de la unidad banner. -->
        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="ca-app-pub-3940256099942544~3347511713" />
'@
  $content = [regex]::Replace($content, '(<application\b[^>]*>)', ('$1' + "`r`n" + $meta), 1)
}
if ($content -notmatch 'android.permission.INTERNET') {
  $content = [regex]::Replace($content, '(<manifest\b[^>]*>)', ('$1' + "`r`n    <uses-permission android:name=`"android.permission.INTERNET`" />"), 1)
}
Set-Content -Path $manifest -Value $content -Encoding UTF8

Write-Host "[3/4] Descargando dependencias..." -ForegroundColor Cyan
flutter pub get
if ($LASTEXITCODE -ne 0) { throw "flutter pub get falló." }
Write-Host "[4/4] Preparado. Ejecuta flutter run -d <ID_ANDROID>." -ForegroundColor Green
