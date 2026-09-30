import 'package:flutter/material.dart';

import '../models/bike.dart';
import '../theme/app_theme.dart';

part 'screens/home_screen.dart';
part 'screens/vehicle_screen.dart';
part 'screens/service_screen.dart';
part 'screens/schedule_screen.dart';
part 'screens/appointment_screen.dart';
part 'screens/review_screen.dart';
part 'screens/ticket_screen.dart';
part 'screens/invoice_screen.dart';
part 'screens/payment_screen.dart';
part 'screens/rating_screen.dart';
part 'widgets/booking_widgets.dart';

class BookingShell extends StatefulWidget {
  const BookingShell({super.key});

  @override
  State<BookingShell> createState() => _BookingShellState();
}

class _BookingShellState extends State<BookingShell> {
  final bikes = <Bike>[
    Bike('Honda Vario 160', 'B 1234 XYZ', '8.520 km'),
    Bike('Honda BeAT', 'L 5678 ABC', '8.210 km'),
    Bike('Honda CB150R', 'N 9012 DEF', '21.080 km'),
  ];
  final Map<Bike, TextEditingController> _complaintControllers = {};
  int page = 0;
  int activeBike = 0;
  int bookingStatus = 2;
  bool mechanicSuggestionApproved = false;
  bool paymentComplete = false;
  bool terms = false;
  String paymentMethod = 'QRIS';
  String paymentVoucherCode = 'SERVISHEMAT';
  bool paymentVoucherApplied = true;
  int serviceRating = 3;
  final Set<String> reviewTags = {};
  final Map<String, int> mechanicRatings = {
    'Andri Rahman': 5,
    'Dimas Saputra': 5,
  };
  String reviewText = '';
  String branch = '';
  String branchQuery = '';
  String date = '17';
  String time = '09:30';
  String workMode = 'Bersamaan';

  List<Bike> get selected => bikes.where((bike) => bike.selected).toList();
  int get total =>
      selected.fold(0, (sum, bike) => sum + bike.price + bike.partsPrice);
  int get invoiceSubtotal => total + (mechanicSuggestionApproved ? 75000 : 0);
  int get invoiceVoucher {
    if (!paymentVoucherApplied) return 0;
    return invoiceSubtotal < 20000 ? invoiceSubtotal : 20000;
  }

  int get invoiceTax => ((invoiceSubtotal - invoiceVoucher) * 0.11).round();
  int get invoiceTotal => invoiceSubtotal - invoiceVoucher + invoiceTax;

  TextEditingController _complaintControllerFor(Bike bike) =>
      _complaintControllers.putIfAbsent(
        bike,
        () => TextEditingController(text: bike.complaint),
      );

  void _rebuild(VoidCallback update) => setState(update);

  void next() {
    if (page == 1 && selected.isEmpty) return;
    if (page == 3 && branch.isEmpty) return;
    if (page == 2 && selected.any((bike) => !bike.configured)) {
      final first = selected.indexWhere((bike) => !bike.configured);
      setState(() => activeBike = first < 0 ? 0 : first);
      _toast('Lengkapi pengaturan ${selected[first].name} terlebih dahulu');
      return;
    }
    setState(() => page = (page + 1).clamp(0, 6));
  }

  void _toast(String message) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
  );

  @override
  void dispose() {
    for (final controller in _complaintControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 280),
        child: _screen(),
      ),
    ),
  );

  Widget _screen() {
    switch (page) {
      case 1:
        return _vehicleScreen();
      case 2:
        return _serviceScreen();
      case 3:
        return _branchScreen();
      case 4:
        return _appointmentScreen();
      case 5:
        return _reviewScreen();
      case 6:
        return KeyedSubtree(key: const ValueKey(6), child: _ticketScreen());
      case 7:
        return KeyedSubtree(key: const ValueKey(7), child: _trackingScreen());
      case 8:
        return KeyedSubtree(key: const ValueKey(8), child: _invoiceScreen());
      case 9:
        return KeyedSubtree(key: const ValueKey(9), child: _paymentScreen());
      case 10:
        return KeyedSubtree(
          key: const ValueKey(10),
          child: _paymentSuccessScreen(),
        );
      case 11:
        return KeyedSubtree(key: const ValueKey(11), child: _ratingScreen());
      case 12:
        return KeyedSubtree(
          key: const ValueKey(12),
          child: _ratingSuccessScreen(),
        );
      default:
        return _homeScreen();
    }
  }
}
