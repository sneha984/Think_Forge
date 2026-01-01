import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart'; // Add this to pubspec.yaml
import 'package:google_fonts/google_fonts.dart';
import 'package:technical_test/shared/widgets/common_layout.dart';

import '../../../core/utils/responsive.dart';
import '../../../model/trade_model.dart';
import 'expandable_trade_list.dart';

class TradeHistoryScreen extends StatelessWidget {
  const TradeHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TradeData> trades = [
      TradeData(
        type: "Buy",
        pair: "USDXAU",
        units: "100",
        currentPrice: "100.00",
        amount: 244.00,
        openPrice: "122.00",
        sl: "14.00",
        tp: "44.00",
        swap: "+\$20.00",
        lots: "10.00 × 2.47 lots",
      ),
      TradeData(
        type: "Sell",
        pair: "USDXEUR",
        units: "150",
        currentPrice: "150.00",
        amount: 12.00,
        openPrice: "140.00",
        sl: "5.00",
        tp: "20.00",
        swap: "-\$5.00",
        lots: "5.00 × 1.20 lots",
      ),
      TradeData(
        type: "Buy",
        pair: "USDXJPY",
        units: "200",
        currentPrice: "200.00",
        amount: 45.00,
        openPrice: "190.00",
        sl: "10.00",
        tp: "50.00",
        swap: "+\$15.00",
        lots: "2.00 × 0.05 lots",
      ),
      TradeData(
        type: "Sell",
        pair: "USDXEUR",
        units: "150",
        currentPrice: "150.00",
        amount: 12.00,
        openPrice: "140.00",
        sl: "5.00",
        tp: "20.00",
        swap: "-\$5.00",
        lots: "5.00 × 1.20 lots",
      ),
      TradeData(
        type: "Buy",
        pair: "USDXJPY",
        units: "200",
        currentPrice: "200.00",
        amount: 45.00,
        openPrice: "190.00",
        sl: "10.00",
        tp: "50.00",
        swap: "+\$15.00",
        lots: "2.00 × 0.05 lots",
      ),
      TradeData(
        type: "Sell",
        pair: "USDXEUR",
        units: "150",
        currentPrice: "150.00",
        amount: 12.00,
        openPrice: "140.00",
        sl: "5.00",
        tp: "20.00",
        swap: "-\$5.00",
        lots: "5.00 × 1.20 lots",
      ),
      TradeData(
        type: "Buy",
        pair: "USDXJPY",
        units: "200",
        currentPrice: "200.00",
        amount: 45.00,
        openPrice: "190.00",
        sl: "10.00",
        tp: "50.00",
        swap: "+\$15.00",
        lots: "2.00 × 0.05 lots",
      ),
    ];
    final r = Responsive(context);

