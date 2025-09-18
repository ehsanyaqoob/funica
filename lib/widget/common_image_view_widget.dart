import 'dart:io';

import 'package:funica/constants/export.dart';

class CommonImageView extends StatelessWidget {
  final String? url;
  final String? imagePath;
  final String? svgPath;
  final File? file;
  final double? height;
  final double? width;
  final double? radius;
  final BoxFit fit;
  final String placeHolder;
  final Color? color; // ✅ optional color param

  const CommonImageView({
    super.key,
    this.url,
    this.imagePath,
    this.svgPath,
    this.file,
    this.height,
    this.width,
    this.radius = 0.0,
    this.fit = BoxFit.cover,
    this.placeHolder = 'assets/images/no_image_found.png',
    this.color, // ✅ added here
  });

  @override
  Widget build(BuildContext context) {
    return _buildImageView();
  }

  Widget _buildImageView() {
    if (svgPath != null && svgPath!.isNotEmpty) {
      return Animate(
        effects: [FadeEffect(duration: Duration(milliseconds: 500))],
        child: SizedBox(
          height: height,
          width: width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius!),
            child: SvgPicture.asset(
              svgPath!,
              height: height,
              width: width,
              fit: fit,
              color: color, // ✅ apply tint
            ),
          ),
        ),
      );
    } else if (file != null && file!.path.isNotEmpty) {
      return Animate(
        effects: [FadeEffect(duration: Duration(milliseconds: 500))],
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius!),
          child: Image.file(
            file!,
            height: height,
            width: width,
            fit: fit,
            color: color, // ✅ apply tint
          ),
        ),
      );
    } else if (url != null && url!.isNotEmpty) {
      return Animate(
        effects: [FadeEffect(duration: Duration(milliseconds: 500))],
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius!),
          child: CachedNetworkImage(
            height: height,
            width: width,
            fit: fit,
            imageUrl: url!,
            color: color, // ✅ apply tint
            placeholder: (context, url) => SizedBox(
              height: 23,
              width: 23,
              child: Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: kGreyColor,
                    backgroundColor: Colors.grey.shade100,
                  ),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(
              placeHolder,
              height: height,
              width: width,
              fit: fit,
              color: color, // ✅ tint placeholder too
            ),
          ),
        ),
      );
    } else if (imagePath != null && imagePath!.isNotEmpty) {
      return Animate(
        effects: [FadeEffect(duration: Duration(milliseconds: 500))],
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius!),
          child: Image.asset(
            imagePath!,
            height: height,
            width: width,
            fit: fit,
            color: color, // ✅ apply tint
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
class CommonImageViewWithoutAnimate extends StatelessWidget {
  // ignore_for_file: must_be_immutable
  String? url;
  String? imagePath;
  String? svgPath;
  File? file;
  double? height;
  double? width;
  double? radius;
  final BoxFit fit;
  final String placeHolder;

  CommonImageViewWithoutAnimate({
    super.key,
    this.url,
    this.imagePath,
    this.svgPath,
    this.file,
    this.height,
    this.width,
    this.radius = 0.0,
    this.fit = BoxFit.cover,
    this.placeHolder = 'assets/images/no_image_found.png',
  });

  @override
  Widget build(BuildContext context) {
    return _buildImageView();
  }

  Widget _buildImageView() {
    if (svgPath != null && svgPath!.isNotEmpty) {
      return SizedBox(
        height: height,
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius!),
          child: SvgPicture.asset(
            svgPath!,
            height: height,
            width: width,
            fit: fit,
          ),
        ),
      );
    } else if (file != null && file!.path.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius!),
        child: Image.file(file!, height: height, width: width, fit: fit),
      );
    } else if (url != null && url!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius!),
        child: CachedNetworkImage(
          height: height,
          width: width,
          fit: fit,
          imageUrl: url!,
          placeholder: (context, url) => SizedBox(
            height: 23,
            width: 23,
            child: Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: kGreyColor,
                  backgroundColor: Colors.grey.shade100,
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) =>
              Image.asset(placeHolder, height: height, width: width, fit: fit),
        ),
      );
    } else if (imagePath != null && imagePath!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius!),
        child: Image.asset(imagePath!, height: height, width: width, fit: fit),
      );
    }
    return SizedBox();
  }
}

class CommonImageViewWithBorder extends StatelessWidget {
  String? url;
  String? imagePath;
  String? svgPath;
  File? file;
  double? height;
  double? width;
  double? radius;
  final BoxFit fit;
  final String placeHolder;

  CommonImageViewWithBorder({
    super.key,
    this.url,
    this.imagePath,
    this.svgPath,
    this.file,
    this.height,
    this.width,
    this.radius = 0.0,
    this.fit = BoxFit.cover,
    this.placeHolder = 'assets/images/no_image_found.png',
  });

  @override
  Widget build(BuildContext context) {
    return _buildImageView();
  }

  Widget _buildImageView() {
    if (svgPath != null && svgPath!.isNotEmpty) {
      return SizedBox(
        height: height,
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius!),
          child: SvgPicture.asset(
            svgPath!,
            height: height,
            width: width,
            fit: fit,
          ),
        ),
      );
    } else if (file != null && file!.path.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius!),
        child: Image.file(file!, height: height, width: width, fit: fit),
      );
    } else if (url != null && url!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius!),
        child: CachedNetworkImage(
          height: height,
          width: width,
          fit: fit,
          imageUrl: url!,
          placeholder: (context, url) => SizedBox(
            height: 23,
            width: 23,
            child: Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: kGreyColor,
                  backgroundColor: Colors.grey.shade100,
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) =>
              Image.asset(placeHolder, height: height, width: width, fit: fit),
        ),
      );
    } else if (imagePath != null && imagePath!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius!),
        child: Image.asset(imagePath!, height: height, width: width, fit: fit),
      );
    }
    return SizedBox();
  }
}
