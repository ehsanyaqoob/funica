import 'package:funica/constants/export.dart';

//call

//  CustomAppBar(
//         title: "Home".tr,
//       showLeading: false,
//         showAvatarIcon: true,
//         showNotificationIcon: true,
//         showBasketIcon: true,
//         showMessageIcon: true,

//         textSize: 18,
//       ),

//ShowChat :true
//ShowLaguage: false
//ShowTrash: true
//ShowText

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final bool centerTitle;
  final bool showLeading;
  final double textSize;
  final TextAlign? textAlign;

  final bool showNotificationIcon;
  final bool showAvatarIcon;
  final bool showBasketIcon;
  final bool showMessageIcon;
  final bool enableSearch;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.onBackTap,
    this.centerTitle = true,
    this.showLeading = false,
    this.textSize = 18,
    this.textAlign,
    this.showNotificationIcon = false,
    this.showAvatarIcon = false,
    this.showBasketIcon = false,
    this.showMessageIcon = false,
    this.enableSearch = false,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isSearching = false;

  String get currentLangCode => Get.locale?.languageCode ?? 'en';
  bool get isRTL => currentLangCode == 'ar' || currentLangCode == 'sa';

  Widget _buildBackButton(BuildContext context) {
    final backIcon = Padding(
      padding: const EdgeInsets.all(10),
      child: CommonImageView(
        imagePath: Assets.imagesArrowBack,
        height: 16,
        color: kDynamicIcon(context),
      ),
    );

    return InkWell(
      onTap: () {
        if (_isSearching) {
          setState(() => _isSearching = false);
        } else {
          if (widget.onBackTap != null) {
            widget.onBackTap!();
          } else {
            Get.back();
          }
        }
      },
      child: backIcon,
    );
  }

  List<Widget> _buildOptionalIcons(BuildContext context) {
    final List<Map<String, dynamic>> iconConfigs = [
      {
        'show': widget.showMessageIcon,
        'asset': Assets.imagesMessageIcon,
        'padding': const EdgeInsets.symmetric(horizontal: 4),
      },
      {
        'show': widget.showBasketIcon,
        'asset': Assets.imagesBasketIcon,
        'padding': const EdgeInsets.symmetric(horizontal: 4),
      },
      {
        'show': widget.showNotificationIcon,
        'asset': Assets.imagesNotificationIcon,
        'padding': const EdgeInsets.symmetric(horizontal: 4),
      },
      {
        'show': widget.showAvatarIcon,
        'asset': Assets.imagesAppbarAvatar,
        'padding': const EdgeInsets.symmetric(horizontal: 8),
      },
    ];

    final orderedConfigs = isRTL ? iconConfigs.reversed.toList() : iconConfigs;

    return orderedConfigs.where((config) => config['show'] as bool).map((
      config,
    ) {
      return Padding(
        padding: config['padding'] as EdgeInsets,
        child: Bounce(
          onTap: () {},
          child: CommonImageView(
            imagePath: config['asset'] as String,
            height: 36,
            color: config['asset'] != Assets.imagesAppbarAvatar
                ? kDynamicIcon(context)
                : null,
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final optionalIcons = _buildOptionalIcons(context);
    final hasOptionalIcons = optionalIcons.isNotEmpty;

    return AppBar(
      backgroundColor: kDynamicScaffoldBackground(context),
      automaticallyImplyLeading: false,
      centerTitle: false,
      leading: _isSearching
          ? _buildBackButton(context)
          : (widget.showLeading ? _buildBackButton(context) : null),
      titleSpacing: 0,
      title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _isSearching
            ? Container(
                key: const ValueKey('searchField'),
                width: double.infinity,
                margin: const EdgeInsets.only(right: 10, top: 26.0),
                child: MyTextField(
                  keyboardType: TextInputType.text,
                  hint: 'Search',
                  prefix: SvgPicture.asset(
                    Assets.searchunfilled,
                    height: 20,
                    color: kDynamicIcon(context),
                  ),
                  suffix: SvgPicture.asset(
                    Assets.filter,
                    height: 20,
                    color: kDynamicIcon(context),
                  ),
                  autoFocus: true,
                ),
              )
            : MyText(
                key: const ValueKey('titleText'),
                text: widget.title ?? "",
                size: widget.textSize,
                color: kDynamicText(context),
                weight: FontWeight.w700,
                textAlign:
                    widget.textAlign ??
                    (isRTL ? TextAlign.right : TextAlign.left),
              ),
      ),
      actions: !_isSearching
          ? [
              if (widget.enableSearch)
                IconButton(
                  icon: SvgPicture.asset(
                    Assets.searchunfilled,
                    height: 20,
                    color: kDynamicIcon(context),
                  ),
                  onPressed: () => setState(() => _isSearching = true),
                ),
              if (!isRTL && hasOptionalIcons) ...optionalIcons,
              if (widget.actions != null) ...widget.actions!,
              if (isRTL && hasOptionalIcons) ...optionalIcons,
            ]
          : [], // no actions while searching
    );
  }
}

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final bool centerTitle;
  final bool showLeading;
  final double textSize;
  final TextAlign? textAlign;

  final bool showNotificationIcon;
  final bool showAvatarIcon;
  final bool showBasketIcon;
  final bool showMessageIcon;
  final bool showBackIcon;

  const CustomAppBar2({
    super.key,
    this.title,
    this.actions,
    this.onBackTap,
    this.centerTitle = true,
    this.showLeading = false,
    this.textSize = 18,
    this.textAlign,
    this.showNotificationIcon = false,
    this.showAvatarIcon = false,
    this.showBasketIcon = false,
    this.showMessageIcon = false,
    this.showBackIcon = false,
  });

  String get currentLangCode => Get.locale?.languageCode ?? 'en';
  bool get isRTL => currentLangCode == 'ar' || currentLangCode == 'sa';

  Widget _buildBackButton() {
    final backIcon = Padding(
      padding: const EdgeInsets.all(10),
      child: CommonImageView(imagePath: Assets.imagesArrowBack, height: 16),
    );
    final backIconRight = Row(
      children: [
        CommonImageView(imagePath: Assets.imagesArrowBack, height: 32),
        Gap(10),
      ],
    );

    return InkWell(
      onTap: onBackTap ?? () => Get.back(),
      child: isRTL
          ? Transform.flip(flipX: true, child: backIconRight)
          : backIcon,
    );
  }

  List<Widget> _buildOptionalIconsArabic() {
    List<Widget> optionalActions = [];

    if (showAvatarIcon) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Bounce(
            onTap: () {
              // Get.to(() => const ProfileMainScreen());
              //        //                    Get.to(() => const EditProfileScreen());
              // Get.to(() => ViewProfileMainScreen());
            },
            child: CommonImageView(
              imagePath: Assets.imagesAppbarAvatar,
              height: 36,
            ),
          ),
        ),
      );
    }
    if (showNotificationIcon) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Bounce(
            onTap: () {
              // Get.to(() => const NotificationScreen());
            },
            child: CommonImageView(
              imagePath: Assets.imagesNotificationIcon,
              height: 36,
            ),
          ),
        ),
      );
    }
    if (showBasketIcon) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Bounce(
            onTap: () {
              // Get.to(() => const BookingDetailsScreen());
            },
            child: CommonImageView(
              imagePath: Assets.imagesBasketIcon,
              height: 36,
            ),
          ),
        ),
      );
    }
    if (showMessageIcon) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Bounce(
            onTap: () {
              //  Get.to(() => const ChatMainScreen());
            },
            child: CommonImageView(
              imagePath: Assets.imagesMessageIcon,
              height: 36,
            ),
          ),
        ),
      );
    }

    return optionalActions;
  }

  List<Widget> _buildOptionalIconsEnglish() {
    List<Widget> optionalActions = [];

    if (showMessageIcon) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Bounce(
            onTap: () {
              //   Get.to(() => const ChatMainScreen());
            },
            child: CommonImageView(
              imagePath: Assets.imagesMessageIcon,
              height: 36,
            ),
          ),
        ),
      );
    }

    if (showBasketIcon) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Bounce(
            onTap: () {
              //    Get.to(() => const BookingDetailsScreen());
            },
            child: CommonImageView(
              imagePath: Assets.imagesBasketIcon,
              height: 36,
            ),
          ),
        ),
      );
    }
    if (showNotificationIcon) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Bounce(
            onTap: () {
              //    Get.to(() => const NotificationScreen());
            },
            child: CommonImageView(
              imagePath: Assets.imagesNotificationIcon,
              height: 36,
            ),
          ),
        ),
      );
    }
    if (showAvatarIcon) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Bounce(
            onTap: () {
              //   Get.to(() => const ProfileMainScreen());
              //                    Get.to(() => const EditProfileScreen());
              //  Get.to(() => ViewProfileMainScreen());
            },
            child: CommonImageView(
              imagePath: Assets.imagesAppbarAvatar,
              height: 36,
            ),
          ),
        ),
      );
    }

    return optionalActions;
  }

  List<Widget> _buildOptionalIcons() {
    return isRTL ? _buildOptionalIconsArabic() : _buildOptionalIconsEnglish();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          centerTitle: centerTitle,
          backgroundColor: kWhite,
          automaticallyImplyLeading: false,
          leading: isRTL
              ? Row(
                  spacing: 4,
                  mainAxisSize: MainAxisSize.min,
                  children: _buildOptionalIcons(),
                )
              : (showLeading ? _buildBackButton() : null),
          leadingWidth: isRTL ? (_buildOptionalIcons().length * 50.0) : null,
          title: Align(
            alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
            child: MyText(
              text: title ?? "",
              size: textSize,
              color: kBlack,
              weight: FontWeight.w700,
              textAlign:
                  textAlign ?? (isRTL ? TextAlign.right : TextAlign.left),
            ),
          ),
          actions: [
            if (isRTL && showLeading) _buildBackButton(),
            if (!isRTL) ..._buildOptionalIcons(),
            if (actions != null) ...actions!,
            Gap(10),
          ],
        ),
        Divider(color: kGreylightColor, thickness: 1, height: 0),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBar3 extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final bool centerTitle;
  final bool showLeading;
  final double textSize;
  final TextAlign? textAlign;

  final bool showNotificationIcon;
  final bool showAvatarIcon;
  final bool showBasketIcon;
  final bool showMessageIcon;
  final bool showBackIcon;

  const CustomAppBar3({
    super.key,
    this.title,
    this.actions,
    this.onBackTap,
    this.centerTitle = true,
    this.showLeading = false,
    this.textSize = 18,
    this.textAlign,
    this.showNotificationIcon = false,
    this.showAvatarIcon = false,
    this.showBasketIcon = false,
    this.showMessageIcon = false,
    this.showBackIcon = false,
  });

  String get currentLangCode => Get.locale?.languageCode ?? 'en';
  bool get isRTL => currentLangCode == 'ar' || currentLangCode == 'sa';

  Widget _buildBackButton() {
    final backIcon = Padding(
      padding: const EdgeInsets.all(10),
      child: CommonImageView(imagePath: Assets.imagesArrowBack, height: 16),
    );
    final backIconRight = Row(
      children: [
        CommonImageView(imagePath: Assets.imagesArrowBack, height: 32),
        Gap(10),
      ],
    );

    return InkWell(
      onTap: onBackTap ?? () => Get.back(),
      child: isRTL
          ? Transform.flip(flipX: true, child: backIconRight)
          : backIcon,
    );
  }

  List<Widget> _buildOptionalIconsArabic() {
    List<Widget> optionalActions = [];

    if (showAvatarIcon) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Bounce(
            onTap: () {
              //Get.to(() => const AllRecentlyPlayed());
            },
            child: CommonImageView(
              imagePath: Assets.imagesNowPlayingAppbarIcon,
              height: 36,
            ),
          ),
        ),
      );
    }

    return optionalActions;
  }

  List<Widget> _buildOptionalIconsEnglish() {
    List<Widget> optionalActions = [];

    if (showAvatarIcon) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Bounce(
            onTap: () {
              // Get.to(() => const AllRecentlyPlayed());
            },
            child: CommonImageView(
              imagePath: Assets.imagesNowPlayingAppbarIcon,
              height: 36,
            ),
          ),
        ),
      );
    }

    return optionalActions;
  }

  List<Widget> _buildOptionalIcons() {
    return isRTL ? _buildOptionalIconsArabic() : _buildOptionalIconsEnglish();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          centerTitle: centerTitle,
          backgroundColor: kbackground,
          automaticallyImplyLeading: false,
          titleSpacing: -10,

          leading: isRTL
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: _buildOptionalIcons(),
                )
              : (showLeading ? _buildBackButton() : null),
          leadingWidth: isRTL ? (_buildOptionalIcons().length * 50.0) : null,
          title: Align(
            alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
            child: MyText(
              text: title ?? "",
              size: textSize,
              color: kBlack,
              weight: FontWeight.w700,
              textAlign:
                  textAlign ?? (isRTL ? TextAlign.right : TextAlign.left),
            ),
          ),
          actions: [
            if (isRTL && showLeading) _buildBackButton(),
            if (!isRTL) ..._buildOptionalIcons(),
            if (actions != null) ...actions!,
            Gap(10),
          ],
        ),
        Divider(color: kGreylightColor, thickness: 1, height: 0),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBar4 extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final bool centerTitle;
  final bool showLeading;
  final double textSize;
  final TextAlign? textAlign;

  final bool ShowSettiings;

  const CustomAppBar4({
    super.key,
    this.title,
    this.actions,
    this.onBackTap,
    this.centerTitle = true,
    this.showLeading = false,
    this.textSize = 18,
    this.textAlign,
    this.ShowSettiings = false,
  });

  String get currentLangCode => Get.locale?.languageCode ?? 'en';
  bool get isRTL => currentLangCode == 'ar' || currentLangCode == 'sa';

  Widget _buildBackButton() {
    final backIcon = Padding(
      padding: const EdgeInsets.all(10),
      child: CommonImageView(imagePath: Assets.imagesArrowBack, height: 16),
    );
    final backIconRight = Row(
      children: [
        CommonImageView(imagePath: Assets.imagesArrowBack, height: 32),
        Gap(10),
      ],
    );

    return InkWell(
      onTap: onBackTap ?? () => Get.back(),
      child: isRTL
          ? Transform.flip(flipX: true, child: backIconRight)
          : backIcon,
    );
  }

  List<Widget> _buildOptionalIconsArabic() {
    List<Widget> optionalActions = [];

    if (ShowSettiings) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Bounce(
            onTap: () {
              // Get.to(() => const SettingsNotificationScreen());
            },
            child: CommonImageView(
              imagePath: Assets.imagesSettingsIcon,
              height: 36,
            ),
          ),
        ),
      );
    }

    return optionalActions;
  }

  List<Widget> _buildOptionalIconsEnglish() {
    List<Widget> optionalActions = [];

    if (ShowSettiings) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Bounce(
            onTap: () {
              // Get.to(() => const SettingsNotificationScreen());
            },
            child: CommonImageView(
              imagePath: Assets.imagesSettingsIcon,
              height: 36,
            ),
          ),
        ),
      );
    }

    return optionalActions;
  }

  List<Widget> _buildOptionalIcons() {
    return isRTL ? _buildOptionalIconsArabic() : _buildOptionalIconsEnglish();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          centerTitle: centerTitle,
          backgroundColor: kbackground,
          automaticallyImplyLeading: false,
          titleSpacing: -10,
          leading: isRTL
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: _buildOptionalIcons(),
                )
              : (showLeading ? _buildBackButton() : null),
          leadingWidth: isRTL ? (_buildOptionalIcons().length * 50.0) : null,
          title: Align(
            alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
            child: MyText(
              text: title ?? "",
              size: textSize,
              color: kBlack,
              weight: FontWeight.w700,
              textAlign:
                  textAlign ?? (isRTL ? TextAlign.right : TextAlign.left),
            ),
          ),
          actions: [
            if (isRTL && showLeading) _buildBackButton(),
            if (!isRTL) ..._buildOptionalIcons(),
            if (actions != null) ...actions!,
            Gap(10),
          ],
        ),
        Divider(color: kGreylightColor, thickness: 1, height: 0),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBarEditProfile extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final bool centerTitle;
  final bool showLeading;
  final double textSize;
  final TextAlign? textAlign;

  final bool ShowSettiings;

  const CustomAppBarEditProfile({
    super.key,
    this.title,
    this.actions,
    this.onBackTap,
    this.centerTitle = true,
    this.showLeading = false,
    this.textSize = 18,
    this.textAlign,
    this.ShowSettiings = false,
  });

  String get currentLangCode => Get.locale?.languageCode ?? 'en';
  bool get isRTL => currentLangCode == 'ar' || currentLangCode == 'sa';

  Widget _buildBackButton() {
    final backIcon = Padding(
      padding: const EdgeInsets.all(10),
      child: CommonImageView(imagePath: Assets.imagesArrowBack, height: 16),
    );
    final backIconRight = Row(
      children: [
        CommonImageView(imagePath: Assets.imagesArrowBack, height: 32),
        Gap(10),
      ],
    );

    return InkWell(
      onTap: onBackTap ?? () => Get.back(),
      child: isRTL
          ? Transform.flip(flipX: true, child: backIconRight)
          : backIcon,
    );
  }

  List<Widget> _buildOptionalIconsArabic() {
    List<Widget> optionalActions = [];

    if (ShowSettiings) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Bounce(
            onTap: () {
              //  Get.to(() => const ProfileMainScreen());
            },
            child: CommonImageView(
              imagePath: Assets.imagesSettingsIcon,
              height: 36,
            ),
          ),
        ),
      );
    }

    return optionalActions;
  }

  List<Widget> _buildOptionalIconsEnglish() {
    List<Widget> optionalActions = [];

    if (ShowSettiings) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Bounce(
            onTap: () {
              //  Get.to(() => const ProfileMainScreen());
            },
            child: CommonImageView(
              imagePath: Assets.imagesSettingsIcon,
              height: 36,
            ),
          ),
        ),
      );
    }

    return optionalActions;
  }

  List<Widget> _buildOptionalIcons() {
    return isRTL ? _buildOptionalIconsArabic() : _buildOptionalIconsEnglish();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          centerTitle: centerTitle,
          backgroundColor: kbackground,
          automaticallyImplyLeading: false,
          titleSpacing: -10,
          leading: isRTL
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: _buildOptionalIcons(),
                )
              : (showLeading ? _buildBackButton() : null),
          leadingWidth: isRTL ? (_buildOptionalIcons().length * 50.0) : null,
          title: Align(
            alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
            child: MyText(
              text: title ?? "",
              size: textSize,
              color: kBlack,
              weight: FontWeight.w700,
              textAlign:
                  textAlign ?? (isRTL ? TextAlign.right : TextAlign.left),
            ),
          ),
          actions: [
            if (isRTL && showLeading) _buildBackButton(),
            if (!isRTL) ..._buildOptionalIcons(),
            if (actions != null) ...actions!,
            Gap(10),
          ],
        ),
        Divider(color: kGreylightColor, thickness: 1, height: 0),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SimpleCustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final bool centerTitle;
  final bool showLeading;
  final double textSize;
  final TextAlign? textAlign;

  const SimpleCustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.onBackTap,
    this.centerTitle = true,
    this.showLeading = false,
    this.textSize = 18,
    this.textAlign,
  });

  String get currentLangCode => Get.locale?.languageCode ?? 'en';
  bool get isRTL => currentLangCode == 'ar' || currentLangCode == 'sa';

  Widget _buildBackButton() {
    final backIcon = Padding(
      padding: const EdgeInsets.all(10),
      child: CommonImageView(imagePath: Assets.imagesArrowBack, height: 16),
    );

    final backIconRight = Row(
      children: [
        CommonImageView(imagePath: Assets.imagesArrowBack, height: 32),
        Gap(10),
      ],
    );

    return InkWell(
      onTap: onBackTap ?? () => Get.back(),
      child: isRTL
          ? Transform.flip(flipX: true, child: backIconRight)
          : backIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          centerTitle: centerTitle,
          backgroundColor: kbackground,
          automaticallyImplyLeading: false,
          titleSpacing: -10,
          // Show leading only if not RTL
          leading: showLeading && !isRTL ? _buildBackButton() : null,
          title: Align(
            alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
            child: MyText(
              text: title ?? "",
              size: textSize,
              color: kBlack,
              paddingRight: isRTL ? 20 : 0,
              weight: FontWeight.w700,
              textAlign:
                  textAlign ?? (isRTL ? TextAlign.right : TextAlign.left),
            ),
          ),
          actions: [
            // Show back button on right for RTL
            if (isRTL && showLeading) _buildBackButton(),
            if (actions != null) ...actions!, Gap(10),
          ],
        ),
        Divider(color: kGreylightColor, thickness: 1, height: 0),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBar5 extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final bool centerTitle;
  final bool showLeading;
  final double textSize;
  final TextAlign? textAlign;
  final bool ShowSettiings;

  final bool ShowChat;

  const CustomAppBar5({
    super.key,
    this.title,
    this.actions,
    this.onBackTap,
    this.centerTitle = true,
    this.showLeading = false,
    this.textSize = 18,
    this.textAlign,
    this.ShowChat = true,
    this.ShowSettiings = false,
  });

  String get currentLangCode => Get.locale?.languageCode ?? 'en';
  bool get isRTL => currentLangCode == 'ar' || currentLangCode == 'sa';

  Widget _buildBackButton() {
    final backIcon = Padding(
      padding: const EdgeInsets.all(10),
      child: CommonImageView(imagePath: Assets.imagesArrowBack, height: 16),
    );
    final backIconRight = Row(
      children: [
        CommonImageView(imagePath: Assets.imagesArrowBack, height: 32),
        Gap(10),
      ],
    );

    return InkWell(
      onTap: onBackTap ?? () => Get.back(),
      child: isRTL
          ? Transform.flip(flipX: true, child: backIconRight)
          : backIcon,
    );
  }

  List<Widget> _buildOptionalIconsArabic() {
    List<Widget> optionalActions = [];

    if (ShowChat) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Bounce(
            // onTap: () => Get.to(() => ChatMainScreen()),
            child: CommonImageView(
              imagePath: Assets.imagesSendBlue,
              height: 36,
            ),
          ),
        ),
      );
    }
    if (ShowSettiings) {
      optionalActions.add(
        Bounce(
          onTap: () {
            // Get.to(() => const ProfileMainScreen());
          },
          child: CommonImageView(
            imagePath: Assets.imagesSettingsIcon,
            height: 36,
          ),
        ),
      );
    }
    return optionalActions;
  }

  List<Widget> _buildOptionalIconsEnglish() {
    List<Widget> optionalActions = [];
    if (ShowSettiings) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Bounce(
            onTap: () {
              // Get.to(() => const ProfileMainScreen());
            },
            child: CommonImageView(
              imagePath: Assets.imagesSettingsIcon,
              height: 36,
            ),
          ),
        ),
      );
    }
    if (ShowChat) {
      optionalActions.add(
        Bounce(
          // onTap: () => Get.to(() => ChatMainScreen()),
          child: CommonImageView(imagePath: Assets.imagesSendBlue, height: 36),
        ),
      );
    }

    return optionalActions;
  }

  List<Widget> _buildOptionalIcons() {
    return isRTL ? _buildOptionalIconsArabic() : _buildOptionalIconsEnglish();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          centerTitle: centerTitle,
          backgroundColor: kbackground,
          automaticallyImplyLeading: false,
          titleSpacing: -10,
          leading: isRTL
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: _buildOptionalIcons(),
                )
              : (showLeading ? _buildBackButton() : null),
          leadingWidth: isRTL ? (_buildOptionalIcons().length * 50.0) : null,
          title: Align(
            alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
            child: MyText(
              text: title ?? "",
              size: textSize,
              color: kBlack,
              weight: FontWeight.w700,
              textAlign:
                  textAlign ?? (isRTL ? TextAlign.right : TextAlign.left),
            ),
          ),
          actions: [
            if (isRTL && showLeading) _buildBackButton(),
            if (!isRTL) ..._buildOptionalIcons(),
            if (actions != null) ...actions!,
            Gap(10),
          ],
        ),
        Divider(color: kGreylightColor, thickness: 1, height: 0),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBar6 extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final bool centerTitle;
  final bool showLeading;
  final double textSize;
  final TextAlign? textAlign;

  final bool ShowTrash;

  const CustomAppBar6({
    super.key,
    this.title,
    this.actions,
    this.onBackTap,
    this.centerTitle = true,
    this.showLeading = false,
    this.textSize = 18,
    this.textAlign,
    this.ShowTrash = true,
  });

  String get currentLangCode => Get.locale?.languageCode ?? 'en';
  bool get isRTL => currentLangCode == 'ar' || currentLangCode == 'sa';

  Widget _buildBackButton() {
    final backIcon = Padding(
      padding: const EdgeInsets.all(10),
      child: CommonImageView(imagePath: Assets.imagesArrowBack, height: 16),
    );
    final backIconRight = Row(
      children: [
        CommonImageView(imagePath: Assets.imagesArrowBack, height: 32),
        Gap(10),
      ],
    );

    return InkWell(
      onTap: onBackTap ?? () => Get.back(),
      child: isRTL
          ? Transform.flip(flipX: true, child: backIconRight)
          : backIcon,
    );
  }

  List<Widget> _buildOptionalIconsArabic(BuildContext context) {
    List<Widget> optionalActions = [];

    if (ShowTrash) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Bounce(
            onTap: () {
              // DialogHelper.DeleteCartItemDialog(context);
            },
            child: CommonImageView(imagePath: Assets.imagesTrash, height: 28),
          ),
        ),
      );
    }

    return optionalActions;
  }

  List<Widget> _buildOptionalIconsEnglish(BuildContext context) {
    List<Widget> optionalActions = [];

    if (ShowTrash) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Bounce(
            onTap: () {},
            child: CommonImageView(imagePath: Assets.imagesTrash, height: 28),
          ),
        ),
      );
    }

    return optionalActions;
  }

  List<Widget> _buildOptionalIcons(BuildContext context) {
    return isRTL
        ? _buildOptionalIconsArabic(context)
        : _buildOptionalIconsEnglish(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          centerTitle: centerTitle,
          backgroundColor: kbackground,
          automaticallyImplyLeading: false,
          titleSpacing: -10,
          leading: isRTL
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: _buildOptionalIcons(context),
                )
              : (showLeading ? _buildBackButton() : null),
          leadingWidth: isRTL
              ? (_buildOptionalIcons(context).length * 50.0)
              : null,
          title: Align(
            alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
            child: MyText(
              text: title ?? "",
              size: textSize,
              color: kBlack,
              weight: FontWeight.w700,
              textAlign:
                  textAlign ?? (isRTL ? TextAlign.right : TextAlign.left),
            ),
          ),
          actions: [
            if (isRTL && showLeading) _buildBackButton(),
            if (!isRTL) ..._buildOptionalIcons(context),
            if (actions != null) ...actions!,
            Gap(10),
          ],
        ),
        Divider(color: kGreylightColor, thickness: 1, height: 0),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SimpleCustomAppBar2 extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final bool centerTitle;
  final bool showLeading;
  final double textSize;
  final TextAlign? textAlign;

  const SimpleCustomAppBar2({
    super.key,
    this.title,
    this.actions,
    this.onBackTap,
    this.centerTitle = true,
    this.showLeading = false,
    this.textSize = 18,
    this.textAlign,
  });

  String get currentLangCode => Get.locale?.languageCode ?? 'en';
  bool get isRTL => currentLangCode == 'ar' || currentLangCode == 'sa';

  Widget _buildBackButton() {
    final backIcon = Padding(
      padding: const EdgeInsets.all(10),
      child: CommonImageView(imagePath: Assets.imagesArrowBack, height: 16),
    );
    final backIconRight = Row(
      children: [
        CommonImageView(imagePath: Assets.imagesArrowBack, height: 32),
        Gap(10),
      ],
    );

    return InkWell(
      onTap: onBackTap ?? () => Get.back(),
      child: isRTL
          ? Transform.flip(flipX: true, child: backIconRight)
          : backIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          centerTitle: centerTitle,
          backgroundColor: kbackground,
          automaticallyImplyLeading: false,
          titleSpacing: -10,
          // Show leading only if not RTL
          leading: showLeading && !isRTL ? _buildBackButton() : null,
          title: Align(
            alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
            child: isRTL
                ? MyText(
                    text: title ?? "",
                    size: textSize,
                    color: kBlack,
                    weight: FontWeight.w700,
                    textAlign: textAlign ?? TextAlign.right,
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyText(
                        text: title ?? "",
                        size: textSize,
                        color: kBlack,
                        weight: FontWeight.w700,
                        textAlign: textAlign ?? TextAlign.left,
                      ),
                      const SizedBox(width: 8),
                      CommonImageView(
                        imagePath: Assets.imagesChatUserBadge,
                        height: 24,
                      ),
                    ],
                  ),
          ),
          actions: [
            if (isRTL)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CommonImageView(
                  imagePath: Assets.imagesChatUserBadge,
                  height: 24,
                ),
              ),
            if (isRTL && showLeading) _buildBackButton(),
            if (actions != null) ...actions!,
            Gap(10),
          ],
        ),
        Divider(color: kGreylightColor, thickness: 1, height: 0),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SimpleCustomAppBar3 extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final bool centerTitle;
  final bool showLeading;
  final double textSize;
  final TextAlign? textAlign;
  final bool MoreOptions;

  const SimpleCustomAppBar3({
    super.key,
    this.title,
    this.actions,
    this.onBackTap,
    this.centerTitle = true,
    this.showLeading = false,
    this.textSize = 18,
    this.textAlign,
    this.MoreOptions = false,
  });

  String get currentLangCode => Get.locale?.languageCode ?? 'en';
  bool get isRTL => currentLangCode == 'ar' || currentLangCode == 'sa';

  Widget _buildBackButton() {
    final backIcon = Padding(
      padding: const EdgeInsets.all(10),
      child: CommonImageView(imagePath: Assets.imagesArrowBack, height: 16),
    );
    final backIconRight = Row(
      children: [
        CommonImageView(imagePath: Assets.imagesArrowBack, height: 32),
        Gap(10),
      ],
    );

    return InkWell(
      onTap: onBackTap ?? () => Get.back(),
      child: isRTL
          ? Transform.flip(flipX: true, child: backIconRight)
          : backIcon,
    );
  }

  List<Widget> _buildOptionalIconsArabic(BuildContext context) {
    List<Widget> optionalActions = [];

    if (MoreOptions) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Bounce(
            onTap: () {
              // DialogHelper.BlockDialog(context);
            },
            child: CommonImageView(imagePath: Assets.imagesCall, height: 28),
          ),
        ),
      );
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: PopupMenuButton(
            position: PopupMenuPosition.under,
            color: kWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    //   DialogHelper.BlockDialog(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyText(
                        paddingLeft: 10,
                        text: "Block".tr,
                        size: 12,
                        color: kSubText,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyText(
                        paddingLeft: 10,
                        text: "Report".tr,
                        size: 12,
                        color: kSubText,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ];
            },
            child: CommonImageView(imagePath: Assets.imagesOptions, height: 24),
          ),
        ),
      );
    }

    return optionalActions;
  }

  List<Widget> _buildOptionalIconsEnglish(BuildContext context) {
    List<Widget> optionalActions = [];

    if (MoreOptions) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Bounce(
            onTap: () {},
            child: CommonImageView(
              imagePath: Assets.imagesCallGrey,
              height: 24,
            ),
          ),
        ),
      );
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: PopupMenuButton(
            position: PopupMenuPosition.under,
            color: kWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    /// DialogHelper.BlockDialog(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyText(
                        paddingLeft: 10,
                        text: "Block".tr,
                        size: 12,
                        color: kSubText,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    //   ReportBottomSheet(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyText(
                        paddingLeft: 10,
                        text: "Report".tr,
                        size: 12,
                        color: kSubText,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ];
            },
            child: CommonImageView(
              imagePath: Assets.imagesMenuOptionsNew,
              height: 28,
            ),
          ),
        ),
      );
    }

    return optionalActions;
  }

  List<Widget> _buildOptionalIcons(BuildContext context) {
    return isRTL
        ? _buildOptionalIconsArabic(context)
        : _buildOptionalIconsEnglish(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          centerTitle: centerTitle,
          backgroundColor: kbackground,
          automaticallyImplyLeading: false,
          titleSpacing: -10,
          leading: isRTL
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: _buildOptionalIcons(context),
                )
              : (showLeading ? _buildBackButton() : null),
          leadingWidth: isRTL
              ? (_buildOptionalIcons(context).length * 50.0)
              : null,
          title: Align(
            alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
            child: MyText(
              text: title ?? "",
              size: textSize,
              color: kBlack,
              weight: FontWeight.w700,
              textAlign:
                  textAlign ?? (isRTL ? TextAlign.right : TextAlign.left),
            ),
          ),
          actions: [
            if (isRTL && showLeading) _buildBackButton(),
            if (!isRTL) ..._buildOptionalIcons(context),
            if (actions != null) ...actions!,
            Gap(10),
          ],
        ),
        Divider(color: kGreylightColor, thickness: 1, height: 0),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// class CustomAppBar7 extends StatefulWidget implements PreferredSizeWidget {
