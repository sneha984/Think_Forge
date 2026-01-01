import 'dart:ui';

class TradeData {
  final String type;
  final String pair;
  final double amount;
  final String units;
  final String currentPrice;
  final String openPrice;
  final String sl;
  final String tp;
  final String lots;
  final String swap;

  TradeData({
    required this.type,
    required this.pair,
    required this.amount,
    required this.units,
    required this.currentPrice,
    required this.openPrice,
    required this.sl,
    required this.tp,
    required this.lots,
    required this.swap,
  });

  Color get color =>
      type.toLowerCase() == "buy"
          ? const Color(0xFF26E07F)
          : const Color(0xFFFF4B4B);

  String get formattedAmount {
    String sign = amount >= 0 ? "+" : "";
    return "$sign\$${amount.toStringAsFixed(2)}";
  }
}
