# BookMotor

Aplikasi Flutter untuk kebutuhan booking motor. Proyek ini menggunakan konfigurasi Flutter standar dengan dependency dasar untuk UI Material dan linting.

## Prasyarat SDK

Pastikan lingkungan pengembangan sudah terpasang dengan versi yang sesuai:

- Flutter SDK yang kompatibel dengan Dart SDK `^3.10.8` pada file `pubspec.yaml`
- Dart SDK yang dibundel bersama Flutter
- Android Studio / VS Code
- Emulator Android atau simulator iOS
- Chrome untuk menjalankan versi web (opsional)

### Verifikasi instalasi

```bash
flutter --version
flutter doctor
```

Jika ada masalah pada konfigurasi SDK atau emulator, selesaikan terlebih dahulu dengan instruksi dari `flutter doctor` sebelum menjalankan aplikasi.

## Konfigurasi Flutter

1. Install Flutter SDK dari situs resmi Flutter.
2. Tambahkan path Flutter ke variabel lingkungan `PATH`.
3. Pastikan command `flutter` dapat diakses dari terminal.
4. Untuk Windows, contoh pengecekan:

```bash
where flutter
flutter --version
```

5. Jika Android belum siap:

```bash
flutter doctor --android-licenses
```

## Dependensi proyek

Dependensi utama yang terdefinisi di `pubspec.yaml` adalah:

- `flutter`: SDK utama Flutter
- `cupertino_icons`: ikon iOS-style
- `flutter_lints`: linting untuk kualitas kode
- `flutter_test`: testing framework untuk Flutter

Untuk mengunduh dan menginstal semua dependency:

```bash
flutter pub get
```

Jika ingin menambahkan dependency baru:

```bash
flutter pub add <nama_package>
```

## Menjalankan proyek secara lokal

Masuk ke folder proyek lalu jalankan perintah berikut:

```bash
cd d:\Flutter\bookmotor
flutter pub get
flutter run
```

### Menjalankan di platform tertentu

#### Web

```bash
flutter run -d chrome
```

#### Android

```bash
flutter devices
flutter run -d <device_id>
```

#### Build untuk produksi

```bash
flutter build apk
```

atau

```bash
flutter build appbundle
```

## Catatan

- Pastikan emulator/device sudah aktif sebelum menjalankan aplikasi.
- Jika terjadi error terkait SDK atau dependency, jalankan `flutter clean` lalu `flutter pub get`.
- Untuk debug lebih lanjut, gunakan:

```bash
flutter analyze
```

Selamat mengembangkan BookMotor.
