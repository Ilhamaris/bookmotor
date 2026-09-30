part of '../booking_shell.dart';

extension _InvoiceScreen on _BookingShellState {
  Widget _invoiceScreen() {
    const partPrices = <String, int>{
      'AHM Oil MPX 1': 58000,
      'Busi NGK': 28000,
      'Kampas rem': 75000,
    };
    final subtotal = invoiceSubtotal;
    final voucher = invoiceVoucher;
    final tax = invoiceTax;
    final payable = invoiceTotal;

    Widget amountLine(String title, int amount, {Color? color}) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 11, color: Color(0xFF555555)),
            ),
          ),
          Text(
            '${amount < 0 ? '-' : ''}Rp${_invoiceMoney(amount)}',
            style: TextStyle(
              fontSize: 11,
              color: color ?? const Color(0xFF252525),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    BoxDecoration cardDecoration() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFFF9A5C), width: 1.1),
    );

    return Container(
      color: const Color(0xFFFCFBFB),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
        children: [
          SizedBox(
            height: 42,
            child: Row(
              children: [
                IconButton(
                  tooltip: 'Kembali',
                  onPressed: () => _rebuild(() => page = 6),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints.tightFor(
                    width: 34,
                    height: 40,
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Detail Invoice',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Lainnya',
                  onPressed: () =>
                      _toast('Tidak ada tindakan lain untuk invoice ini.'),
                  icon: const Icon(Icons.more_horiz, size: 22),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints.tightFor(
                    width: 34,
                    height: 40,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 11),
            decoration: cardDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Text(
                        'NO. INVOICE',
                        style: TextStyle(fontSize: 8, color: Colors.grey),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: paymentComplete
                            ? const Color(0xFFEAF8F0)
                            : const Color(0xFFFFF1E6),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        paymentComplete ? 'Lunas' : 'Belum Dibayar',
                        style: TextStyle(
                          fontSize: 8,
                          color: paymentComplete
                              ? const Color(0xFF2E9D5B)
                              : orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                const Text(
                  'INV/SA/250617/0084',
                  style: TextStyle(
                    fontSize: 14,
                    color: orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Divider(height: 14, color: Color(0xFFF0F0F0)),
                Row(
                  children: [
                    const Icon(
                      Icons.map_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        branch.isEmpty ? 'M.GPIP - Gamping' : branch,
                        style: const TextStyle(fontSize: 9, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$date Juni 2026 · $time WIB',
                      style: const TextStyle(fontSize: 9, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: cardDecoration(),
            child: Column(
              children: [
                ...selected.asMap().entries.map((entry) {
                  final bikeIndex = entry.key;
                  final bike = entry.value;
                  final bikeAmount =
                      bike.price +
                      bike.partsPrice +
                      (bikeIndex == 0 && mechanicSuggestionApproved
                          ? 75000
                          : 0);

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(11, 10, 11, 9),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFF1E6),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.two_wheeler,
                                size: 16,
                                color: orange,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bike.name,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    bike.plate,
                                    style: const TextStyle(
                                      fontSize: 9,
                                      color: orange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Rp${_invoiceMoney(bikeAmount)}',
                              style: const TextStyle(
                                fontSize: 9,
                                color: orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(Icons.keyboard_arrow_up, size: 17),
                          ],
                        ),
                      ),
                      const Divider(height: 1, color: Color(0xFFF1F1F1)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(11, 9, 11, 9),
                        child: Column(
                          children: [
                            ...bike.services.map(
                              (service) => amountLine(
                                service,
                                servicePrices[service] ?? 0,
                              ),
                            ),
                            if (bike.partMode == 'Bengkel')
                              ...bike.selectedParts.entries
                                  .where((part) => part.value)
                                  .map(
                                    (part) => amountLine(
                                      part.key,
                                      partPrices[part.key]!,
                                    ),
                                  ),
                            if (bikeIndex == 0 && mechanicSuggestionApproved)
                              amountLine('Kampas rem depan (tambahan)', 75000),
                          ],
                        ),
                      ),
                      if (bikeIndex < selected.length - 1)
                        const Divider(height: 1, color: Color(0xFFF1F1F1)),
                    ],
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.fromLTRB(11, 11, 11, 12),
            decoration: cardDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ringkasan pembayaran',
                  style: TextStyle(fontSize: 12, color: Color(0xFF555555)),
                ),
                const SizedBox(height: 11),
                amountLine('Subtotal', subtotal),
                amountLine(
                  'Voucher SERVISH... ',
                  -voucher,
                  color: const Color(0xFF36A66A),
                ),
                amountLine('PPN 11%', tax),
                const Divider(height: 1, color: Color(0xFFECECEC)),
                const SizedBox(height: 7),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Total pembayaran',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF343434),
                        ),
                      ),
                    ),
                    Text(
                      'Rp${_invoiceMoney(payable)}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (mechanicSuggestionApproved) ...[
                  const SizedBox(height: 9),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1E6),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Text(
                      '+Rp75.000 tambahan pekerjaan disetujui',
                      style: TextStyle(fontSize: 8, color: orange),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 42,
                  child: OutlinedButton.icon(
                    onPressed: () => _toast('Unduh PDF belum tersedia.'),
                    icon: const Icon(Icons.download_outlined, size: 15),
                    label: const Text(
                      'Unduh PDF',
                      style: TextStyle(fontSize: 10),
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
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 42,
                  child: OutlinedButton.icon(
                    onPressed: () => _toast('Berbagi invoice belum tersedia.'),
                    icon: const Icon(Icons.share_outlined, size: 15),
                    label: const Text(
                      'Bagikan',
                      style: TextStyle(fontSize: 10),
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
              ),
            ],
          ),
          const SizedBox(height: 9),
          SizedBox(
            height: 44,
            child: FilledButton(
              onPressed: () => _rebuild(() => page = paymentComplete ? 11 : 9),
              style: FilledButton.styleFrom(
                backgroundColor: orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                paymentComplete ? 'Beri Rating & Ulasan' : 'Bayar Sekarang',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _invoiceMoney(int amount) => amount.abs().toString().replaceAllMapped(
    RegExp(r'(?=(\d{3})+(?!\d))'),
    (match) => '.',
  );
}