//   final String? title;
//   final List<Widget>? actions;
//   final VoidCallback? onBackTap;
//   final bool centerTitle;
//   final bool showLeading;
//   final double textSize;
//   final TextAlign? textAlign;

//   final bool ShowLaguage;

//   const CustomAppBar7({
//     super.key,
//     this.title,
//     this.actions,
//     this.onBackTap,
//     this.centerTitle = true,
//     this.showLeading = false,
//     this.textSize = 18,
//     this.textAlign,
//     this.ShowLaguage = true,
//   });

//   @override
//   State<CustomAppBar7> createState() => _CustomAppBar7State();

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

// class _CustomAppBar7State extends State<CustomAppBar7> {
//   String get currentLangCode => Get.locale?.languageCode ?? 'en';
//   final isArabic =
//       Get.locale?.languageCode == 'ar' || Get.locale?.languageCode == 'sa';

//   bool isEnglishSelected = true;
//   late LanguageController langController;

//   @override
//   void initState() {
//     super.initState();
//     // Safely get the LanguageController
//     try {
//       langController = Get.find<LanguageController>();
//     } catch (e) {
//       // If controller is not found, create it
//       langController = Get.put(LanguageController());
//     }
//   }

//   bool get isRTL => currentLangCode == 'ar' || currentLangCode == 'sa';

