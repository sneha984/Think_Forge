import 'package:go_router/go_router.dart';
import 'package:technical_test/features/ib/screens/ib_screen.dart';
import 'package:technical_test/features/support/screens/support_screen.dart';

import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/wallet/screens/all_transaction_screen.dart';
import '../../features/wallet/screens/wallet_screen.dart';
import '../../model/transaction_model.dart';
import '../utils/responsive.dart';

final appRouter = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/wallet',
      builder: (context, state) => WalletPage(r: Responsive(context)),
    ),
    GoRoute(
      path: '/ib',
      builder: (context, state) => IBScreen(r: Responsive(context)),
    ),
    GoRoute(
      path: '/support',
      builder: (context, state) => SupportScreen(r: Responsive(context)),
    ),
    GoRoute(
      path: '/all-transactions',
      builder: (context, state) {
        final transactions = state.extra as List<TransactionModel>;
        return AllTransactionsPage(
          r: Responsive(context),
          transactions: transactions,
        );
      },
    ),
  ],
);
