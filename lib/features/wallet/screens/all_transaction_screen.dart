import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/image_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../model/transaction_model.dart';
import '../../../shared/widgets/common_layout.dart';

class AllTransactionsPage extends StatelessWidget {
  final Responsive r;
  final List<TransactionModel> transactions;

  const AllTransactionsPage({
    super.key,
    required this.r,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    final sortedTransactions = List<TransactionModel>.from(transactions)
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));

    final groupedTransactions = groupBy(
      sortedTransactions,
      (TransactionModel txn) => txn.formattedDate,
    );

    return CommonLayout(
      currentIndex: 1,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xff1D1D1F),
            borderRadius: BorderRadius.vertical(top: Radius.circular(r.w(32))),
          ),
          child: Column(
            children: [
              _buildSearchAndFilter(),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: r.w(13)),
                  itemCount: groupedTransactions.length,
                  itemBuilder: (context, index) {
                    String dateKey = groupedTransactions.keys.elementAt(index);
                    List<TransactionModel> dayTransactions =
                        groupedTransactions[dateKey]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: r.h(15)),
                          child: Text(
                            dateKey,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: r.sp(14),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        ...dayTransactions.map(
                          (txn) => GestureDetector(
                            onTap: () {
                              showTransactionReceipt(context, txn, r);
                            },
                            child: _txnTile(txn),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: r.h(85)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.w(18), vertical: r.h(10)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: r.h(45),
              padding: EdgeInsets.symmetric(horizontal: r.w(12)),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey, size: 20),
                  SizedBox(width: r.w(10)),
                  Text(
                    "Search Transactions",
                    style: GoogleFonts.inter(
                      color: Colors.grey,
                      fontSize: r.sp(13),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: r.w(10)),
          Container(
            height: r.h(45),
            width: r.w(45),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(Icons.filter_list, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _txnTile(TransactionModel txn) {
    bool isRejected = txn.status.toLowerCase() == "rejected";
    return Container(
      margin: EdgeInsets.only(bottom: r.h(8)),
      padding: EdgeInsets.symmetric(horizontal: r.w(10), vertical: r.h(12)),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(r.w(16)),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            height: r.w(40),
            width: r.w(40),
            padding: EdgeInsets.all(r.w(10)),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: txn.gradientColors,
              ),
            ),
            child: SvgPicture.asset(
              (txn.title == "Wallet deposit" || txn.title == "Wallet Withdraw")
                  ? ImageConstants.walletIcon
                  : txn.title == "Referral"
                  ? ImageConstants.referralcon
                  : ImageConstants.bonusIcon,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: r.w(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  txn.title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: r.sp(13),
                  ),
                ),
                Text(
                  txn.formattedDate,
                  style: GoogleFonts.inter(
                    color: Colors.grey[600],
                    fontSize: r.sp(10),
                  ),
                ),
              ],
            ),
          ),
          Text(
            txn.status,
            style: GoogleFonts.inter(
              color: isRejected ? const Color(0xFFFF4B4B) : Colors.white70,
              fontSize: r.sp(11),
            ),
          ),
          SizedBox(width: r.w(12)),
          Text(
            txn.amount,
            style: GoogleFonts.inter(
              color:
                  isRejected
                      ? Colors.white30
                      : (txn.amount.contains('+')
                          ? const Color(0xFF26E07F)
                          : Colors.white),
              fontWeight: FontWeight.bold,
              fontSize: r.sp(14),
            ),
          ),
        ],
      ),
    );
  }

  void showTransactionReceipt(
    BuildContext context,
    TransactionModel txn,
    Responsive r,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: r.w(20),
              vertical: r.h(25),
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1D1D1F), // Dark card color
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(r.w(32)),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(ImageConstants.success),

                SizedBox(height: r.h(15)),
                Text(
                  txn.title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: r.sp(18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: r.h(25)),

                // 🔹 Details Container
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(r.w(16)),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(r.w(16)),
                  ),
                  child: _receiptRow(
                    "To",
                    "Wallet (HDFC - 5375 **** **** 8544)",
                    r,
                  ),
                ),
                SizedBox(height: r.h(7)),

                _receiptInfoSection(r, [
                  _receiptRow("From", "Axis Bank - 5375 **** **** 2368", r),
                  _receiptRow("Txn Id", "TXN-9F7A2C1E-20250919", r),
                  _receiptRow("Note", "Investment funding", r),
                  _receiptRow(
                    "Status",
                    txn.status,
                    r,
                    statusColor:
                        txn.status == "Rejected" ? Colors.red : Colors.green,
                  ),
                  _receiptRow("Time and Date", txn.formattedDate, r),
                ]),

                SizedBox(height: r.h(20)),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(r.w(16)),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(r.w(16)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total",
                        style: GoogleFonts.inter(
                          color: Colors.grey,
                          fontSize: r.sp(12),
                        ),
                      ),
                      Text(
                        txn.amount.replaceAll('+', '').replaceAll('-', ''),
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: r.sp(30),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: r.h(20)),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: r.h(10)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Continue",
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: r.h(20)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _receiptInfoSection(Responsive r, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(r.w(16)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(r.w(16)),
      ),
      child: Column(children: children),
    );
  }

  Widget _receiptRow(
    String label,
    String value,
    Responsive r, {
    Color? statusColor,
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
              fontSize: r.sp(12),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.inter(
                color: statusColor ?? Colors.white,
                fontSize: r.sp(12),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
