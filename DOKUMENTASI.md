# Dokumentasi Aplikasi BookMotor

## 1. Tentang Aplikasi

BookMotor adalah aplikasi Flutter yang dirancang untuk membantu pengguna melakukan proses booking layanan servis atau perawatan motor secara digital. Aplikasi ini meniru alur booking bengkel mulai dari memilih motor, menentukan layanan, memilih cabang, menjadwalkan servis, hingga proses review dan pembayaran.

Aplikasi ini dibuat sebagai prototype UI/flow booking service untuk kendaraan bermotor, dengan fokus pada pengalaman pengguna yang sederhana, cepat, dan mudah dipahami.

## 2. Tujuan Aplikasi

Tujuan utama dari BookMotor adalah:

- Memudahkan pengguna memilih motor yang akan diservis.
- Menyediakan daftar layanan servis yang tersedia.
- Mengizinkan pelanggan memilih suku cadang tambahan atau kebutuhan perbaikan.
- Memfasilitasi pemilihan cabang dan jadwal servis.
- Menyediakan ringkasan biaya, metode pembayaran, dan invoice.
- Memberikan pengalaman review dan rating setelah servis selesai.

## 3. Fitur Utama

### a. Pemilihan kendaraan
Pengguna dapat memilih motor dari daftar yang tersedia, seperti Honda Vario, BeAT, dan CB150R. Setiap motor memiliki atribut seperti:

- nama motor
- nomor plat
- kilometer saat ini
- status pemilihan
- daftar layanan yang diinginkan

### b. Pengaturan servis
Setiap motor dapat dikonfigurasi untuk menentukan:

- jenis layanan (misalnya Servis Rutin, Ganti Oli, Servis CVT, Rem, Kelistrikan)
- kebutuhan suku cadang tambahan
- mode penggantian komponen, seperti di bengkel atau tidak
- keluhan yang dialami pengguna

### c. Pemilihan cabang dan jadwal
Pada tahap selanjutnya, pengguna memilih cabang bengkel dan menentukan jadwal. Informasi tanggal, jam, dan mode kerja juga dapat diatur sesuai kebutuhan.

### d. Ringkasan biaya dan invoice
Aplikasi menghitung total biaya berdasarkan:

- layanan yang dipilih
- suku cadang tambahan
- biaya tambahan jika ada rekomendasi teknisi
- voucher yang berlaku
- pajak final

Hasilnya ditampilkan dalam bentuk invoice yang siap dibayar.

### e. Pembayaran
Pengguna dapat memilih metode pembayaran seperti QRIS. Proses pembayaran memiliki status yang menunjukkan apakah transaksi sudah selesai atau belum.

### f. Review dan rating
Setelah pembayaran dilakukan, pengguna dapat memberikan:

- rating layanan
- tag ulasan
- komentar review
- evaluasi performa teknisi

## 4. Alur Penggunaan Aplikasi

Secara umum, alur umum aplikasi adalah:

1. Pengguna membuka aplikasi.
2. Memilih motor yang akan diservis.
3. Melengkapi kebutuhan servis dan keluhan.
4. Menentukan cabang bengkel.
5. Menentukan jadwal dan waktu kunjungan.
6. Melihat ringkasan invoice.
7. Melakukan pembayaran.
8. Memberikan review dan rating setelah servis.

## 5. Struktur Data Utama

### Model `Bike`
Model `Bike` menyimpan informasi penting untuk setiap kendaraan, seperti:

- nama motor
- nomor plat
- kilometer
- layanan yang dipilih
- suku cadang yang dipilih
- status konfigurasi
- harga jasa dan bagian

Struktur ini penting karena seluruh alur booking dan perhitungan total biaya bergantung pada data ini.

## 6. Teknologi yang Digunakan

- Flutter
- Dart
- Material 3
- Widget `Scaffold`, `ThemeData`, `SnackBar`, dan komponen Material lainnya

## 7. Cara Menjalankan Aplikasi Secara Lokal

Pastikan Flutter telah terinstall di sistem dan konfigurasi SDK sudah benar. Kemudian jalankan perintah berikut:

```bash
cd d:\Flutter\bookmotor
flutter pub get
flutter run
```

Untuk menjalankan di browser:

```bash
flutter run -d chrome
```

Untuk build aplikasi Android:

```bash
flutter build apk
```

## 8. Catatan Pengembangan

- Aplikasi ini masih bersifat prototype UI/flow booking servis.
- Logika bisnis masih sebagian besar terintegrasi dalam state lokal aplikasi dan belum terhubung ke backend.
- Jika dikembangkan lebih lanjut, fitur yang paling potensial ditambahkan adalah API backend, autentikasi pengguna, database booking, dan manajemen admin bengkel.

## 9. Kesimpulan

BookMotor adalah aplikasi booking layanan servis motor yang mempresentasikan alur pengguna secara ringkas dan terstruktur. Fokus utama aplikasi ini adalah pengalaman reservasi yang cepat, informatif, dan mudah dipahami, dengan tampilan modern berbasis Flutter.

Aplikasi ini sangat cocok dikembangkan lebih lanjut menjadi platform booking bengkel motor yang lengkap, mulai dari frontend mobile hingga integrasi backend dan data real-time.
