import 'package:funica/Screens/navbar/homebarscreens/wallet/all-transaction-details-screen.dart';
import 'package:funica/Screens/navbar/homebarscreens/wallet/transaction-lists.dart';
import 'package:funica/Screens/settings.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/controller/e-wallet-cont.dart';
import 'package:funica/widget/custom_appbar.dart';
import 'package:funica/widget/visa-card/visa-card.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final bool isDarkMode = themeController.isDarkMode;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDarkMode
                ? Brightness.light
                : Brightness.dark,
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness: isDarkMode
                ? Brightness.light
                : Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: kDynamicScaffoldBackground(context),
            appBar: GenericAppBar(
              title: "My E-Wallet",
             showSearch: true,
              onSearchChanged: (query) {
                Get.find<WalletController>().searchTransactions(query);
              },
              // onSearchCleared: () {
              //   Get.find<WalletController>().clearSearch();
              // },
              searchHint: "Search transactions...",
              onSettingsTap: () {
                Get.to(
                  const SettingsScreen(),
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 500),
                );
              },
            ),
            body: SafeArea(
              child: SingleChildScrollView(
  physics: const BouncingScrollPhysics(),
  child: Padding(
    padding: AppSizes.DEFAULT,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomVisaCard(
          name: 'Andrew Ainsley',
          cardNumber: '4629362001543629',
          balance: 9000000.0,
          onTopUp: () {},
        ),
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              text: 'Transaction History',
              size: 18,
              weight: FontWeight.bold,
              color: kDynamicText(context),
            ),
            Bounce(
              onTap: () => Get.to(
                const AllTransaction(),
                transition: Transition.cupertino,
                duration: const Duration(milliseconds: 500),
              ),
              child: MyText(
                text: 'See All',
                size: 14,
                weight: FontWeight.w600,
                color: kDynamicText(context),
              ),
            ),
          ],
        ),
        const Gap(10),
        GetBuilder<WalletController>(
          init: WalletController(),
          builder: (walletController) {
            final transactions = walletController.transactions.length >= 10
                ? walletController.transactions
                : _getExtendedTransactions(walletController.transactions);

            return WalletTransactionsList(
              transactions: transactions,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            );
          },
        ),
      ],
    ),
  ),
)

            ),
          ),
        );
      },
    );
  }

  // Helper method to extend transactions if less than 10
  List<TransactionModel> _getExtendedTransactions(
    List<TransactionModel> original,
  ) {
    if (original.length >= 10) return original;

    final extended = List<TransactionModel>.from(original);
    final sampleTransactions = [
      TransactionModel(
        title: 'Office Desk',
        date: DateTime(2024, 12, 11, 14, 30),
        amount: 250.0,
        type: TransactionType.order,
        icon: Assets.table,
      ),
      TransactionModel(
        title: 'Top Up Wallet',
        date: DateTime(2024, 12, 10, 11, 15),
        amount: 200.0,
        type: TransactionType.topUp,
        icon: Assets.walletfilled,
      ),
      TransactionModel(
        title: 'Bookshelf',
        date: DateTime(2024, 12, 9, 16, 45),
        amount: 180.0,
        type: TransactionType.order,
        icon: Assets.chair,
      ),
      TransactionModel(
        title: 'Desk Lamp',
        date: DateTime(2024, 12, 8, 13, 20),
        amount: 75.0,
        type: TransactionType.order,
        icon: Assets.lamp,
      ),
      TransactionModel(
        title: 'Top Up Wallet',
        date: DateTime(2024, 12, 7, 10, 0),
        amount: 350.0,
        type: TransactionType.topUp,
        icon: Assets.walletfilled,
      ),
      TransactionModel(
        title: 'Gaming Chair',
        date: DateTime(2024, 12, 6, 15, 30),
        amount: 320.0,
        type: TransactionType.order,
        icon: Assets.chair,
      ),
    ];

    // Add sample transactions until we reach at least 10
    int index = 0;
    while (extended.length < 10 && index < sampleTransactions.length) {
      extended.add(sampleTransactions[index]);
      index++;
    }

    // If still less than 10, duplicate some with modified dates
    if (extended.length < 10) {
      final needed = 10 - extended.length;
      for (int i = 0; i < needed; i++) {
        final originalItem = extended[i % extended.length];
        extended.add(
          TransactionModel(
            title: originalItem.title,
            date: originalItem.date.subtract(Duration(days: i + 7)),
            amount: originalItem.amount + (i * 10).toDouble(),
            type: originalItem.type,
            icon: originalItem.icon,
          ),
        );
      }
    }

    return extended;
  }
}
