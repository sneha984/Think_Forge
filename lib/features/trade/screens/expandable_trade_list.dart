import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/responsive.dart';
import '../../../model/trade_model.dart';

class TradeExpansionTile extends StatelessWidget {
  final Responsive r;
  final TradeData trade;

  const TradeExpansionTile({super.key, required this.r, required this.trade});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: r.h(10)),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(r.w(16)),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          iconTheme: IconThemeData(size: r.w(24).clamp(24.0, 32.0)),
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(
            horizontal: r.w(14),
            vertical: r.h(8),
          ),
          iconColor: Colors.white,
          collapsedIconColor: Colors.grey,
          title: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trade.pair,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: r.sp(14).clamp(14.0, 20.0),
                      ),
                    ),
                    Text(
                      trade.type.toUpperCase(),
                      style: GoogleFonts.inter(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: r.sp(10).clamp(10.0, 14.0),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  trade.units,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: r.sp(13).clamp(13.0, 18.0),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  trade.currentPrice,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: r.sp(13).clamp(13.0, 18.0),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  trade.formattedAmount,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: trade.color,
                    fontWeight: FontWeight.bold,
                    fontSize: r.sp(13).clamp(13.0, 18.0),
                  ),
                ),
              ),
            ],
          ),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(r.w(16), 0, r.w(16), r.h(16)),
              child: Column(
                children: [
                  const Divider(color: Colors.white10),
                  SizedBox(height: r.h(8)),
                  _expandedRow("Open Price", "\$${trade.openPrice}"),
                  _expandedRow("Stop Loss", trade.sl),
                  _expandedRow("Take Profit", trade.tp),
                  _expandedRow(
                    "Swap",
                    trade.swap,
                    valueColor:
                        trade.swap.startsWith('+')
                            ? const Color(0xFF26E07F)
                            : Colors.white,
                  ),
                  SizedBox(height: r.h(8)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      trade.lots,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: r.sp(11),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _expandedRow(
    String label,
    String value, {
    Color valueColor = Colors.white,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: r.h(6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.grey[600],
              fontSize: r.sp(13),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: valueColor,
              fontSize: r.sp(13),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
