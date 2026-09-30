part of '../booking_shell.dart';

extension _TicketScreen on _BookingShellState {
  Widget _ticketScreen() => Container(
    color: const Color(0xFFF4F4F4),
    child: ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
          decoration: BoxDecoration(
            color: orange,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: orange, size: 32),
              ),
              const SizedBox(height: 12),
              const Text(
                'Booking Berhasil!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Semua motor terdaftar dalam satu tiket',
                style: TextStyle(fontSize: 12, color: Colors.white70),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'KODE BOOKING',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'SA-250617-84',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A1A),
                              letterSpacing: 0.4,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Tunjukkan QR saat tiba di cabang',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 88,
                      height: 88,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE6E6E6)),
                      ),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 64,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 8,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                            ),
                        itemBuilder: (context, index) {
                          final row = index ~/ 8;
                          final col = index % 8;
                          final active =
                              ((row + col) % 3 == 0) ||
                              ((row % 2 == 0) && (col % 2 == 0)) ||
                              ((row > 3) && (col > 3));
                          return Container(
                            decoration: BoxDecoration(
                              color: active ? Colors.black : Colors.white,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFFF9A5C)),
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E8),
                  shape: BoxShape.circle,
                  border: Border.all(color: orange),
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  color: orange,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '$branch\n${selected.length} motor',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF2A2A2A),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Jadwal',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '$date Juni 2026\n$time',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2A2A2A),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Status kendaraan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1E1E),
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () => _rebuild(() {
                if (bookingStatus < 4) bookingStatus++;
              }),
              style: TextButton.styleFrom(
                foregroundColor: orange,
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
              ),
              icon: const Icon(Icons.autorenew_rounded, size: 16),
              label: const Text(
                'Simulasikan',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...selected.map(_statusCard),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _miniActionButton(
                icon: Icons.call,
                label: 'Hubungi Cabang',
                selected: true,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _miniActionButton(
                icon: Icons.calendar_today,
                label: 'Ubah Jadwal',
                selected: false,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _miniActionButton(
                icon: Icons.more_horiz,
                label: 'Lainnya',
                selected: false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 52,
          child: FilledButton(
            onPressed: () => _rebuild(() => page = bookingStatus >= 4 ? 8 : 7),
            style: FilledButton.styleFrom(
              backgroundColor: orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              bookingStatus >= 4 ? 'Lihat Invoice' : 'Lacak Montir',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 52,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: orange,
              side: const BorderSide(color: orange, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Kembali ke Beranda',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _trackingScreen() {
    final steps = [
      ('Terjadwal', '09:15 WIB'),
      ('Check-in', '09:27 WIB'),
      ('Dikerjakan', 'Sedang berlangsung'),
      ('Quality Check', 'Menunggu'),
      ('Selesai', 'Menunggu'),
    ];

    return Container(
      color: const Color(0xFFF4F4F4),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => _rebuild(() => page = 6),
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'Lacak Montir',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.more_horiz, size: 22),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4EA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFFC89E)),
            ),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: orange,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status selesai unit',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        '1 Dikerjakan, 0 Menunggu',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2A2A2A),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2DBB66),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'Live',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFF9A5C), width: 1.3),
            ),
            child: const Text(
              'B 1234 XYZ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFFFC89E)),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    color: orange,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      'AR',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Andri Rahman',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Senior Technician',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        '★ 4.9 · 214 servis',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF4A4A4A),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF2E5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.phone, color: orange, size: 18),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF2E5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.chat, color: orange, size: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Progres pengerjaan',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                '${(bookingStatus * 100 / (steps.length - 1)).round()}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: bookingStatus / 4,
              minHeight: 8,
              backgroundColor: Color(0xFFE6E6E6),
              valueColor: AlwaysStoppedAnimation<Color>(orange),
            ),
          ),
          const SizedBox(height: 8),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Estimasi selesai: 11:15 WIB',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              children: steps.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final done =
                    index < bookingStatus || bookingStatus >= steps.length - 1;
                final active = index == bookingStatus && !done;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          key: ValueKey('tracking-step-$index'),
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: done || active
                                ? const Color(0xFF35C679)
                                : Colors.white,
                            border: Border.all(
                              color: done || active
                                  ? const Color(0xFF35C679)
                                  : Colors.grey.shade300,
                              width: 1.5,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: done
                              ? const Icon(
                                  Icons.check,
                                  size: 10,
                                  color: Colors.white,
                                )
                              : Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: active
                                          ? Colors.white
                                          : Colors.grey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                        ),
                        if (index < steps.length - 1)
                          Container(
                            width: 2,
                            height: 18,
                            color: done || active
                                ? const Color(0xFF35C679)
                                : Colors.grey.shade300,
                          ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: index == 0 ? 0 : 2,
                          bottom: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.$1,
                              style: TextStyle(
                                fontSize: 12,
                                color: done || active
                                    ? const Color(0xFF2A2A2A)
                                    : Colors.grey,
                                fontWeight: done || active
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                            ),
                            if (item.$2.isNotEmpty)
                              Text(
                                item.$2,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: done || active
                                      ? Colors.grey.shade600
                                      : Colors.grey,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: mechanicSuggestionApproved
                  ? const Color(0xFFEAF9F1)
                  : const Color(0xFFFFF7F0),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: mechanicSuggestionApproved
                    ? const Color(0xFF4DBB7A)
                    : const Color(0xFFFFC89E),
              ),
            ),
            child: mechanicSuggestionApproved
                ? Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: Color(0xFF35C679),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Tambahan kampas rem disetujui',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Kampas rem depan aus · +Rp75.000',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF5A5A5A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Perlu Persetujuan',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Kampas rem depan aus',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF343434),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Tambahan biaya',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(
                            '+Rp75.000',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: orange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 42,
                              child: OutlinedButton(
                                onPressed: () => _rebuild(
                                  () => mechanicSuggestionApproved = false,
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: orange,
                                  side: const BorderSide(
                                    color: orange,
                                    width: 1.2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Tolak',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SizedBox(
                              height: 42,
                              child: FilledButton(
                                onPressed: () => _rebuild(
                                  () => mechanicSuggestionApproved = true,
                                ),
                                style: FilledButton.styleFrom(
                                  backgroundColor: orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Setujui',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFEAEAEA)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Aktivitas terbaru',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: const BoxDecoration(
                        color: orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Pemeriksaan sistem pengereman',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2A2A2A),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '10:02 · Montir melakukan pemeriksaan rem depan aus',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: const BoxDecoration(
                        color: orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Servis rutin dimulai',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2A2A2A),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '09:42 · Tim service mulai melakukan servis rutin',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 46,
            child: OutlinedButton.icon(
              onPressed: () => _rebuild(() {
                if (bookingStatus < 4) bookingStatus++;
              }),
              icon: const Icon(Icons.sync, size: 18),
              label: const Text(
                'Simulasikan update status',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: orange,
                side: const BorderSide(color: orange, width: 1.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniActionButton({
    required IconData icon,
    required String label,
    required bool selected,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFFFF1E6) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected ? orange : const Color(0xFFE7E7E7),
          width: selected ? 1.2 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: selected ? orange : Colors.grey),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: selected ? orange : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusCard(Bike bike) {
    final labels = [
      'Terjadwal',
      'Check-in',
      'Dikerjakan',
      'Quality Check',
      'Selesai',
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFF9A5C), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E4),
                  shape: BoxShape.circle,
                  border: Border.all(color: orange, width: 1.2),
                ),
                child: const Icon(Icons.two_wheeler, color: orange, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bike.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF222222),
                      ),
                    ),
                    Text(
                      bike.plate,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF2E7),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: orange.withAlpha(200)),
                ),
                child: const Text(
                  'Selesai',
                  style: TextStyle(
                    fontSize: 10,
                    color: orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...labels.asMap().entries.map((entry) {
            final isDone = entry.key <= bookingStatus;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDone ? const Color(0xFF40C57A) : Colors.white,
                      border: Border.all(
                        color: isDone
                            ? const Color(0xFF40C57A)
                            : const Color(0xFFDADADA),
                        width: 1.5,
                      ),
                    ),
                    child: isDone
                        ? const Icon(Icons.check, size: 12, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDone ? const Color(0xFF2A2A2A) : Colors.grey,
                        fontWeight: isDone ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
