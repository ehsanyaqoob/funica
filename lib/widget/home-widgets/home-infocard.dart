import 'dart:io';
import 'package:funica/constants/export.dart';
import 'package:funica/controller/profile-data-cont.dart';

class UserInfoRow extends StatelessWidget {
  final VoidCallback? onAvatarTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onFavoriteTap;

  const UserInfoRow({
    Key? key,
    this.onAvatarTap,
    this.onNotificationTap,
    this.onFavoriteTap,
  }) : super(key: key);
String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning 👋';
  } else if (hour < 17) {
    return 'Good Afternoon 👋';
  } else {
    return 'Good Evening 👋';
  }
}

  @override
  Widget build(BuildContext context) {
final FillUpProfileController controller = Get.put(FillUpProfileController());

    return GetBuilder<FillUpProfileController>(
      builder: (_) {
        return Row(
          children: [
            // Avatar
            Bounce(
              onTap: onAvatarTap ?? () {},
              child: CircleAvatar(
                radius: 30,
                backgroundColor: kDynamicBorder(context),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: kDynamicContainer(context),
                  backgroundImage: controller.profileImage != null
                      ? FileImage(controller.profileImage!)
                      : null,
                  child: controller.profileImage == null
                      ? SvgPicture.asset(
                          Assets.personfilled,
                          height: 28,
                          color: kDynamicIcon(context),
                        )
                      : null,
                ),
              ),
            ),

            const SizedBox(width: 20),

            // Greeting & Name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 MyText(
  text: getGreeting(),
  size: 14,
  weight: FontWeight.w600,
  color: kDynamicText(context).withOpacity(0.7),
),

                  MyText(
  text: controller.userName?.isNotEmpty == true
      ? controller.userName!
      : 'Andrew Ainsley',
  size: 18,
  weight: FontWeight.bold,
  color: kDynamicText(context),
),

                ],
              ),
            ),

            // Notifications & Heart Icons
            Row(
              children: [
                IconButton(
                  onPressed: onNotificationTap ?? () {},
                  icon: SvgPicture.asset(
                    Assets.notificationunfilled,
                    color: kDynamicIcon(context),
                  ),
                ),
                IconButton(
                  onPressed: onFavoriteTap ?? () {},
                  icon: SvgPicture.asset(
                    Assets.heartunfilled,
                    color: kDynamicIcon(context),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
