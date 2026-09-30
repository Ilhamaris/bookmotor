part of '../booking_shell.dart';

extension _RatingScreen on _BookingShellState {
  Widget _ratingHeader(String title) => SizedBox(
    height: 52,
    child: Row(
      children: [
        IconButton(
          tooltip: 'Kembali',
          onPressed: () => _rebuild(() => page = 8),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 48, height: 48),
        ),
        Expanded(
          child: Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        IconButton(
          tooltip: 'Lainnya',
          onPressed: () => _toast('Tidak ada tindakan lain.'),
          icon: const Icon(Icons.more_horiz, size: 22),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 48, height: 48),
        ),
      ],
    ),
  );

  Widget _ratingScreen() {
    const categories = [
      'Kebersihan',
      'Kecepatan',
      'Keramahan',
      'Kesesuaian Harga',
    ];
    const mechanics = [
      ('Andri Rahman', 'B 1234 XYZ', 'AR'),
      ('Dimas Saputra', 'L 5678 ABC', 'DS'),
    ];

    return Container(
      color: const Color(0xFFFCFBFB),
      child: Column(
        children: [
          _ratingHeader('Rating & Ulasan'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(12, 15, 12, 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7DC),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Bagaimana pengalamanmu?',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        branch.isEmpty
                            ? 'M.GPIP - Gamping'
                            : branch.replaceFirst('M.', ''),
                        style: const TextStyle(
                          fontSize: 9,
                          color: Color(0xFF85858B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          final star = index + 1;
                          return IconButton(
                            key: ValueKey('service-rating-$star'),
                            onPressed: () =>
                                _rebuild(() => serviceRating = star),
                            visualDensity: VisualDensity.compact,
                            constraints: const BoxConstraints.tightFor(
                              width: 30,
                              height: 30,
                            ),
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              star <= serviceRating
                                  ? Icons.star_rounded
                                  : Icons.star_border_rounded,
                              color: const Color(0xFFFFA51F),
                              size: 24,
                            ),
                          );
                        }),
                      ),
                      Text(
                        [
                          'Buruk',
                          'Kurang',
                          'Baik',
                          'Sangat Baik',
                          'Istimewa',
                        ][serviceRating - 1],
                        style: const TextStyle(
                          fontSize: 9,
                          color: orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Apa yang paling berkesan?',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 7),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: categories.map((category) {
                    final selectedTag = reviewTags.contains(category);
                    return InkWell(
                      key: ValueKey('review-tag-$category'),
                      borderRadius: BorderRadius.circular(999),
                      onTap: () => _rebuild(() {
                        if (selectedTag) {
                          reviewTags.remove(category);
                        } else {
                          reviewTags.add(category);
                        }
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: selectedTag ? orange : Colors.white,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: selectedTag
                                ? orange
                                : const Color(0xFFE3E3E3),
                          ),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 8,
                            color: selectedTag ? Colors.white : ink,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 14),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Rating montir ',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: ink,
                        ),
                      ),
                      TextSpan(
                        text: 'Opsional',
                        style: TextStyle(fontSize: 9, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                ...mechanics.map((mechanic) {
                  final mechanicRating = mechanicRatings[mechanic.$1] ?? 5;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFECECEF)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                            color: orange,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            mechanic.$3,
                            style: const TextStyle(
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mechanic.$1,
                                style: const TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                mechanic.$2,
                                style: const TextStyle(
                                  fontSize: 7,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(5, (index) {
                            final star = index + 1;
                            return InkWell(
                              key: ValueKey(
                                'mechanic-rating-${mechanic.$1}-$star',
                              ),
                              onTap: () => _rebuild(
                                () => mechanicRatings[mechanic.$1] = star,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(1),
                                child: Icon(
                                  star <= mechanicRating
                                      ? Icons.star_rounded
                                      : Icons.star_border_rounded,
                                  color: const Color(0xFFFFA51F),
                                  size: 13,
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 8),
                const Text(
                  'Ceritakan pengalamanmu',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 7),
                TextFormField(
                  key: const ValueKey('review-text'),
                  initialValue: reviewText,
                  onChanged: (value) => reviewText = value,
                  minLines: 3,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Tulis ulasan untuk bengkel dan montir...',
                    hintStyle: const TextStyle(
                      fontSize: 9,
                      color: Color(0xFF9A9AA0),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF1F1F1),
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton.icon(
                  onPressed: () => _toast('Tambah foto belum tersedia.'),
                  icon: const Icon(Icons.photo_camera_outlined, size: 16),
                  label: const Text(
                    'Tambah foto  Opsional',
                    style: TextStyle(fontSize: 9),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: orange,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.zero,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 44,
                  child: FilledButton(
                    onPressed: () => _rebuild(() => page = 12),
                    style: FilledButton.styleFrom(
                      backgroundColor: orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Kirim Ulasan',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingSuccessScreen() => Container(
    color: const Color(0xFFFCFBFB),
    child: Column(
      children: [
        _ratingHeader('Rating & Ulasan'),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 24),
            children: [
              Container(
                width: 56,
                height: 56,
                margin: const EdgeInsets.symmetric(horizontal: 120),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Color(0xFF34AD6A),
                  size: 25,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Terima kasih, Ajil!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              const Text(
                'Ulasanmu membantu kami meningkatkan kualitas layanan.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 9, color: Color(0xFF85858B)),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < serviceRating
                        ? Icons.star_rounded
                        : Icons.star_border_rounded,
                    color: const Color(0xFFFFA51F),
                    size: 25,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 44,
                child: FilledButton(
                  onPressed: () => _rebuild(() => page = 0),
                  style: FilledButton.styleFrom(
                    backgroundColor: orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Kembali ke Beranda',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
