part of '../booking_shell.dart';

extension _VehicleScreen on _BookingShellState {
  Widget _vehicleScreen() => Column(
    children: [
      _header('Pilih Kendaraan', step: 1),
      Expanded(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Motor mana yang diservis?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Pilih hingga 5 motor dalam satu booking.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 18),
            ...bikes.map(_selectBike),
            OutlinedButton.icon(
              onPressed: bikes.length >= 5
                  ? () => _toast('Maksimal 5 motor per transaksi')
                  : _addBike,
              icon: const Icon(Icons.add),
              label: const Text('Tambah Motor'),
              style: OutlinedButton.styleFrom(
                foregroundColor: orange,
                side: const BorderSide(color: orange),
                minimumSize: const Size.fromHeight(48),
              ),
            ),
          ],
        ),
      ),
      _bottomBar('${selected.length} motor dipilih', 'Lanjut', next),
    ],
  );

  Widget _selectBike(Bike bike) => Card(
    margin: const EdgeInsets.only(bottom: 10),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      side: BorderSide(color: bike.selected ? orange : Colors.transparent),
    ),
    child: CheckboxListTile(
      value: bike.selected,
      activeColor: orange,
      onChanged: (value) => _rebuild(() => bike.selected = value ?? false),
      title: Text(
        bike.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('${bike.plate}  •  KM ${bike.km}'),
      secondary: const Icon(Icons.two_wheeler, color: orange),
    ),
  );

  void _addBike() {
    final plate = TextEditingController();
    final type = TextEditingController();
    final year = TextEditingController(text: '2023');
    final currentKm = TextEditingController(text: '8.500');
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, setSheetState) {
          final ready =
              plate.text.isNotEmpty &&
              type.text.isNotEmpty &&
              year.text.isNotEmpty &&
              currentKm.text.isNotEmpty;

          Widget field(
            String label,
            TextEditingController controller,
            String hint,
          ) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: ink,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: controller,
                onChanged: (_) => setSheetState(() {}),
                decoration: InputDecoration(
                  hintText: hint,
                  filled: true,
                  fillColor: const Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
                style: const TextStyle(fontSize: 12),
              ),
            ],
          );

          return SafeArea(
            top: false,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                16,
                8,
                16,
                MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 38,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD6D6D6),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tambah Motor',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ink,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                'Masukkan detail kendaraan baru',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(sheetContext),
                          icon: const Icon(Icons.close, color: ink),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    field('Nomor polisi', plate, 'B 1234 ABC'),
                    const SizedBox(height: 10),
                    field('Tipe motor', type, 'Contoh: Yamaha NMAX'),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: field('Tahun', year, '2023')),
                        const SizedBox(width: 8),
                        Expanded(
                          child: field('KM saat ini', currentKm, '8.500'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: FilledButton(
                        onPressed: ready
                            ? () {
                                _rebuild(
                                  () => bikes.add(
                                    Bike(
                                      type.text,
                                      plate.text,
                                      '${currentKm.text} km',
                                      year: year.text,
                                    ),
                                  ),
                                );
                                Navigator.pop(sheetContext);
                              }
                            : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: orange,
                          disabledBackgroundColor: const Color(0xFFD9D9D9),
                          disabledForegroundColor: Colors.white,
                        ),
                        child: const Text('Simpan Motor'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
