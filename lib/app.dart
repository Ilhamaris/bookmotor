import 'package:flutter/material.dart';

import 'booking/booking_shell.dart';
import 'theme/app_theme.dart';

class BookMotorApp extends StatelessWidget {
  const BookMotorApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Halo-Aji',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: canvas,
      colorScheme: ColorScheme.fromSeed(seedColor: orange),
      fontFamily: 'Arial',
    ),
    home: const BookingShell(),
  );
}
