import 'package:flutter/material.dart';

class AvatarGlowWidget extends StatefulWidget {
  const AvatarGlowWidget({
    Key? key,
    required this.child,
    required this.endRadius,
    this.shape = BoxShape.circle,
    this.duration = const Duration(milliseconds: 2000),
    this.repeat = true,
    this.animate = true,
    this.repeatPauseDuration = const Duration(milliseconds: 100),
    this.curve = Curves.fastOutSlowIn,
    this.showTwoGlows = true,
    this.glowColor = Colors.white,
    this.startDelay,
  }) : super(key: key);
  final Widget child;
  final double endRadius;
  final BoxShape shape;
  final Duration duration;
  final bool repeat;
  final bool animate;
  final Duration repeatPauseDuration;
  final Curve curve;
  final bool showTwoGlows;
  final Color glowColor;
  final Duration? startDelay;

  @override
  _AvatarGlowState createState() => _AvatarGlowState();
}

class _AvatarGlowState extends State<AvatarGlowWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  );
  late final CurvedAnimation _curve = CurvedAnimation(
    parent: controller,
    curve: widget.curve,
  );
  late final Animation<double> _smallDiscAnimation = Tween<double>(
    begin: (widget.endRadius * 2) / 6,
    end: (widget.endRadius * 2) * (3 / 4),
  ).animate(_curve);
  late final Animation<double> _bigDiscAnimation = Tween<double>(
    begin: 0.0,
    end: (widget.endRadius * 2),
  ).animate(_curve);
  late final Animation<double> _alphaAnimation = Tween<double>(
    begin: 0.30,
    end: 0.0,
  ).animate(controller);

  _statusListener(_) async {
    if (controller.status == AnimationStatus.completed) {
      await Future<dynamic>.delayed(widget.repeatPauseDuration);
      if (mounted && widget.repeat && widget.animate) {
        controller.reset();
        await controller.forward();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _startAnimation();
    }
  }

  @override
  void didUpdateWidget(AvatarGlowWidget oldWidget) {
    if (widget.animate != oldWidget.animate) {
      if (widget.animate) {
        _startAnimation();
      } else {
        _stopAnimation();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  _startAnimation() async {
    controller.addStatusListener(_statusListener);
    if (widget.startDelay != null) {
      await Future<dynamic>.delayed(widget.startDelay!);
    }
    if (mounted) {
      controller.reset();
      await controller.forward();
    }
  }

  _stopAnimation() async {
    controller.removeStatusListener(_statusListener);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _alphaAnimation,
      child: widget.child,
      builder: (BuildContext context, Widget? widgetChild) {
        final BoxDecoration decoration = BoxDecoration(
          shape: widget.shape,
          // If the user picks a curve that goes below 0 or above 1
          // this opacity will have unexpected effects without clamping
          color: widget.glowColor.withOpacity(
            _alphaAnimation.value.clamp(
              0.0,
              1.0,
            ),
          ),
        );
        return SizedBox(
          height: widget.endRadius * 2,
          width: widget.endRadius * 2,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              widget.animate
                  ? AnimatedBuilder(
                      animation: _bigDiscAnimation,
                      builder: (BuildContext context, Widget? widget) {
                        // If the user picks a curve that goes below 0,
                        // this will throw without clamping
                        final num size = _bigDiscAnimation.value.clamp(
                          0.0,
                          double.infinity,
                        );
                        return Container(
                          height: size as double?,
                          width: size as double?,
                          decoration: decoration,
                        );
                      },
                    )
                  : const SizedBox(height: 0.0, width: 0.0),
              widget.animate && widget.showTwoGlows
                  ? AnimatedBuilder(
                      animation: _smallDiscAnimation,
                      builder: (BuildContext context, Widget? widget) {
                        final num size = _smallDiscAnimation.value.clamp(
                          0.0,
                          double.infinity,
                        );

                        return Container(
                          height: size as double?,
                          width: size as double?,
                          decoration: decoration,
                        );
                      },
                    )
                  : const SizedBox(height: 0.0, width: 0.0),
              widgetChild!,
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
