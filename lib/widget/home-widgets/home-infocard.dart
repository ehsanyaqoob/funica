import 'package:funica/constants/export.dart';

class HomeInfoCard extends StatelessWidget {
  final String username;
  final String fullName;
  final VoidCallback onCartTap;
  final String profileImage;

  const HomeInfoCard({
    Key? key,
    required this.username,
    required this.fullName,
    required this.onCartTap,
    required this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: kDynamicPrimary(context), width: 3.6),
          ),
          child: GestureDetector(
            onTap: () {
              // for profile screen
            },
            child: CircleAvatar(
              radius: 26.0,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Image.asset(
                  profileImage,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Gap(16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              text: username,
              size: 16,
              weight: FontWeight.bold,
              color: kDynamicText(context).withOpacity(0.6),
            ),
            MyText(
              text: fullName,
              size: 18,
              weight: FontWeight.bold,
              color: kDynamicText(context),
            ),
          ],
        ),
        const Spacer(),
        Stack(
          children: [
            GestureDetector(
              onTap: onCartTap,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: kDynamicContainer(context),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: kDynamicIcon(context).withOpacity(0.6),
                    width: 2.6,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    Assets.imagescartactive,
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Badge with item count
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red, // Badge color
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: MyText(
                  text: '5',
                              color: kDynamicText(context),
                  size: 12,
                  weight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
