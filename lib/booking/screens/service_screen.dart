part of '../booking_shell.dart';

extension _ServiceScreen on _BookingShellState {
  Widget _serviceScreen() {
    final bike = selected.isEmpty
        ? bikes.first
        : selected[activeBike.clamp(0, selected.length - 1)];
    final complaintController = _complaintControllerFor(bike);
    List<String> complaintList() => bike.complaint
      .split(',')
      .map((complaint) => complaint.trim())
      .where((complaint) => complaint.isNotEmpty)
      .toList();
    final parts = [
      ('AHM Oil MPX 1', 58000),
      ('Busi NGK', 28000),
      ('Kampas rem', 75000),
    ];

    return Column(
      children: [
        Column(
          children: [
            SizedBox(
              height: 56,
              child: Stack(
                children: [
                  const Center(
                    child: Text(
                      'Atur Servis',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () =>
                          _rebuild(() => page = page > 0 ? page - 1 : 0),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => _rebuild(() {}),
                      icon: const Icon(Icons.refresh),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
              child: Row(
                children: List.generate(
                  4,
                  (index) => Expanded(
                    child: Container(
                      height: 3,
                      margin: const EdgeInsets.only(right: 5),
                      color: index < 2 ? orange : const Color(0xFFE2E2E2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: selected.asMap().entries.map((entry) {
                    final item = entry.value;
                    final isActive = item == bike;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                        onTap: () => _rebuild(() => activeBike = entry.key),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          constraints: const BoxConstraints(minWidth: 108),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isActive
                                ? const Color(0xFFFFF8F3)
                                : Colors.white,
                            border: Border.all(
                              color: isActive
                                  ? orange
                                  : const Color(0xFFE8E8E8),
                              width: isActive ? 1.5 : 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.plate,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    item.configured
                                        ? Icons.check_circle
                                        : Icons.circle_outlined,
                                    size: 11,
                                    color: item.configured
                                        ? const Color(0xFF4CAF80)
                                        : Colors.grey,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    item.configured
                                        ? 'Lengkap'
                                        : 'Belum lengkap',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: item.configured
                                          ? const Color(0xFF4CAF80)
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 17,
                    backgroundColor: Color(0xFFFFF1E7),
                    child: Icon(Icons.two_wheeler, color: orange, size: 18),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bike.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          bike.plate,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1E7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${bike.services.length} layanan',
                      style: const TextStyle(color: orange, fontSize: 11),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _serviceStepCard(
                1,
                'Jenis Servis',
                'Pilih satu atau lebih layanan',
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children:
                      [
                        'Servis Rutin',
                        'Ganti Oli',
                        'Servis CVT',
                        'Rem',
                        'Kelistrikan',
                        'Lainnya',
                      ].map((name) {
                        final isSelected = bike.services.contains(name);
                        return InkWell(
                          onTap: () => _rebuild(() {
                            if (isSelected) {
                              if (bike.services.length > 1) {
                                bike.services.remove(name);
                              }
                            } else {
                              bike.services.add(name);
                            }
                            bike.configured = true;
                          }),
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 123,
                            padding: const EdgeInsets.fromLTRB(9, 7, 6, 6),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFFFF1E7)
                                  : Colors.white,
                              border: Border.all(
                                color: isSelected
                                    ? orange
                                    : const Color(0xFFE8E8E8),
                                width: isSelected ? 1.4 : 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '+ Rp${servicePrices[name]! ~/ 1000}rb',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isSelected ? orange : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
              _serviceStepCard(
                2,
                'Suku Cadang',
                'Pilih cara penyediaan',
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F1F1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children:
                            [
                              'Bengkel',
                              'Bawa sendiri',
                              'Rekomendasi mekanik',
                            ].map((mode) {
                              final isSelected = bike.partMode == mode;
                              return Expanded(
                                child: InkWell(
                                  onTap: () => _rebuild(() {
                                    bike.partMode = mode;
                                    bike.configured = true;
                                  }),
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 34,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? orange
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      mode,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: isSelected ? Colors.white : ink,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                    if (bike.partMode == 'Bengkel') ...[
                      const SizedBox(height: 8),
                      ...parts.map(
                        (part) => SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => _rebuild(() {
                                  bike.selectedParts[part.$1] =
                                      !bike.selectedParts[part.$1]!;
                                  bike.configured = true;
                                }),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 140),
                                  width: 24,
                                  height: 14,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: bike.selectedParts[part.$1]!
                                        ? orange
                                        : const Color(0xFFD8D8D8),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Align(
                                    alignment: bike.selectedParts[part.$1]!
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: const DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: SizedBox(width: 10, height: 10),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  part.$1,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Text(
                                '+ Rp${_money(part.$2)}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              _serviceStepCard(
                3,
                'Keluhan',
                'Opsional, bantu mekanik memahami kendala',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children:
                          [
                            'Mesin kasar',
                            'Rem bunyi',
                            'Susah hidup',
                            'Getar',
                          ].map((text) {
                            final isSelected = complaintList().contains(text);
                            return InkWell(
                              onTap: () => _rebuild(() {
                                final complaints = complaintList();
                                if (complaints.contains(text)) {
                                  complaints.remove(text);
                                } else {
                                  complaints.add(text);
                                }
                                bike.complaint = complaints.join(', ');
                                complaintController.value = TextEditingValue(
                                  text: bike.complaint,
                                  selection: TextSelection.collapsed(
                                    offset: bike.complaint.length,
                                  ),
                                );
                                bike.configured = true;
                              }),
                              borderRadius: BorderRadius.circular(18),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 9,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFFFFF1E7)
                                      : Colors.white,
                                  border: Border.all(
                                    color: isSelected
                                        ? orange
                                        : const Color(0xFFE8E8E8),
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Text(
                                  text,
                                  style: const TextStyle(fontSize: 11),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 9),
                    TextField(
                      controller: complaintController,
                      maxLines: 2,
                      onChanged: (value) => _rebuild(() {
                        bike.complaint = value;
                        bike.configured = true;
                      }),
                      decoration: InputDecoration(
                        hintText: 'Ceritakan keluhan motor...',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF3F3F3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(10),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () => _toast('Fitur tambah foto segera hadir'),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            size: 16,
                            color: orange,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Tambah foto',
                            style: TextStyle(
                              fontSize: 12,
                              color: orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Opsional',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                height: 40,
                child: OutlinedButton.icon(
                  onPressed: () {
                    for (final other in selected) {
                      if (other != bike) {
                        other.services
                          ..clear()
                          ..addAll(bike.services);
                        other.partMode = bike.partMode;
                        other.selectedParts.addAll(bike.selectedParts);
                        other.configured = true;
                      }
                    }
                    _rebuild(() {});
                    _toast('Pengaturan disalin ke motor lain');
                  },
                  icon: const Icon(Icons.copy, size: 15),
                  label: const Text(
                    'Salin pengaturan ke motor lain',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: orange,
                    side: const BorderSide(color: orange),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 9),
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
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Estimasi unit ini',
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(height: 3),
                          Text(
                            '≈ 90 menit',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Rp${_money(bike.price + bike.partsPrice)}',
                      style: const TextStyle(
                        color: orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        _bottomBar(
          'Rp${_money(total)}',
          'Lanjut',
          next,
          caption: '≈ ${selected.length * 90} menit · ${selected.length} motor',
          showArrow: true,
        ),
      ],
    );
  }

  Widget _serviceStepCard(
    int number,
    String title,
    String subtitle,
    Widget child,
  ) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xFFFFA36B)),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 10,
              backgroundColor: orange,
              child: Text(
                '$number',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 9),
        child,
      ],
    ),
  );
}
