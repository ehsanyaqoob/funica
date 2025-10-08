import 'package:funica/constants/export.dart';

class CustomVisaCard extends StatelessWidget {
  final String name;
  final String cardNumber;
  final double balance;
  final VoidCallback? onTopUp;

  const CustomVisaCard({
    Key? key,
    required this.name,
    required this.cardNumber,
    required this.balance,
    this.onTopUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: kDynamicContainer(context),
        borderRadius: BorderRadius.circular(30.0),boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 8),
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---------------- Header Row ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: name,
                  color: kDynamicText(context),
                  size: 16,
                  weight: FontWeight.w600,
                ),
                Row(
                  children: [
                    SvgPicture.asset(Assets.visa, height: 34),
                    const Gap(8),
                    SvgPicture.asset(
                      Assets.visacard,
                      height: 34,
                      colorFilter: const ColorFilter.mode(
                        kRed,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            /// ---------------- Card Number ----------------
            MyText(
              text: _formatCardNumber(cardNumber),
              color: kDynamicText(context),
              size: 18.0,
              letterSpacing: 2,
              weight: FontWeight.w500,
            ),

            MyText(
              text: 'Your balance',
              color: kDynamicSubtitleText(context),
              size: 14.0,
            ),


            MyText(
              text: _formatBalance(balance),
              color: kDynamicText(context),
              size: 26.0,
              weight: FontWeight.bold,
            ),

            const Spacer(),

            Align(
              alignment: Alignment.bottomRight,
              child: Bounce(
                onTap: onTopUp,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: kDynamicContainer(context),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        Assets.up,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          kDynamicText(context),
                          BlendMode.srcIn,
                        ),
                      ),
                      const Gap(6),
                      MyText(
                        text: 'Top Up',
                        color: kDynamicText(context),
                        size: 13,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Format Card Number as •••• •••• •••• 3629
  String _formatCardNumber(String number) {
    if (number.length < 4) return number;
    final lastFour = number.substring(number.length - 4);
    return '••••  ••••  ••••  $lastFour';
  }

  /// Format Balance as $9,379
  String _formatBalance(double balance) {
    final formatted = balance.toStringAsFixed(0);
    return '\$$formatted';
  }
}