    return CommonLayout(
      currentIndex: 0,
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: r.w(20),
                  vertical: r.h(20),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _summaryColumn(
                              r,
                              "Floating pnl",
                              "+200.00",
                              const Color(0xFF26E07F),
                              isLarge: true,
                            ),
                            SizedBox(height: r.h(16)),
                            _summaryColumn(
                              r,
                              "Margin :",
                              "20.00",
                              Colors.white,
                              isLarge: true,
                            ),
                            SizedBox(height: r.h(16)),
                            _summaryColumn(
                              r,
                              "Open positions :",
                              "10",
                              Colors.white,
                              isNumericOnly: true,
                              isLarge: true,
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 1,
                        color: Colors.white10,
                        margin: EdgeInsets.symmetric(horizontal: r.w(15)),
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _summaryColumn(
                              r,
                              "Net realized pnl",
                              "-200.00",
                              const Color(0xFFFF4B4B),
                              isLarge: true,
                              alignEnd: true,
                            ),
                            SizedBox(height: r.h(16)),
                            _summaryColumn(
                              r,
                              "Free margin",
                              "20.00",
                              Colors.white,
                              alignEnd: true,
                              isLarge: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(r.w(16)),
                  decoration: BoxDecoration(
                    color: const Color(0xff1D1D1F),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(r.w(32)),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: r.h(45),
                              padding: EdgeInsets.symmetric(
                                horizontal: r.w(12),
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1A1A),
                                borderRadius: BorderRadius.circular(r.w(12)),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.05),
                                ),
                              ),
                              child: TextField(
                                style: GoogleFonts.inter(color: Colors.white),
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                    size: r.w(20).clamp(20.0, 28.0),
                                  ),
                                  hintText: "Search Investments",
                                  hintStyle: GoogleFonts.inter(
                                    color: Colors.grey,
                                    fontSize: r.sp(14),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    bottom: r.h(10),
                                  ),

                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: r.w(10)),
                          _filterIcon(r),
                        ],
                      ),
                      SizedBox(height: r.h(20)),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: r.w(10)),
                        child: Row(
                          children: [
                            Expanded(flex: 3, child: _headerTxt(r, "Symbol")),
                            Expanded(
                              flex: 2,
                              child: _headerTxt(
                                r,
                                "Units",
                                align: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: _headerTxt(
                                r,
                                "Current Price",
                                align: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: _headerTxt(
                                r,
                                "Floating P/L",
                                align: TextAlign.end,
                              ),
                            ),
                            SizedBox(width: r.w(30)),
                          ],
                        ),
                      ),
                      SizedBox(height: r.h(10)),

                      /// 🔹 ANIMATED EXPANDABLE LIST
                      Expanded(
                        child: AnimationLimiter(
                          child: ListView.builder(
                            padding: EdgeInsets.only(bottom: r.h(80)),
                            itemCount: trades.length,
                            itemBuilder: (context, index) {
                              final data = trades[index];

                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 500),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: TradeExpansionTile(
                                      r: r,
                                      trade: data,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Positioned(bottom: 20, left: 20, right: 20, child: _bottomNav(r)),
        ],
      ),
    );
  }

  Widget _summaryColumn(
    Responsive r,
    String label,
    String value,
    Color valueColor, {
    bool isLarge = false,
    bool isNumericOnly = false,
    bool alignEnd = false,
  }) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(color: Colors.grey, fontSize: r.sp(12)),
        ),
        SizedBox(height: r.h(4)),
        Text.rich(
          textAlign: alignEnd ? TextAlign.end : TextAlign.start,
          TextSpan(
            children: [
              if (!isNumericOnly)
                TextSpan(
                  text: "\$",
                  style: GoogleFonts.robotoMono(
                    fontSize: r.sp(isLarge ? 28 : 18),

                    color: const Color(0xFF666666),
                  ),
                ),

              TextSpan(
                text: value,
                style: GoogleFonts.robotoMono(
                  color: valueColor,
                  fontSize: r.sp(isLarge ? 28 : 18),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _filterIcon(Responsive r) {
    return Container(
      height: r.h(45).clamp(45.0, 60.0),
      width: r.h(45).clamp(45.0, 60.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(r.w(12)),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Icon(
        Icons.tune,
        color: Colors.white,
        size: r.w(20).clamp(20.0, 28.0),
      ),
    );
  }

  Widget _headerTxt(
    Responsive r,
    String t, {
    TextAlign align = TextAlign.start,
  }) => Text(
    t,
    textAlign: align,
    style: TextStyle(color: Colors.grey, fontSize: r.sp(10)),
  );

  Widget _bottomNav(Responsive r) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: r.h(10), horizontal: r.w(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(r.w(40)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navItem(Icons.home_outlined, "Home", true),
          _navItem(Icons.account_balance_wallet_outlined, "Wallet", false),
          _navItem(Icons.chat_bubble_outline, "Support", false),
          _navItem(Icons.people_outline, "IB", false),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? Colors.black : Colors.grey),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.black : Colors.grey,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
