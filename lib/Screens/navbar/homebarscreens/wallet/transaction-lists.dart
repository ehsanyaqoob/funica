// widgets/transaction-lists.dart
import 'package:funica/constants/export.dart';
import 'package:funica/controller/e-wallet-cont.dart';

class WalletTransactionsList extends StatelessWidget {
  final List<TransactionModel> transactions;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const WalletTransactionsList({
    super.key,
    required this.transactions,
    this.shrinkWrap = true,
    this.physics = const NeverScrollableScrollPhysics(),
  });

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: transactions.length,
      separatorBuilder: (_, __) => const Divider(thickness: 0.7, height: 24),
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return _TransactionItem(transaction: transaction);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.walletfilled,
            height: 80,
            width: 80,
            colorFilter: ColorFilter.mode(
              kDynamicSubtitleText(Get.context!),
              BlendMode.srcIn,
            ),
          ),
          const Gap(20),
          MyText(
            text: 'No transactions found',
            size: 16,
            weight: FontWeight.w500,
            color: kDynamicSubtitleText(Get.context!),
          ),
          const Gap(8),
          MyText(
            text: 'Try adjusting your search or check back later',
            size: 14,
            color: kDynamicSubtitleText(Get.context!),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const _TransactionItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Transaction Icon
          Container(
            height: 52,
            width: 52,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kDynamicBorder(context).withOpacity(0.25),
            ),
            child: SvgPicture.asset(
              transaction.icon,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                kDynamicIcon(context),
                BlendMode.srcIn,
              ),
            ),
          ),

          const Gap(14),

          // Transaction Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: transaction.title,
                  weight: FontWeight.w600,
                  size: 15,
                  color: kDynamicText(context),
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
                const Gap(4),
                MyText(
                  text: transaction.formattedDate,
                  size: 12,
                  color: kDynamicSubtitleText(context),
                ),
              ],
            ),
          ),

          // Amount and Type
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MyText(
                text: transaction.formattedAmount,
                weight: FontWeight.bold,
                size: 15,
                color: transaction.isTopUp ? kGreen : kDynamicText(context),
              ),
              const Gap(4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyText(
                    text: transaction.typeString,
                    size: 12,
                    color: transaction.isTopUp ? kBlue : kRed,
                    weight: FontWeight.w500,
                  ),
                  const Gap(6),
                  SvgPicture.asset(
                    transaction.isTopUp ? Assets.up : Assets.down,
                    height: 16,
                    width: 16,
                    colorFilter: ColorFilter.mode(
                      transaction.isTopUp ? kBlue : kRed,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}