import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:technical_test/core/constants/image_constants.dart';
import 'package:technical_test/shared/widgets/common_layout.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../model/bank_model.dart';
import '../../../model/crypto_address_model.dart';
import '../../../model/transaction_model.dart';

class WalletPage extends StatelessWidget {
  final Responsive r;

  const WalletPage({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      currentIndex: 1,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: r.w(11)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: r.h(20)),
            _accountDropdown(r, "MT51i92"),
            SizedBox(height: r.h(15)),

            _buildBalanceSection(),
            SizedBox(height: r.h(20)),
            _buildActionButtons(context),
            SizedBox(height: r.h(30)),
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
                  _sectionHeader("My MT5 Accounts"),
                  SizedBox(height: r.h(12)),
                  _buildMT5List(),

                  SizedBox(height: r.h(25)),

                  _sectionHeader("My Bank Accounts"),
                  SizedBox(height: r.h(12)),
                  _buildBankList(),

                  SizedBox(height: r.h(25)),

                  _sectionHeader("My Crypto Address"),
                  SizedBox(height: r.h(12)),
                  _buildCryptoList(),
                ],
              ),
            ),
            SizedBox(height: r.h(17)),

            _buildTransactionsOverview(context),
            SizedBox(height: r.h(100)),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Your Balance",
          style: GoogleFonts.inter(color: Colors.grey, fontSize: r.sp(13)),
        ),
        SizedBox(height: r.h(2)),
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
                  fontSize: r.sp(32),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Text(
          "Unassigned amount in wallet : \$345.09",
          style: GoogleFonts.inter(color: Colors.grey[600], fontSize: r.sp(13)),
        ),
      ],
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

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        _actionBtn(ImageConstants.deposit, "Deposit", isPrimary: true),
        SizedBox(width: r.w(10)),

        _actionBtn(ImageConstants.withdraw, "Withdraw"),
        SizedBox(width: r.w(10)),

        Expanded(
          child: GestureDetector(
            onTap: () {
              showTransferBottomSheet(context, r);
            },
            child: _actionBtn(
              ImageConstants.transfer,
              "Transfer",
              isExpandedInternal: true,
            ),
          ),
        ),
        // _actionBtn(ImageConstants.transfer, "Transfer"),
      ],
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

  Widget _actionBtn(
    String icon,
    String label, {
    bool isPrimary = false,
    bool isExpandedInternal = false,
  }) {
    Widget content = Container(
      padding: EdgeInsets.symmetric(vertical: r.h(12), horizontal: r.w(10)),
      decoration: BoxDecoration(
        color: isPrimary ? Colors.white : const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon, width: r.w(13)),
          SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              color: isPrimary ? Colors.black : Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: r.sp(12),
            ),
          ),
        ],
      ),
    );

    return isExpandedInternal ? content : Expanded(child: content);
  }

  Widget _sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: r.sp(15),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: r.w(7)),
        const Icon(Icons.more_horiz, color: Colors.white),
      ],
    );
  }

  Widget _accountDropdown(Responsive r, String accountId) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      offset: const Offset(0, 40), // Positions the menu below the button
      color: const Color(0xFF1D1D1F), // Dark menu background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      // 🔹 The "Button" UI from your image
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: r.w(12), vertical: r.h(6)),
        decoration: BoxDecoration(
          color: const Color(0xFF262626), // The specific grey from your image
          borderRadius: BorderRadius.circular(r.w(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              accountId,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: r.sp(12).clamp(12.0, 16.0),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: r.w(4)),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white.withOpacity(0.5),
              size: r.w(16).clamp(16.0, 22.0),
            ),
          ],
        ),
      ),
      // 🔹 The actual list items
      itemBuilder:
          (context) => [
            _buildPopupItem(r, "MT51i92"),
            _buildPopupItem(r, "MT51i95"),
            _buildPopupItem(r, "MT51i99"),
          ],
      onSelected: (value) {
        // Handle your logic here
      },
    );
  }

  PopupMenuItem<String> _buildPopupItem(Responsive r, String value) {
    return PopupMenuItem<String>(
      value: value,
      child: Text(
        value,
        style: GoogleFonts.inter(color: Colors.white, fontSize: r.sp(13)),
      ),
    );
  }

  Widget _buildMT5List() {
    return SizedBox(
      height: r.h(90),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _mt5Card("Demo", "MT51192", "+\$5,325.57"),
          SizedBox(width: r.w(12)),
          _mt5Card("Live", "MT51192", "+\$5,325.57", isLive: true),
        ],
      ),
    );
  }

  Widget _mt5Card(
    String type,
    String id,
    String amount, {
    bool isLive = false,
  }) {
    return Container(
      width: r.w(155),

      padding: EdgeInsets.all(r.w(10)),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(r.w(18)),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                type,
                style: GoogleFonts.inter(color: Colors.white, fontSize: 13),
              ),
              if (isLive) ...[
                SizedBox(width: 4),
                const Icon(Icons.circle, color: Colors.green, size: 6),
              ],
            ],
          ),
          SizedBox(height: r.h(2)),

          // const Spacer(),
          Text(
            id,
            style: GoogleFonts.inter(color: Colors.indigo[300], fontSize: 10),
          ),

          const Spacer(),
          Text(
            amount,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankList() {
    final List<BankAccount> banks = [
      BankAccount(
        name: "Axis Bank",
        number: "5375 **** **** 2388",
        color: const Color(0xFF26E07F),
      ),
      BankAccount(
        name: "ICICI",
        number: "5375 **** **** 2388",
        color: const Color(0xFF3B82F6),
      ),
      BankAccount(
        name: "HDFC",
        number: "1234 **** **** 5678",
        color: const Color(0xFF6366F1),
      ),
    ];

    return SizedBox(
      height: r.h(105),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: banks.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final bank = banks[index];
          return Padding(
            padding: EdgeInsets.only(
              right: index == banks.length - 1 ? 0 : r.w(12),
            ),
            child: _bankCard(bank.name, bank.number, bank.color),
          );
        },
      ),
    );
  }

  Widget _bankCard(String name, String number, Color color) {
    return Container(
      width: r.w(155),
      padding: EdgeInsets.all(r.w(12)),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: r.sp(13),
                  ),
                ),
              ),
              const Icon(Icons.more_vert, color: Colors.white, size: 14),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                number,
                style: GoogleFonts.inter(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: r.sp(10),
                  letterSpacing: 1.1,
                ),
              ),
              Text(
                "India",
                style: GoogleFonts.inter(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: r.sp(10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCryptoList() {
    final List<CryptoAddress> addresses = [
      CryptoAddress(network: "TRC20", address: "TQ9aC9...Lx3p9z"),
      CryptoAddress(network: "TRC20", address: "0x4e9c...d28a67"),
      CryptoAddress(network: "ERC20", address: "0x71C7...d52a11"),
    ];

    return SizedBox(
      height: r.h(85),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: addresses.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final crypto = addresses[index];
          return Padding(
            padding: EdgeInsets.only(
              right: index == addresses.length - 1 ? 0 : r.w(12),
            ),
            child: _cryptoCard(crypto.network, crypto.address),
          );
        },
      ),
    );
  }

  Widget _cryptoCard(String network, String address) {
    return Container(
      width: r.w(155),
      padding: EdgeInsets.all(r.w(12)),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            network,
            style: GoogleFonts.inter(
              color: Colors.indigo[300],
              fontSize: r.sp(10),
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            address,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: r.sp(13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsOverview(BuildContext context) {
    final List<TransactionModel> transactions = [
      TransactionModel(
        title: "Wallet deposit",
        dateTime: DateTime(2025, 5, 23, 19, 27),
        amount: "+\$21,282",
        status: 'Approved',
      ),
      TransactionModel(
        title: "Wallet Withdraw",
        dateTime: DateTime(2025, 7, 20, 19, 27),
        amount: "-\$21,282",
        status: 'Approved',
      ),
      TransactionModel(
        title: "Referral",
        dateTime: DateTime(2025, 5, 23, 19, 27),
        amount: "+\$21,282",
        status: 'Approved',
      ),
      TransactionModel(
        title: "Bonus",
        dateTime: DateTime(2025, 5, 23, 19, 27),
        amount: "+\$21,282",
        status: 'Approved',
      ),
      TransactionModel(
        title: "Wallet deposit",
        status: "Rejected",
        amount: "+\$21,282",
        dateTime: DateTime.now(),
      ),
      TransactionModel(
        title: "Wallet deposit",
        status: "Rejected",
        amount: "+\$21,282",
        dateTime: DateTime(2025, 8, 1, 19, 27),
      ),
      TransactionModel(
        title: "Wallet deposit",
        status: "Rejected",
        amount: "+\$21,282",
        dateTime: DateTime.now(),
      ),
    ];

    return Container(
      padding: EdgeInsets.all(r.w(8)),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(r.w(14)),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: r.w(4)),
            child: Text(
              "Total Transactions Overview",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: r.sp(16),
              ),
            ),
          ),
          SizedBox(height: r.h(15)),

          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length > 5 ? 5 : transactions.length,
            itemBuilder: (context, index) {
              return _txnTile(transactions[index], context);
            },
          ),

          SizedBox(height: r.h(10)),

          GestureDetector(
            onTap: () {
              context.push('/all-transactions', extra: transactions);
            },

            child: Padding(
              padding: EdgeInsets.only(left: r.w(4), right: r.w(4)),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: r.h(10)),
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

          SizedBox(height: r.h(20)),
        ],
      ),
    );
  }

  Widget _txnTile(TransactionModel txn, BuildContext context) {
    bool isRejected = txn.status.toLowerCase() == "rejected";

    return GestureDetector(
      onTap: () {
        showTransactionReceipt(context, txn, r);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: r.h(8)),
        padding: EdgeInsets.symmetric(horizontal: r.w(8), vertical: r.h(11)),
        decoration: BoxDecoration(
          color: const Color(0xFF161616),
          borderRadius: BorderRadius.circular(r.w(16)),
          border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
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
                (txn.title == "Wallet deposit" ||
                        txn.title == "Wallet Withdraw")
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
                      fontSize: r.sp(12.4),
                    ),
                  ),
                  Text(
                    txn.formattedDate,
                    style: GoogleFonts.inter(
                      color: Colors.grey[600],
                      fontSize: r.sp(9),
                    ),
                  ),
                ],
              ),
            ),

            Text(
              txn.status,
              style: GoogleFonts.inter(
                color: isRejected ? const Color(0xFFFF4B4B) : Colors.white70,
                fontSize: r.sp(11.2),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: r.w(14)),

            Text(
              txn.amount,
              style: GoogleFonts.inter(
                color:
                    isRejected
                        ? Colors.white.withOpacity(0.4)
                        : (txn.amount.contains('+')
                            ? const Color(0xFF26E07F)
                            : Colors.white),
                fontWeight: FontWeight.w500,
                fontSize: r.sp(13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showTransferBottomSheet(BuildContext context, Responsive r) {
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
              color: const Color(0xFF1D1D1F),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(r.w(32)),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Enter Amount to be transferred",
                    style: GoogleFonts.inter(
                      color: Colors.grey,
                      fontSize: r.sp(14),
                    ),
                  ),
                  SizedBox(height: r.h(10)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "\$ ",
                        style: GoogleFonts.inter(
                          color: Colors.grey,
                          fontSize: r.sp(24),
                        ),
                      ),
                      Text(
                        "2000",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: r.sp(48),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Converted value will be 1,77,371.80 INR",
                    style: GoogleFonts.inter(
                      color: Colors.grey[700],
                      fontSize: r.sp(12),
                    ),
                  ),
                  SizedBox(height: r.h(20)),

                  _transferInputBox(
                    r,
                    Icons.edit_note,
                    "Type Note to be sent (Optional)",
                  ),
                  SizedBox(height: r.h(10)),
                  _transferInputBox(
                    r,
                    null,
                    "Select Recipient wallet",
                    isDropdown: true,
                  ),

                  SizedBox(height: r.h(20)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: _accountBox(
                          r,
                          title: "Your Account",
                          name: "Alicia Koch",
                          imageUrl:
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPiL7GlLRETCiH5r9zphJ08h00jMX_3mKnLA&s",
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: r.w(4)),
                        child: Container(
                          padding: EdgeInsets.all(r.w(8)),
                          decoration: const BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            size: r.w(16),
                            color: const Color(0xFF00C077),
                          ),
                        ),
                      ),

                      Expanded(
                        child: _accountBox(
                          r,
                          title: "WLT 287292",
                          name: "James McGee",
                          imageUrl:
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTT7evQ00kM-3YUtrYYgxEI8edIC98F0Pe-A&s",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: r.h(25)),
                  Container(
                    padding: EdgeInsets.all(r.w(16)),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(r.w(16)),
                    ),
                    child: _metaRow("Type", "MT5 Transfer", r),
                  ),
                  SizedBox(height: r.h(4)),

                  _metaInfoSection(r, [
                    _metaRow("Sender ID", "WLT-2929292", r),
                    _metaRow("Recipient ID", "WLT-9829653", r),
                  ]),

                  SizedBox(height: r.h(30)),

                  Container(
                    width: double.infinity,
                    height: r.h(55),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00FFA3),
                      borderRadius: BorderRadius.circular(r.w(30)),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            "Swipe to Transfer",
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: r.sp(14),
                            ),
                          ),
                        ),
                        Positioned(
                          left: r.w(5),
                          top: r.h(5),
                          bottom: r.h(5),
                          child: Container(
                            width: r.w(45),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: r.h(15)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _transferInputBox(
    Responsive r,
    IconData? icon,
    String hint, {
    bool isDropdown = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: r.w(15), vertical: r.h(12)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(r.w(12)),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon, color: Colors.grey, size: r.w(20)),
          if (icon != null) SizedBox(width: r.w(10)),
          Expanded(
            child: Text(
              hint,
              style: TextStyle(color: Colors.grey, fontSize: r.sp(13)),
            ),
          ),
          if (isDropdown) const Icon(Icons.unfold_more, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _accountBox(
    Responsive r, {
    required String title,
    required String name,
    required String imageUrl,
  }) {
    return Container(
      height: r.h(125),
      padding: EdgeInsets.symmetric(horizontal: r.w(8)),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D0D),
        borderRadius: BorderRadius.circular(r.w(16)),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: r.w(22),
            backgroundImage: CachedNetworkImageProvider(imageUrl),
          ),
          SizedBox(height: r.h(8)),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: r.sp(13),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: Colors.grey[600],
              fontSize: r.sp(10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _metaInfoSection(Responsive r, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(r.w(16)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(r.w(16)),
      ),
      child: Column(children: children),
    );
  }

  Widget _metaRow(String label, String value, Responsive r) {
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
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: r.sp(12),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
