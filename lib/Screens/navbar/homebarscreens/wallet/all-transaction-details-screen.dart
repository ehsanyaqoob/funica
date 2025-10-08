// screens/all_transactions.dart
import 'package:funica/Screens/navbar/homebarscreens/wallet/transaction-lists.dart';
import 'package:funica/Screens/settings.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/controller/e-wallet-cont.dart';
import 'package:funica/widget/custom_appbar.dart';

class AllTransaction extends StatelessWidget {
  const AllTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final bool isDarkMode = themeController.isDarkMode;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: kDynamicScaffoldBackground(context),
            appBar: GenericAppBar(
              title: "Transactions",
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
              child: GetBuilder<WalletController>(
                builder: (walletController) {
                  final transactions = walletController.transactions;
                  final hasSearchResults = walletController.transactions.isNotEmpty;
                  
                  return Column(
                    children: [
                      // Header Section
                      Container(
                        width: double.infinity,
                        padding: AppSizes.DEFAULT,
                        decoration: BoxDecoration(
                          color: kDynamicScaffoldBackground(context),
                          border: Border(
                            bottom: BorderSide(
                              color: kDynamicBorder(context).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: 'All Transactions',
                              size: 18,
                              weight: FontWeight.w600,
                              color: kDynamicText(context),
                            ),
                            const Gap(8),
                            MyText(
                              text: hasSearchResults 
                                  ? '${transactions.length} transactions found'
                                  : 'No transactions found',
                              size: 14,
                              color: kDynamicSubtitleText(context),
                            ),
                          ],
                        ),
                      ),

                      // Transactions List
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: AppSizes.DEFAULT.left,
                            right: AppSizes.DEFAULT.right,
                            bottom: AppSizes.DEFAULT.bottom,
                          ),
                          child: WalletTransactionsList(
                            transactions: transactions,
                            shrinkWrap: false,
                            physics: const BouncingScrollPhysics(),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}