
import 'package:funica/constants/export.dart';

class CustomProgressIndicator2 extends StatefulWidget {
  final double value;

  const CustomProgressIndicator2({super.key, required this.value});

  @override
  _CustomProgressIndicator2State createState() =>
      _CustomProgressIndicator2State();
}

class _CustomProgressIndicator2State extends State<CustomProgressIndicator2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.value,
    ).animate(_controller);
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant CustomProgressIndicator2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _animation = Tween<double>(
        begin: oldWidget.value,
        end: widget.value,
      ).animate(_controller);
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return LinearProgressIndicator(
          minHeight: 8,

          value: _animation.value,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor),
        );
      },
    );
  }
}

class CustomProgressIndicator extends StatefulWidget {
  final double value;

  const CustomProgressIndicator({super.key, required this.value});

  @override
  _CustomProgressIndicatorState createState() =>
      _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.value,
    ).animate(_controller);
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant CustomProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _animation = Tween<double>(
        begin: oldWidget.value,
        end: widget.value,
      ).animate(_controller);
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return LinearProgressIndicator(
          minHeight: 8,

          value: _animation.value,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          backgroundColor: Color(0xFFA4A4A6),
          valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor),
        );
      },
    );
  }
}