part of '../booking_shell.dart';

extension _ReviewScreen on _BookingShellState {
  Widget _reviewScreen() {
    Widget detailLine(String label, String value) => SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 9, color: Colors.grey),
            ),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(fontSize: 11, color: ink)),
          ],
        ),
      ),
    );

    int bikeTotal(Bike bike) => bike.price + bike.partsPrice;

    return Column(
      children: [
        _header('Review Booking', step: 4, totalSteps: 4, centerTitle: true),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            children: [
              const Text(
                'Periksa pesananmu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Pastikan semua detail servis sudah sesuai.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF6D9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.calendar_month, color: orange, size: 19),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Jadwal servis',
                            style: TextStyle(fontSize: 9, color: Colors.grey),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Rabu, $date Juni 2026',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '$time · ${branch.replaceFirst('M.', '')}',
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ...selected.asMap().entries.map((entry) {
                final index = entry.key;
                final bike = entry.value;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFFFA36B)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(dividerColor: const Color(0xFFEDEDED)),
                    child: ExpansionTile(
                      key: PageStorageKey('review-${bike.plate}'),
                      initiallyExpanded: index == 0,
                      tilePadding: const EdgeInsets.symmetric(horizontal: 10),
                      childrenPadding: const EdgeInsets.fromLTRB(12, 2, 12, 8),
                      leading: const CircleAvatar(
                        radius: 17,
                        backgroundColor: Color(0xFFFFF1E7),
                        child: Icon(Icons.two_wheeler, color: orange, size: 17),
                      ),
                      title: Text(
                        bike.name,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        bike.plate,
                        style: const TextStyle(fontSize: 9, color: orange),
                      ),
                      children: [
                        detailLine('Jenis servis', bike.service),
                        detailLine(
                          'Suku cadang',
                          bike.partMode == 'Bengkel'
                              ? 'Bengkel menyediakan'
                              : bike.partMode,
                        ),
                        detailLine(
                          'Keluhan',
                          bike.complaint.trim().isEmpty
                              ? 'Tidak ada keluhan'
                              : bike.complaint,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () => _rebuild(() {
                              activeBike = selected.indexOf(bike);
                              page = 2;
                            }),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 28),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Ubah pengaturan',
                              style: TextStyle(
                                color: orange,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 2),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFFFA36B)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ringkasan biaya',
                      style: TextStyle(fontSize: 12, color: ink),
                    ),
                    const SizedBox(height: 8),
                    ...selected.map(
                      (bike) => Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                bike.plate,
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Text(
                              'Rp${_money(bikeTotal(bike))}',
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 12),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Total estimasi',
                            style: TextStyle(fontSize: 11, color: ink),
                          ),
                        ),
                        Text(
                          'Rp${_money(total)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Text(
                        'Biaya final dapat berubah setelah inspeksi oleh mekanik.',
                        style: TextStyle(fontSize: 8, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              CheckboxListTile(
                value: terms,
                activeColor: orange,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                dense: true,
                visualDensity: VisualDensity.compact,
                onChanged: (value) => _rebuild(() => terms = value ?? false),
                title: RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 9, color: Colors.grey),
                    children: [
                      TextSpan(text: 'Saya menyetujui '),
                      TextSpan(
                        text: 'syarat & ketentuan',
                        style: TextStyle(
                          color: orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ' layanan Servisin Aja.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        _bottomBar(
          'Rp${_money(total)}',
          'Konfirmasi',
          () {
            if (!terms) {
              _toast('Centang syarat dan ketentuan terlebih dahulu');
              return;
            }
            _rebuild(() {
              page = 6;
              bookingStatus = 2;
            });
          },
          caption: '${selected.length} motor · Estimasi total',
          showArrow: true,
        ),
      ],
    );
  }
}