//   Widget _buildBackButton() {
//     final backIcon = Padding(
//       padding: const EdgeInsets.all(10),
//       child: CommonImageView(imagePath: Assets.imagesArrowBack, height: 16),
//     );
//     final backIconRight = Row(
//       children: [
//         CommonImageView(imagePath: Assets.imagesArrowBack, height: 32),
//         Gap(10),
//       ],
//     );

//     return InkWell(
//       onTap: widget.onBackTap ?? () => Get.back(),
//       child:
//           isRTL ? Transform.flip(flipX: true, child: backIconRight) : backIcon,
//     );
//   }

//   List<Widget> _buildOptionalIconsArabic() {
//     List<Widget> optionalActions = [];

//     if (widget.ShowLaguage) {
//       optionalActions.add(
//         Padding(
//           padding: const EdgeInsets.only(left: 4, right: 4),
//           child: Row(
//             children: [
//               //   Container(
//               //     width: 100,
//               //     height: 36,
//               //     decoration: BoxDecoration(
//               //       color: kPrimaryColor3,
//               //       borderRadius: BorderRadius.circular(30),
//               //     ),
//               //     child: Row(
//               //       children: [
//               //         Expanded(
//               //           child: GestureDetector(
//               //             onTap: () async {
//               //               setState(() {
//               //                 isEnglishSelected = true;
//               //               });
//               //               langController.onLanguageChanged('en', 0);
//               //               await UserSimplePreferences.setLanguageIndex(0);
//               //             },
//               //             child: Container(
//               //               decoration: BoxDecoration(
//               //                 color:
//               //                     isEnglishSelected
//               //                         ? kPrimaryColor
//               //                         : Colors.transparent,
//               //                 borderRadius: BorderRadius.circular(30),
//               //               ),
//               //               padding: const EdgeInsets.all(10),
//               //               child: CommonImageView(
//               //                 imagePath: Assets.imagesFlagEnglish,
//               //               ),
//               //             ),
//               //           ),
//               //         ),
//               //         Expanded(
//               //           child: GestureDetector(
//               //             onTap: () async {
//               //               setState(() {
//               //                 isEnglishSelected = false;
//               //               });
//               //               langController.onLanguageChanged('sa', 1);
//               //               await UserSimplePreferences.setLanguageIndex(1);
//               //             },
//               //             child: Container(
//               //               decoration: BoxDecoration(
//               //                 color:
//               //                     !isEnglishSelected
//               //                         ? kPrimaryColor
//               //                         : Colors.transparent,
//               //                 borderRadius: BorderRadius.circular(30),
//               //               ),
//               //               padding: const EdgeInsets.all(10),
//               //               child: CommonImageView(
//               //                 imagePath: Assets.imagesFlagSaudi,
//               //               ),
//               //             ),
//               //           ),
//               //         ),
//               //       ],
//               //     ),
//               //   ),
//               // ],
//               Container(
//                 width: 100,
//                 height: 36,
//                 decoration: BoxDecoration(
//                   color: kPrimaryColor3,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () async {
//                           setState(() {
//                             isEnglishSelected = true;
//                           });
//                           langController.onLanguageChanged('en', 0);
//                           await UserSimplePreferences.setLanguageIndex(0);
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color:
//                                 isEnglishSelected
//                                     ? kPrimaryColor
//                                     : Colors.transparent,
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           padding: const EdgeInsets.all(6),
//                           child: MyText(
//                             text: "EN",
//                             size: 16,
//                             textAlign: TextAlign.center,
//                             color: !isEnglishSelected ? kPrimaryColor : kWhite,
//                             weight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () async {
//                           setState(() {
//                             isEnglishSelected = false;
//                           });
//                           langController.onLanguageChanged('sa', 1);
//                           await UserSimplePreferences.setLanguageIndex(1);
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color:
//                                 !isEnglishSelected
//                                     ? kPrimaryColor
//                                     : Colors.transparent,
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           padding: const EdgeInsets.all(6),
//                           child: MyText(
//                             text: "AR",
//                             size: 16,
//                             textAlign: TextAlign.center,
//                             color: !isEnglishSelected ? kWhite : kPrimaryColor,
//                             weight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return optionalActions;
//   }

