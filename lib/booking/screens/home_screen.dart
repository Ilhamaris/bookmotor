part of '../booking_shell.dart';

extension _HomeScreen on _BookingShellState {
  Widget _homeScreen() => LayoutBuilder(
    builder: (context, constraints) => SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 28),
            decoration: const BoxDecoration(
              color: orange,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Text(
                    'AJ',
                    style: TextStyle(
                      color: orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, Aji',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Team Leader',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => _rebuild(() => page = 1),
                    icon: const Icon(
                      Icons.two_wheeler,
                      color: orange,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF6D9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: Color(0xFFFFB62E),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 4,
                              ),
                              child: Text(
                                'Selamat Sore',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Semangat bekerja, Aji!',
                            style: TextStyle(fontSize: 14, color: ink),
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 13, color: orange),
                              SizedBox(width: 4),
                              Text(
                                '16:42 WIB',
                                style: TextStyle(fontSize: 11, color: orange),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Icon(
                          Icons.wb_sunny,
                          color: const Color(0xFFFFB62E),
                          size: 54,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(width: 76, height: 2, color: orange),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _homeSectionTitle('Absensi', 'Aktivitas hari ini'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _homeMenuItem(
                      Icons.calendar_today_outlined,
                      'Absen Kehadiran',
                      () => _toast('Absensi kehadiran belum dibuka'),
                    ),
                    const SizedBox(width: 26),
                    _homeMenuItem(
                      Icons.access_time,
                      'Riwayat Absen',
                      () => _toast('Belum ada riwayat absensi'),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                _homeSectionTitle('Servis', 'Rawat kendaraanmu'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _homeMenuItem(
                      Icons.two_wheeler,
                      'Servis Kendaraan',
                      () => _rebuild(() => page = 1),
                    ),
                    const SizedBox(width: 12),
                    _homeMenuItem(
                      Icons.access_time,
                      'Riwayat Servis',
                      () => _toast('Riwayat servis segera hadir'),
                    ),
                    const SizedBox(width: 12),
                    _homeMenuItem(
                      Icons.menu_book_outlined,
                      'Panduan Jasa',
                      () => _toast('Panduan jasa segera hadir'),
                    ),
                  ],
                ),
                SizedBox(height: constraints.maxHeight > 640 ? 52 : 28),
                const Center(
                  child: Text(
                    '© 2025 Servisin Aja',
                    style: TextStyle(color: Color(0xFFB3B0B5), fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _homeSectionTitle(String title, String trailing) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: const TextStyle(fontSize: 16, color: ink)),
      Text(
        trailing,
        style: const TextStyle(fontSize: 10, color: Color(0xFFAAA6AD)),
      ),
    ],
  );

  Widget _homeMenuItem(IconData icon, String label, VoidCallback onTap) =>
      Expanded(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: orange,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 21),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10, color: ink),
              ),
            ],
          ),
        ),
      );
}
