part of '../booking_shell.dart';

extension _BranchScreen on _BookingShellState {
  Widget _branchScreen() {
    final branches = [
      (
        name: 'M.GPIP - Gamping',
        region: 'Reg. Yogyakarta',
        area: 'Area Bantul 2',
        queue: '3 Antrean',
      ),
      (
        name: 'M.BGPN - Banguntapan',
        region: 'Reg. Yogyakarta',
        area: 'Area Bantul 1',
        queue: '5 Antrean',
      ),
      (
        name: 'M.KRAM - Karang Anom',
        region: 'Reg. Jawa Tengah',
        area: 'Area Klaten',
        queue: '2 Antrean',
      ),
    ];
    final filteredBranches = branches.where((item) {
      final query = branchQuery.trim().toLowerCase();
      return query.isEmpty ||
          '${item.name} ${item.region} ${item.area}'.toLowerCase().contains(
            query,
          );
    }).toList();

    return Column(
      children: [
        _header('Cabang & Jadwal', step: 3, totalSteps: 4, centerTitle: true),
        Expanded(
          child: ListView(
            key: const PageStorageKey('branch-selection-list'),
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
            children: [
              const Text(
                'Pilih cabang servis',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Cari cabang terdekat yang tersedia.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 14),
              TextField(
                onChanged: (value) => _rebuild(() => branchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Cari kode/nama cabang...',
                  hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, size: 20),
                  filled: true,
                  fillColor: const Color(0xFFF1F1F1),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (filteredBranches.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 28),
                  child: Center(
                    child: Text(
                      'Cabang tidak ditemukan',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ),
              ...filteredBranches.map((item) {
                final isSelected = branch == item.name;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFFF9A5C),
                      width: isSelected ? 1.5 : 1,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                                  item.name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item.region,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            item.area,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            item.queue,
                            style: const TextStyle(
                              fontSize: 10,
                              color: orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 9),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: FilledButton(
                          onPressed: () => _rebuild(() {
                            branch = item.name;
                            page = 4;
                          }),
                          style: FilledButton.styleFrom(
                            backgroundColor: orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            isSelected ? 'Dipilih' : 'Pilih',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
