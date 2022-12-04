import 'package:flutter/material.dart';

class AnimationWidget extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final VoidCallback? onEnd;
  final Duration duration;
  final Offset startOffset;
  final Offset endOffset;

  const AnimationWidget({
    Key? key,
    required this.child,
    required this.isAnimating,
    this.onEnd,
    required this.duration,
    this.startOffset = const Offset(0.0, 0.0),
    this.endOffset = const Offset(0.0, 0.0),
  }) : super(key: key);

  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> transition;
  late final Animation<double> fade;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    transition =
        //Tween<Offset>(begin: const Offset(0.7, 2), end: const Offset(0.7, 0.2))
        Tween<Offset>(begin: widget.startOffset, end: widget.endOffset)
            .animate(controller);
    fade = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating != oldWidget.isAnimating) {
      doAnimation();
    }
  }

  Future doAnimation() async {
    if (widget.isAnimating) {
      controller.reset();
      await controller.forward();
      await Future.delayed(const Duration(milliseconds: 100));
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.startOffset == const Offset(0.0, 0.0) && widget.endOffset == const Offset(0.0, 0.0)) {
      return FadeTransition(opacity: fade, child: widget.child);
    }
    else {
      return SlideTransition(
        position: transition,
        child: FadeTransition(opacity: fade, child: widget.child),
      );
    }
  }
}
