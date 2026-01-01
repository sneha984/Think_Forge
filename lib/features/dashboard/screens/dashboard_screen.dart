import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:technical_test/core/constants/image_constants.dart';
import 'package:technical_test/shared/widgets/common_layout.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../model/trade_model.dart';
import '../../trade/screens/trade_history_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Map<String, List<double>> barData = {
    'W': [40, 30, 55, 20, 45, 35, 50],
    'M': [30, 65, 45, 25, 55, 48, 60],
    'Y': [20, 40, 30, 55, 70, 45, 80],
  };

  final Map<String, List<String>> barLabels = {
    'W': ['Mon', 'Tue', 'Wed', 'Thu'],
    'M': [
      'Jun',
      'July',
      'Aug',
      'Sep',
    ],
    'Y': ['2021', '2022', '2023', '2024'],
  };

  String selectedTimeframe = 'M';
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
      amount: -12.00,
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
  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return SafeArea(
      child: CommonLayout(
        currentIndex: 0,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: r.h(37),
                color: const Color(0xFF26E07F),
                child: Marquee(
                  text:
                      "Withdrawals • ✨ Secure Trading Wallet • ✨ Instant Deposits • 💸 Fast Withdrawals • ",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: r.sp(10),
                    fontWeight: FontWeight.w600,
                  ),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  blankSpace:
                      20.0,
                  velocity: 30.0,
                  pauseAfterRound: const Duration(seconds: 0),
                  startPadding: 10.0,
                  accelerationDuration: const Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: r.w(14),
                  vertical: r.h(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Balance",
                      style: GoogleFonts.inter(
                        fontSize: r.sp(13),
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: r.h(4)),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "\$ ",
                            style: GoogleFonts.inter(
                              fontSize: r.sp(18),
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: "5,231.89",
                            style: GoogleFonts.inter(
                              fontSize: r.sp(32), // Large size
                              fontWeight: FontWeight.bold,
                              color:
                                  Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: r.h(16)),
                    Row(
                      children: [
                        _actionBtn(
                          context,
                          r,
                          "Deposit",
                          ImageConstants.deposit,
                          Colors.white,
                          Colors.black,
                        ),
                        SizedBox(width: r.w(12)),
                        _actionBtn(
                          context,
                          r,
                          "Withdraw",
                          ImageConstants.withdraw,
                          AppColors.card,
                          Colors.white,
                        ),
                      ],
                    ),

                    SizedBox(height: r.h(20)),


                    SizedBox(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(r.w(12)),
                        child: Image.asset(
                          ImageConstants.banner,
                          fit:
                              BoxFit
                                  .cover,
                        ),
                      ),
                    ),

                    SizedBox(height: r.h(20)),

                    /// 🔹 Transactions Overview

                    _sectionCard(
                      r,
                      title: "Total Transactions Overview",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(r.w(10)),
                            decoration: BoxDecoration(
                              color: AppColors.card,
                              borderRadius: BorderRadius.circular(r.w(14)),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children:
                                          ['W', 'M', 'Y'].map((label) {
                                            return _chip(
                                              r,
                                              label,
                                              active:
                                                  selectedTimeframe == label,
                                              onTap:
                                                  () => setState(
                                                    () =>
                                                        selectedTimeframe =
                                                            label,
                                                  ),
                                            );
                                          }).toList(),
                                    ),

                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: List.generate(
                                        barData[selectedTimeframe]!.length,
                                        (index) {
                                          double val =
                                              barData[selectedTimeframe]![index];
                                          Color? barColor;
                                          if (index ==
                                              barData[selectedTimeframe]!
                                                      .length -
                                                  2) {
                                            barColor = const Color(0xFF26E07F);
                                          }
                                          if (index ==
                                              barData[selectedTimeframe]!
                                                      .length -
                                                  1) {
                                            barColor = const Color(0xFF9181F4);
                                          }

                                          return _bar(r, val, color: barColor);
                                        },
                                      ),
                                    ),
                                  ],
                                ),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: r.h(8),
                                      right: r.w(4),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children:
                                          barLabels[selectedTimeframe]!.map((
                                            labelText,
                                          ) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                left: r.w(12),
                                              ),
                                              child: Text(
                                                labelText,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: r.sp(10),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                ),

                                SizedBox(height: r.h(10)),

                                Text(
                                  "Transactions($selectedTimeframe)",
                                  style: GoogleFonts.inter(
                                    color: Colors.grey,
                                    fontSize: r.sp(12),
                                  ),
                                ),
                                Text(
                                  "\$556.89",
                                  style: GoogleFonts.inter(
                                    fontSize: r.sp(24),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: r.h(20)),

                          Row(
                            children: [
                              Expanded(
                                child: _statBox(
                                  r,
                                  label: "Referral",
                                  value: "+\$105.89",
                                  gradient: [
                                    const Color(0xFF9181F4),
                                    const Color(0xFF705AF8),
                                  ],
                                  labelColor: const Color(0xFF9181F4),
                                  icon: ImageConstants.referral,
                                ),
                              ),
                              SizedBox(width: r.w(12)),
                              Expanded(
                                child: _statBox(
                                  r,
                                  label: "Bonus",
                                  value: "+\$56.89",
                                  gradient: [
                                    const Color(0xFF26E07F),
                                    const Color(0xFF1CB062),
                                  ],
                                  labelColor: const Color(0xFF26E07F),
                                  icon: ImageConstants.bonus,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: r.h(20)),

                    Container(
                      padding: EdgeInsets.all(r.w(8)),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(r.w(14)),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Overall P/L",
                            style: GoogleFonts.inter(
                              fontSize: r.sp(17),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: r.h(10)),
                          _sectionCard(
                            r,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _plHeaderItem("MT51i92", r, "MT5 ID"),
                                    _plHeaderItem(
                                      "+\$200.00",
                                      r,
                                      "Floating pnl",
                                      valueColor: Colors.greenAccent,
                                    ),
                                    _plHeaderItem("22", r, "Open position"),
                                  ],
                                ),

                                SizedBox(height: r.h(17)),

                                ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 2,
                                  itemBuilder: (context, index) {
                                    final trade = trades[index];
                                    return _tradeTile(r, trade);
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: r.h(16)),

                          GestureDetector(
                            onTap:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const TradeHistoryScreen(),
                                  ),
                                ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: r.w(4),
                                right: r.w(4),
                              ),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  vertical: r.h(10),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "View All",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: r.sp(13),
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: r.h(14)),
                        ],
                      ),
                    ),

                    SizedBox(height: r.h(20)),

                    SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        ImageConstants.banner2,
                        fit: BoxFit.fitWidth,
                      ),
                    ),

                    SizedBox(height: r.h(20)),

                    SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        ImageConstants.banner1,
                        fit: BoxFit.fitWidth,
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
  }

  Widget _bar(Responsive r, double height, {Color? color}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
      margin: EdgeInsets.symmetric(horizontal: r.w(3)),
      width: r.w(14),
      height: r.h(height < 5 ? 5 : height),
      decoration: BoxDecoration(
        color: color ?? const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(r.w(4)),
      ),
    );
  }

  Widget _chip(
    Responsive r,
    String label, {
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: r.w(8)),
        padding: EdgeInsets.symmetric(horizontal: r.w(12), vertical: r.h(8)),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(r.w(8)),
          border: Border.all(
            color: active ? Colors.white24 : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: active ? Colors.white : Colors.grey,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
            fontSize: active ? r.w(14) : r.w(10),
          ),
        ),
      ),
    );
  }



  Widget _sectionCard(Responsive r, {String? title, required Widget child}) {
    return Container(
      padding: EdgeInsets.all(r.w(14)),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(r.w(14)),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: r.sp(17),
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(height: r.h(12)),
          ],
          child,
        ],
      ),
    );
  }

  Widget _actionBtn(
    BuildContext context,
    Responsive r,
    String title,
    String icon,
    Color bg,
    Color text,
  ) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: r.h(12)),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(r.w(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: r.w(18),
            ),
            SizedBox(width: r.w(8)),
            Text(
              title,
              style: GoogleFonts.inter(
                color: text,
                fontWeight:
                    FontWeight.w600,
                fontSize: r.sp(
                  14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statBox(
    Responsive r, {
    required String label,
    required String value,
    required List<Color> gradient,
    required Color labelColor,
    required String icon,
  }) {
    return Container(
      padding: EdgeInsets.all(r.w(14)),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(r.w(18)),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: r.w(44),
            height: r.w(44),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(r.w(12)),
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(r.w(12)),
              child: SvgPicture.asset(icon),
            ),
          ),
          SizedBox(height: r.h(4)),
          Text(
            label,
            style: GoogleFonts.inter(
              color: labelColor,
              fontSize: r.sp(12),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: r.h(4)),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: r.sp(20),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tradeTile(Responsive r, TradeData trade) {
    return Container(
      margin: EdgeInsets.only(bottom: r.h(10)),
      padding: EdgeInsets.symmetric(horizontal: r.w(12), vertical: r.h(14)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(r.w(12)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: r.w(6),
                        vertical: r.h(2),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(r.w(4)),
                      ),
                      child: Text(
                        trade.type,
                        style: GoogleFonts.inter(
                          fontSize: r.sp(10),
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: r.w(8)),
                    Text(
                      trade.pair,
                      style: GoogleFonts.inter(
                        fontSize: r.sp(14),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: r.h(6)),
                Text(
                  "SL:${trade.sl} TP:${trade.tp}",
                  style: GoogleFonts.robotoMono(
                    fontSize: r.sp(10),
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                trade.formattedAmount,
                style: GoogleFonts.robotoMono(
                  color: trade.color,
                  fontSize: r.sp(16),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: r.h(4)),
              Text(
                trade.lots,
                style: GoogleFonts.robotoMono(
                  fontSize: r.sp(10),
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _plHeaderItem(
    String val,
    Responsive r,
    String label, {
    Color? valueColor,
  }) {
    return Column(
      children: [
        Text(
          val,
          style: GoogleFonts.robotoMono(
            fontWeight: FontWeight.w600,
            color: valueColor ?? Colors.white,
            fontSize: r.sp(14).clamp(14.0, 22.0),
          ),
        ),
        SizedBox(
          height: r.h(4),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.grey,
            fontSize: r.sp(11).clamp(11.0, 16.0),
          ),
        ),
      ],
    );
  }

}
