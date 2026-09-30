part of '../booking_shell.dart';

extension _AppointmentScreen on _BookingShellState {
  Widget _appointmentScreen() {
    final branchDetails = {
      'M.GPIP - Gamping': ('Reg. Yogyakarta', 'Area Bantul 2'),
      'M.BGPN - Banguntapan': ('Reg. Yogyakarta', 'Area Bantul 1'),
      'M.KRAM - Karang Anom': ('Reg. Jawa Tengah', 'Area Klaten'),
    }[branch];
    final region = branchDetails?.$1 ?? 'Reg. Yogyakarta';
    final area = branchDetails?.$2 ?? '';
    final durationMinutes = workMode == 'Bersamaan' ? 90 : selected.length * 90;
    final durationLabel = '${durationMinutes ~/ 60}j ${durationMinutes % 60}m';
    final dates = [
      ('16', 'Sel'),
      ('17', 'Rab'),
      ('18', 'Kam'),
      ('19', 'Jum'),
      ('20', 'Sab'),
      ('21', 'Min'),
      ('22', 'Sen'),
    ];
    final slots = [
      ('08:00', 'Tersedia'),
      ('09:30', 'Tersedia'),
      ('11:00', 'Penuh'),
      ('13:00', 'Tersedia'),
      ('14:30', 'Terbatas'),
      ('16:00', 'Tersedia'),
    ];

    return Column(
      children: [
        _header('Cabang & Jadwal', step: 3, totalSteps: 4, centerTitle: true),
        Expanded(
          child: ListView(
            key: const PageStorageKey('appointment-schedule-list'),
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
            children: [
              const Text(
                'Atur jadwal bersama',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Satu jadwal berlaku untuk semua motor.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFFF9A5C)),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: orange),
                      ),
                      child: const Icon(
                        Icons.map_outlined,
                        size: 20,
                        color: orange,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            branch,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '$region · $area',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Row(
                            children: [
                              Icon(Icons.star, size: 12, color: orange),
                              SizedBox(width: 3),
                              Text(
                                '4.8 (126 ulasan) · Lihat ulasan',
                                style: TextStyle(fontSize: 11, color: orange),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => _rebuild(() => page = 3),
                      child: const Text(
                        'Ganti',
                        style: TextStyle(fontSize: 11, color: orange),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Pilih tanggal',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Text(
                    'Juni 2026',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 72,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: dates.map((item) {
                    final isSelected = date == item.$1;
                    return GestureDetector(
                      onTap: () => _rebuild(() => date = item.$1),
                      child: Container(
                        width: 48,
                        margin: const EdgeInsets.only(right: 7),
                        decoration: BoxDecoration(
                          color: isSelected ? orange : Colors.white,
                          border: Border.all(
                            color: isSelected
                                ? orange
                                : const Color(0xFFE8E8E8),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.$2,
                              style: TextStyle(
                                fontSize: 11,
                                color: isSelected
                                    ? Colors.white70
                                    : Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              item.$1,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : ink,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Pilih waktu',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Text(
                    'Durasi ± 2 jam',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: slots.map((slot) {
                  final isSelected = time == slot.$1;
                  final isUnavailable = slot.$2 == 'Penuh';
                  return SizedBox(
                    width: 94,
                    height: 51,
                    child: OutlinedButton(
                      onPressed: isUnavailable
                          ? null
                          : () => _rebuild(() => time = slot.$1),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        backgroundColor: isSelected
                            ? const Color(0xFFFFF1E7)
                            : Colors.white,
                        foregroundColor: isUnavailable ? Colors.grey : ink,
                        side: BorderSide(
                          color: isSelected ? orange : const Color(0xFFE8E8E8),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            slot.$1,
                            style: TextStyle(
                              fontSize: 13,
                              color: isSelected ? orange : null,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            slot.$2,
                            style: TextStyle(
                              fontSize: 10,
                              color: isUnavailable
                                  ? Colors.grey
                                  : slot.$2 == 'Terbatas'
                                  ? orange
                                  : const Color(0xFF55A879),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 14),
              const Text(
                'Mode pengerjaan',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _workModeOption('Bersamaan', 'Lebih cepat · ± 1j 30m'),
                  const SizedBox(width: 8),
                  _workModeOption('Berurutan', '± ${selected.length} jam'),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7DC),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total estimasi',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Rp${_money(total)}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Durasi',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '± $durationLabel',
                          style: const TextStyle(
                            fontSize: 14,
                            color: orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Color(0x12000000), blurRadius: 10)],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${branch.split('-').last.trim()} · $time',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      selected.length > 1 ? 'Semua motor' : '1 motor',
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 108,
                height: 44,
                child: FilledButton(
                  onPressed: next,
                  style: FilledButton.styleFrom(
                    backgroundColor: orange,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Lanjut'),
                      SizedBox(width: 4),
                      Icon(Icons.chevron_right, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _workModeOption(String mode, String details) {
    final isSelected = workMode == mode;
    return Expanded(
      child: InkWell(
        onTap: () => _rebuild(() => workMode = mode),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFFF8F3) : Colors.white,
            border: Border.all(
              color: isSelected ? orange : const Color(0xFFE8E8E8),
              width: isSelected ? 1.3 : 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                size: 15,
                color: isSelected ? orange : Colors.grey,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mode,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      details,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
