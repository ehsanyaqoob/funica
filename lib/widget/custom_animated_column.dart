
import 'package:funica/constants/export.dart';

class AnimatedColumn extends StatelessWidget {
  const AnimatedColumn({
    super.key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize,
    this.spacing,
    this.textBaseline,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.animationDuration,
  });

  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final double? spacing;
  final CrossAxisAlignment? crossAxisAlignment;
  final int? animationDuration;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        MoveEffect(
          duration: Duration(milliseconds: animationDuration ?? 1000),
          begin: const Offset(0, 20),
        ),
      ],
      child: Column(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisSize: mainAxisSize ?? MainAxisSize.max,
        children: spacing != null ? _addSpacing(children, spacing!) : children,
      ),
    );
  }

  List<Widget> _addSpacing(List<Widget> children, double spacing) {
    List<Widget> spacedChildren = [];
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i != children.length - 1) {
        spacedChildren.add(SizedBox(height: spacing));
      }
    }
    return spacedChildren;
  }
}

class AnimatedListView extends StatelessWidget {
  const AnimatedListView({
    super.key,
    required this.children,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.animationDuration,
    this.shrinkWrap = false,
    this.physics,
  });

  final List<Widget> children;
  final Axis scrollDirection;
  final EdgeInsetsGeometry? padding;
  final int? animationDuration;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: physics ?? const BouncingScrollPhysics(),
      padding: padding,
      shrinkWrap: shrinkWrap,
      scrollDirection: scrollDirection,
      itemCount: children.length,
      itemBuilder: (context, index) {
        return children[index]
            .animate()
            .move(
              duration: Duration(milliseconds: animationDuration ?? 1000),
              begin: const Offset(0, 20),
            )
            .fade(duration: Duration(milliseconds: animationDuration ?? 1000));
      },
    );
  }
}

class AnimatedStack extends StatelessWidget {
  const AnimatedStack({
    super.key,
    required this.children,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.fit = StackFit.loose,
    this.clipBehavior = Clip.hardEdge,
    this.animationDuration,
  });

  final List<Widget> children;
  final AlignmentGeometry alignment;
  final TextDirection? textDirection;
  final StackFit fit;
  final Clip clipBehavior;
  final int? animationDuration;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        MoveEffect(
          duration: Duration(milliseconds: animationDuration ?? 1000),
          begin: const Offset(0, 20),
        ),
        FadeEffect(duration: Duration(milliseconds: animationDuration ?? 1000)),
      ],
      child: Stack(
        alignment: alignment,
        textDirection: textDirection,
        fit: fit,
        clipBehavior: clipBehavior,
        children: children,
      ),
    );
  }
}