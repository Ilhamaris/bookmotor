// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bookmotor/booking/booking_shell.dart';
import 'package:bookmotor/main.dart';

void main() {
  testWidgets('service history shows coming soon message', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BookMotorApp());

    await tester.tap(find.text('Riwayat Servis'));
    await tester.pumpAndSettle();

    expect(find.text('Riwayat servis segera hadir'), findsOneWidget);
    expect(find.text('Halo, Aji'), findsOneWidget);
  });

  testWidgets('home booking flow starts with garage', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BookMotorApp());

    expect(find.text('Halo, Aji'), findsOneWidget);
    expect(find.text('Servis Kendaraan'), findsOneWidget);
    expect(find.text('Semangat bekerja, Aji!'), findsOneWidget);

    await tester.tap(find.text('Servis Kendaraan'));
    await tester.pumpAndSettle();
    expect(find.text('Pilih Kendaraan'), findsOneWidget);

    await tester.tap(find.text('Tambah Motor'));
    await tester.pumpAndSettle();
    expect(find.text('Masukkan detail kendaraan baru'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(CheckboxListTile).at(1));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(CheckboxListTile).at(2));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lanjut'));
    await tester.pumpAndSettle();

    expect(find.text('Atur Servis'), findsOneWidget);
    expect(find.text('Jenis Servis'), findsOneWidget);
    expect(find.text('Suku Cadang'), findsOneWidget);
    expect(find.text('1 layanan'), findsOneWidget);
    expect(find.text('+ Rp75rb'), findsOneWidget);
    await tester.tap(find.text('Rem'));
    await tester.pumpAndSettle();
    expect(find.text('2 layanan'), findsOneWidget);

    await tester.drag(find.byType(ListView).last, const Offset(0, -600));
    await tester.pumpAndSettle();

    expect(find.text('Keluhan'), findsOneWidget);
    expect(find.text('Salin pengaturan ke motor lain'), findsOneWidget);

    await tester.tap(find.text('Lanjut'));
    await tester.pumpAndSettle();

    expect(find.text('Cabang & Jadwal'), findsOneWidget);
    expect(find.text('M.GPIP - Gamping'), findsOneWidget);
    expect(find.text('M.BGPN - Banguntapan'), findsOneWidget);
    expect(find.text('M.KRAM - Karang Anom'), findsOneWidget);
    expect(find.text('Pilih tanggal'), findsNothing);
    expect(find.text('Pilih waktu'), findsNothing);
    expect(find.text('Lanjut'), findsNothing);

    await tester.enterText(find.byType(TextField), 'Banguntapan');
    await tester.pumpAndSettle();
    expect(find.text('M.BGPN - Banguntapan'), findsOneWidget);
    expect(find.text('M.GPIP - Gamping'), findsNothing);

    await tester.tap(find.text('Pilih'));
    await tester.pumpAndSettle();
    expect(find.text('Atur jadwal bersama'), findsOneWidget);
    expect(find.text('Pilih tanggal'), findsOneWidget);
    expect(find.text('Pilih waktu'), findsOneWidget);
    expect(find.text('Mode pengerjaan'), findsOneWidget);
    expect(find.text('M.BGPN - Banguntapan'), findsOneWidget);

    await tester.tap(find.text('Berurutan'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('18'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('13:00'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lanjut'));
    await tester.pumpAndSettle();
    expect(find.text('Review Booking'), findsOneWidget);
    expect(find.text('Jadwal servis'), findsOneWidget);
    expect(find.text('Jenis servis'), findsOneWidget);
    expect(find.text('Ubah pengaturan'), findsOneWidget);
    expect(find.text('Ringkasan biaya'), findsOneWidget);

    await tester.drag(find.byType(ListView).first, const Offset(0, -500));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(CheckboxListTile));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Konfirmasi'));
    await tester.pumpAndSettle();
    expect(find.text('Booking Berhasil!'), findsOneWidget);
  });

  testWidgets('complaint chips combine and remove complaints', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: BookingShell()));

    final shellState = tester.state(find.byType(BookingShell)) as dynamic;
    shellState.page = 2;
    shellState.setState(() {});
    await tester.pumpAndSettle();

    await tester.drag(find.byType(ListView), const Offset(0, -700));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Mesin kasar'));
    await tester.tap(find.text('Mesin kasar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rem bunyi'));
    await tester.pumpAndSettle();

    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      'Mesin kasar, Rem bunyi',
    );

    await tester.tap(find.text('Mesin kasar'));
    await tester.pumpAndSettle();

    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      'Rem bunyi',
    );
  });

  testWidgets('mechanic suggestion approval shows green approved state', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: BookingShell()));
    await tester.pumpAndSettle();

    final shellState = tester.state(find.byType(BookingShell)) as dynamic;
    shellState.page = 7;
    shellState.setState(() {});
    await tester.pumpAndSettle();

    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pumpAndSettle();

    expect(find.text('Setujui'), findsOneWidget);
    await tester.tap(find.text('Setujui'));
    await tester.pumpAndSettle();

    expect(find.text('Tambahan kampas rem disetujui'), findsOneWidget);

    await tester.ensureVisible(find.text('Simulasikan update status'));
    await tester.tap(find.text('Simulasikan update status'));
    await tester.pumpAndSettle();

    expect(find.text('75%'), findsOneWidget);
    await tester.ensureVisible(find.text('Dikerjakan'));
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('tracking-step-2')),
        matching: find.byIcon(Icons.check),
      ),
      findsOneWidget,
    );

    await tester.ensureVisible(find.text('Simulasikan update status'));
    await tester.tap(find.text('Simulasikan update status'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Simulasikan update status'));
    await tester.pumpAndSettle();
    expect(find.text('100%'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, 1200));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView), const Offset(0, -1000));
    await tester.pumpAndSettle();
    expect(find.text('Lihat Invoice'), findsOneWidget);

    await tester.tap(find.text('Lihat Invoice'));
    await tester.pumpAndSettle();
    expect(shellState.page, 8);
    expect(find.text('Detail Invoice'), findsOneWidget);
    expect(find.text('Ringkasan pembayaran'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -800));
    await tester.pumpAndSettle();
    expect(find.text('Bayar Sekarang'), findsOneWidget);
    await tester.tap(find.text('Bayar Sekarang'));
    await tester.pumpAndSettle();

    expect(find.text('Pembayaran'), findsOneWidget);
    expect(find.text('Pilih metode pembayaran'), findsOneWidget);
    expect(find.text('Bayar di Bengkel'), findsOneWidget);
    expect(find.text('Transfer VA'), findsOneWidget);
    expect(find.text('E-Wallet'), findsOneWidget);
    expect(find.text('QRIS'), findsNWidgets(2));
    expect(find.textContaining('Voucher SERVISHEMAT aktif'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('payment-method-Transfer VA')));
    await tester.pumpAndSettle();
    expect(shellState.paymentMethod, 'Transfer VA');

    await tester.tap(find.text('Bayar Sekarang'));
    await tester.pumpAndSettle();
    expect(find.text('Pembayaran Berhasil'), findsOneWidget);
    expect(find.text('ID Transaksi: PAY-8491037'), findsOneWidget);

    await tester.tap(find.text('Lihat Invoice'));
    await tester.pumpAndSettle();
    expect(find.text('Lunas'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -900));
    await tester.pumpAndSettle();
    expect(find.text('Beri Rating & Ulasan'), findsOneWidget);

    await tester.tap(find.text('Beri Rating & Ulasan'));
    await tester.pumpAndSettle();
    expect(find.text('Bagaimana pengalamanmu?'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('service-rating-5')));
    await tester.tap(find.byKey(const ValueKey('review-tag-Keramahan')));
    await tester.enterText(
      find.byKey(const ValueKey('review-text')),
      'Pelayanan montir ramah dan cepat.',
    );
    tester.testTextInput.hide();
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView), const Offset(0, -900));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kirim Ulasan'));
    await tester.pumpAndSettle();
    expect(find.text('Terima kasih, Ajil!'), findsOneWidget);
    await tester.tap(find.text('Kembali ke Beranda'));
    await tester.pumpAndSettle();
    expect(find.text('Halo, Aji'), findsOneWidget);
  });
}
