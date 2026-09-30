part of '../booking_shell.dart';

extension _BookingWidgets on _BookingShellState {
  Widget _header(
    String title, {
    int step = 0,
    int totalSteps = 5,
    bool centerTitle = false,
  }) => Column(
    children: [
      if (centerTitle)
        SizedBox(
          height: 56,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () =>
                      _rebuild(() => page = page > 0 ? page - 1 : 0),
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.more_horiz),
                ),
              ),
            ],
          ),
        )
      else
        Row(
          children: [
            IconButton(
              onPressed: () => _rebuild(() => page = page > 0 ? page - 1 : 0),
              icon: const Icon(Icons.arrow_back),
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
            const Icon(Icons.more_horiz),
          ],
        ),
      if (step > 0)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            children: List.generate(
              totalSteps,
              (index) => Expanded(
                child: Container(
                  height: 3,
                  margin: const EdgeInsets.only(right: 5),
                  color: index < step ? orange : const Color(0xFFE2E2E2),
                ),
              ),
            ),
          ),
        ),
    ],
  );

  Widget _bottomBar(
    String title,
    String action,
    VoidCallback onPressed, {
    String caption = '',
    bool showArrow = false,
  }) => Container(
    padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
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
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              if (caption.isNotEmpty)
                Text(
                  caption,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
            ],
          ),
        ),
        FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(backgroundColor: orange),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(action),
              if (showArrow) ...[
                const SizedBox(width: 6),
                const Icon(Icons.chevron_right, size: 18),
              ],
            ],
          ),
        ),
      ],
    ),
  );

  String _money(int amount) => amount.toString().replaceAllMapped(
    RegExp(r'(?=(\d{3})+(?!\d))'),
    (match) => '.',
  );
}