//   List<Widget> _buildOptionalIconsEnglish() {
//     List<Widget> optionalActions = [];

//     if (widget.ShowLaguage) {
//       optionalActions.add(
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           child: Row(
//             children: [
//               //   Container(
//               //     width: 100,
//               //     height: 36,
//               //     decoration: BoxDecoration(
//               //       color: kPrimaryColor3,
//               //       borderRadius: BorderRadius.circular(30),
//               //     ),
//               //     child: Row(
//               //       children: [
//               //         Expanded(
//               //           child: GestureDetector(
//               //             onTap: () async {
//               //               setState(() {
//               //                 isEnglishSelected = true;
//               //               });
//               //               langController.onLanguageChanged('en', 0);
//               //               await UserSimplePreferences.setLanguageIndex(0);
//               //             },
//               //             child: Container(
//               //               decoration: BoxDecoration(
//               //                 color:
//               //                     isEnglishSelected
//               //                         ? kPrimaryColor
//               //                         : Colors.transparent,
//               //                 borderRadius: BorderRadius.circular(30),
//               //               ),
//               //               padding: const EdgeInsets.all(10),
//               //               child: CommonImageView(
//               //                 imagePath: Assets.imagesFlagEnglish,
//               //               ),
//               //             ),
//               //           ),
//               //         ),
//               //         Expanded(
//               //           child: GestureDetector(
//               //             onTap: () async {
//               //               setState(() {
//               //                 isEnglishSelected = false;
//               //               });
//               //               langController.onLanguageChanged('sa', 1);
//               //               await UserSimplePreferences.setLanguageIndex(1);
//               //             },
//               //             child: Container(
//               //               decoration: BoxDecoration(
//               //                 color:
//               //                     !isEnglishSelected
//               //                         ? kPrimaryColor
//               //                         : Colors.transparent,
//               //                 borderRadius: BorderRadius.circular(30),
//               //               ),
//               //               padding: const EdgeInsets.all(10),
//               //               child: CommonImageView(
//               //                 imagePath: Assets.imagesFlagSaudi,
//               //               ),
//               //             ),
//               //           ),
//               //         ),
//               //       ],
//               //     ),
//               //   ),
//               // ],
//               Container(
//                 width: 100,
//                 height: 36,
//                 decoration: BoxDecoration(
//                   color: kPrimaryColor3,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () async {
//                           setState(() {
//                             isEnglishSelected = true;
//                           });
//                           langController.onLanguageChanged('en', 0);
//                           await UserSimplePreferences.setLanguageIndex(0);
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color:
//                                 isEnglishSelected
//                                     ? kPrimaryColor
//                                     : Colors.transparent,
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           padding: const EdgeInsets.all(6),
//                           child: MyText(
//                             text: "EN",
//                             size: 16,
//                             textAlign: TextAlign.center,
//                             color: !isEnglishSelected ? kPrimaryColor : kWhite,
//                             weight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () async {
//                           setState(() {
//                             isEnglishSelected = false;
//                           });
//                           langController.onLanguageChanged('sa', 1);
//                           await UserSimplePreferences.setLanguageIndex(1);
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color:
//                                 !isEnglishSelected
//                                     ? kPrimaryColor
//                                     : Colors.transparent,
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           padding: const EdgeInsets.all(6),
//                           child: MyText(
//                             text: "AR",
//                             size: 16,
//                             textAlign: TextAlign.center,
//                             color: !isEnglishSelected ? kWhite : kPrimaryColor,
//                             weight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return optionalActions;
//   }

//   List<Widget> _buildOptionalIcons() {
//     return isRTL ? _buildOptionalIconsArabic() : _buildOptionalIconsEnglish();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         AppBar(
//           centerTitle: widget.centerTitle,
//           backgroundColor: kbackground,
//           titleSpacing: -10,
//           automaticallyImplyLeading: false,
//           leading:
//               isRTL
//                   ? SizedBox(
//                     width: 120, // Constrain width to avoid overflow
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: _buildOptionalIcons(),
//                     ),
//                   )
//                   : (widget.showLeading ? _buildBackButton() : null),
//           leadingWidth: isRTL ? 120 : null,
//           title: Align(
//             alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
//             child: MyText(
//               text: widget.title ?? "",
//               size: widget.textSize,
//               color: kBlack,
//               weight: FontWeight.w700,
//               textAlign:
//                   widget.textAlign ??
//                   (isRTL ? TextAlign.right : TextAlign.left),
//             ),
//           ),
//           actions: [
//             if (isRTL && widget.showLeading) _buildBackButton(),

//             if (!isRTL) ..._buildOptionalIcons(),
//             if (widget.actions != null) ...widget.actions!,
//             Gap(10),
//           ],
//         ),
//         Divider(color: kGreylightColor, thickness: 1, height: 0),
//       ],
//     );
//   }
// }

class CustomAppBarText extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final bool centerTitle;
  final bool showLeading;
  final double textSize;
  final TextAlign? textAlign;

  final bool ShowText;

  const CustomAppBarText({
    super.key,
    this.title,
    this.actions,
    this.onBackTap,
    this.centerTitle = true,
    this.showLeading = false,
    this.textSize = 18,
    this.textAlign,
    this.ShowText = true,
  });

  String get currentLangCode => Get.locale?.languageCode ?? 'en';
  bool get isRTL => currentLangCode == 'ar' || currentLangCode == 'sa';

  Widget _buildBackButton() {
    final backIcon = Padding(
      padding: const EdgeInsets.all(10),
      child: CommonImageView(imagePath: Assets.imagesArrowBack, height: 16),
    );
    final backIconRight = Row(
      children: [
        CommonImageView(imagePath: Assets.imagesArrowBack, height: 32),
        Gap(10),
      ],
    );

    return InkWell(
      onTap: onBackTap ?? () => Get.back(),
      child: isRTL
          ? Transform.flip(flipX: true, child: backIconRight)
          : backIcon,
    );
  }

  List<Widget> _buildOptionalIconsArabic() {
    List<Widget> optionalActions = [];

    if (ShowText) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Bounce(
            onTap: () {},
            child: MyText(
              text: "3 Listings remaining".tr,
              size: 12,
              color: kPrimaryColor,
              weight: FontWeight.w400,
            ),
          ),
        ),
      );
    }

    return optionalActions;
  }

  List<Widget> _buildOptionalIconsEnglish() {
    List<Widget> optionalActions = [];

    if (ShowText) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Bounce(
            onTap: () {},
            child: MyText(
              text: "3 Listings remaining".tr,
              size: 12,
              color: kPrimaryColor,
              weight: FontWeight.w400,
            ),
          ),
        ),
      );
    }

    return optionalActions;
  }

  List<Widget> _buildOptionalIcons() {
    return isRTL ? _buildOptionalIconsArabic() : _buildOptionalIconsEnglish();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          centerTitle: centerTitle,
          backgroundColor: kbackground,
          automaticallyImplyLeading: false,
          titleSpacing: -10,
          leading: isRTL
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: _buildOptionalIcons(),
                )
              : (showLeading ? _buildBackButton() : null),
          leadingWidth: isRTL ? 120 : null,
          title: Align(
            alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
            child: MyText(
              text: title ?? "",
              size: textSize,
              color: kBlack,
              weight: FontWeight.w700,
              textAlign:
                  textAlign ?? (isRTL ? TextAlign.right : TextAlign.left),
            ),
          ),
          actions: [
            if (isRTL && showLeading) _buildBackButton(),
            if (!isRTL) ..._buildOptionalIcons(),
            if (actions != null) ...actions!,
            Gap(10),
          ],
        ),
        Divider(color: kGreylightColor, thickness: 1, height: 0),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBar8 extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? Subtitle;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final bool centerTitle;
  final bool showLeading;
  final double textSize;
  final TextAlign? textAlign;

  final bool showLocation;
  final bool showBackIcon;

  const CustomAppBar8({
    super.key,
    this.title,
    this.Subtitle,
    this.actions,
    this.onBackTap,
    this.centerTitle = true,
    this.showLeading = false,
    this.textSize = 18,
    this.textAlign,
    this.showLocation = false,
    this.showBackIcon = false,
  });

  String get currentLangCode => Get.locale?.languageCode ?? 'en';
  bool get isRTL => currentLangCode == 'ar' || currentLangCode == 'sa';

  Widget _buildBackButton() {
    final backIcon = Padding(
      padding: const EdgeInsets.all(10),
      child: CommonImageView(imagePath: Assets.imagesArrowBack, height: 16),
    );
    final backIconRight = Row(
      children: [
        CommonImageView(imagePath: Assets.imagesArrowBack, height: 32),
        Gap(10),
      ],
    );

    return InkWell(
      onTap: onBackTap ?? () => Get.back(),
      child: isRTL
          ? Transform.flip(flipX: true, child: backIconRight)
          : backIcon,
    );
  }

  List<Widget> _buildOptionalIconsArabic() {
    List<Widget> optionalActions = [];

    if (showLocation) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Bounce(
            onTap: () {},
            child: CommonImageView(
              imagePath: Assets.imagesSendBlue,
              height: 36,
            ),
          ),
        ),
      );
    }

    return optionalActions;
  }

  List<Widget> _buildOptionalIconsEnglish() {
    List<Widget> optionalActions = [];

    if (showLocation) {
      optionalActions.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Bounce(
            onTap: () {
              // Get.to(() => const ChatMainScreen());
            },
            child: CommonImageView(
              imagePath: Assets.imagesSendBlue,
              height: 36,
            ),
          ),
        ),
      );
    }
    return optionalActions;
  }

  List<Widget> _buildOptionalIcons() {
    return isRTL ? _buildOptionalIconsArabic() : _buildOptionalIconsEnglish();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          titleSpacing: -10,
          centerTitle: centerTitle,
          backgroundColor: kWhite,
          automaticallyImplyLeading: false,
          leading: isRTL
              ? Row(
                  spacing: 4,
                  mainAxisSize: MainAxisSize.min,
                  children: _buildOptionalIcons(),
                )
              : (showLeading ? _buildBackButton() : null),
          leadingWidth: isRTL ? (_buildOptionalIcons().length * 50.0) : null,
          title: Align(
            alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: title ?? "",
                  size: textSize,
                  color: kBlack,
                  weight: FontWeight.w700,
                  textAlign:
                      textAlign ?? (isRTL ? TextAlign.right : TextAlign.left),
                ),
                MyText(
                  text: Subtitle ?? "",
                  size: 12,
                  color: kSubText,

                  weight: FontWeight.w500,
                  textAlign:
                      textAlign ?? (isRTL ? TextAlign.right : TextAlign.left),
                ),
              ],
            ),
          ),
          actions: [
            if (isRTL && showLeading) _buildBackButton(),
            if (!isRTL) ..._buildOptionalIcons(),
            if (actions != null) ...actions!,
            Gap(10),
          ],
        ),
        Divider(color: kGreylightColor, thickness: 1, height: 0),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
