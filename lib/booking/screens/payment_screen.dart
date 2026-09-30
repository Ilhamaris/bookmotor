part of '../booking_shell.dart';

extension _PaymentScreen on _BookingShellState {
  Widget _paymentScreen() {
    final voucher = invoiceVoucher;
    final payable = invoiceTotal;

    final methods = [
      ('Bayar di Bengkel', 'Tunai atau kartu di kasir', Icons.map_outlined),
      ('Transfer VA', 'Konfirmasi otomatis', Icons.receipt_long_outlined),
      ('E-Wallet', 'Konfirmasi otomatis', Icons.more_horiz),
      ('QRIS', 'Semua aplikasi pembayaran', Icons.qr_code_2_rounded),
    ];

    String money(int amount) => amount.toString().replaceAllMapped(
      RegExp(r'(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );

    return Container(
      color: const Color(0xFFFCFBFB),
      child: Column(
        children: [
          SizedBox(
            height: 52,
            child: Row(
              children: [
                IconButton(
                  tooltip: 'Kembali ke invoice',
                  onPressed: () => _rebuild(() => page = 8),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints.tightFor(
                    width: 48,
                    height: 48,
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Pembayaran',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Lainnya',
                  onPressed: () => _toast('Tidak ada tindakan lain.'),
                  icon: const Icon(Icons.more_horiz, size: 22),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints.tightFor(
                    width: 48,
                    height: 48,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(22, 14, 22, 20),
              children: [
                const Text(
                  'Pilih metode pembayaran',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Selesaikan pembayaran invoice servis.',
                  style: TextStyle(fontSize: 13, color: Color(0xFF73737B)),
                ),
                const SizedBox(height: 20),
                ...methods.map((method) {
                  final selectedMethod = paymentMethod == method.$1;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      key: ValueKey('payment-method-${method.$1}'),
                      borderRadius: BorderRadius.circular(13),
                      onTap: () => _rebuild(() => paymentMethod = method.$1),
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 52),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: selectedMethod
                              ? const Color(0xFFFFF1E6)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(
                            color: selectedMethod
                                ? orange
                                : const Color(0xFFE5E5E5),
                            width: selectedMethod ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selectedMethod
                                      ? orange
                                      : const Color(0xFFBDBDBD),
                                  width: selectedMethod ? 4 : 1,
                                ),
                              ),
                            ),
                            const SizedBox(width: 9),
                            Icon(method.$3, color: orange, size: 19),
                            const SizedBox(width: 9),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    method.$1,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    method.$2,
                                    style: const TextStyle(
                                      fontSize: 9,
                                      color: Color(0xFF8A8A8A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 10),
                const Text(
                  'Kode voucher',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 7),
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          key: const ValueKey('payment-voucher-code'),
                          initialValue: paymentVoucherCode,
                          textCapitalization: TextCapitalization.characters,
                          onChanged: (value) => paymentVoucherCode = value,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 11,
                            ),
                            border: InputBorder.none,
                            hintText: 'Masukkan kode voucher',
                            hintStyle: TextStyle(fontSize: 10),
                          ),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 48,
                        child: FilledButton(
                          onPressed: () {
                            final valid =
                                paymentVoucherCode.trim().toUpperCase() ==
                                'SERVISHEMAT';
                            _rebuild(() => paymentVoucherApplied = valid);
                            _toast(
                              valid
                                  ? 'Voucher berhasil diterapkan.'
                                  : 'Kode voucher tidak valid.',
                            );
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: orange,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(11),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Terapkan',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  paymentVoucherApplied
                      ? 'Voucher SERVISHEMAT aktif · Hemat Rp${money(voucher)}'
                      : 'Masukkan kode SERVISHEMAT untuk mendapat potongan.',
                  style: TextStyle(
                    fontSize: 9,
                    color: paymentVoucherApplied
                        ? const Color(0xFF2E9D5B)
                        : const Color(0xFF777777),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(14, 13, 14, 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7DC),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total pembayaran',
                        style: TextStyle(fontSize: 10, color: ink),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Rp${money(payable)}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Sudah termasuk PPN 11%.',
                        style: TextStyle(fontSize: 8, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(22, 12, 22, 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(20),
                  blurRadius: 14,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Rp${money(payable)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        paymentMethod,
                        style: const TextStyle(
                          fontSize: 9,
                          color: Color(0xFF777777),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 48,
                  child: FilledButton.icon(
                    onPressed: () => _rebuild(() {
                      paymentComplete = true;
                      page = 10;
                    }),
                    iconAlignment: IconAlignment.end,
                    icon: const Icon(Icons.chevron_right, size: 20),
                    label: const Text(
                      'Bayar Sekarang',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: orange,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
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

  Widget _paymentSuccessScreen() {
    final formattedTotal = invoiceTotal.toString().replaceAllMapped(
      RegExp(r'(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );

    return Container(
      color: const Color(0xFFFCFBFB),
      child: Column(
        children: [
          SizedBox(
            height: 52,
            child: Row(
              children: [
                IconButton(
                  tooltip: 'Kembali',
                  onPressed: () => _rebuild(() => page = 9),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints.tightFor(
                    width: 48,
                    height: 48,
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Pembayaran',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Lainnya',
                  onPressed: () => _toast('Tidak ada tindakan lain.'),
                  icon: const Icon(Icons.more_horiz, size: 22),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints.tightFor(
                    width: 48,
                    height: 48,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(18, 34, 18, 24),
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
                  'Pembayaran Berhasil',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Pembayaranmu telah diterima dan invoice sudah diperbarui.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 9, color: Color(0xFF85858B)),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFFF9A5C)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TOTAL PEMBAYARAN',
                        style: TextStyle(fontSize: 8, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rp$formattedTotal',
                        style: const TextStyle(
                          fontSize: 19,
                          color: orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(height: 14, color: Color(0xFFECECEC)),
                      Text(
                        '$paymentMethod · $date Juni 2026, $time WIB',
                        style: const TextStyle(
                          fontSize: 8,
                          color: Color(0xFF777777),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'ID Transaksi: PAY-8491037',
                        style: TextStyle(fontSize: 8, color: Color(0xFF777777)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 44,
                  child: FilledButton(
                    onPressed: () => _rebuild(() => page = 8),
                    style: FilledButton.styleFrom(
                      backgroundColor: orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Lihat Invoice',
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
}
