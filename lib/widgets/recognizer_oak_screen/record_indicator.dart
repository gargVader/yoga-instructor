import 'package:flutter/material.dart';

class RecordIndicator extends StatefulWidget {
  @override
  _RecordIndicatorState createState() => _RecordIndicatorState();
}

class _RecordIndicatorState extends State<RecordIndicator>
    with TickerProviderStateMixin {
  late AnimationController _pulseAnimationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _pulseAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _pulseAnimation =
        Tween<double>(begin: 1, end: 0).animate(_pulseAnimationController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _pulseAnimationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _pulseAnimationController.forward();
            }
          });

    _pulseAnimationController.forward();
  }

  @override
  void dispose() {
    _pulseAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _pulseAnimation.value,
      child: Icon(
        Icons.circle,
        color: Colors.red.shade800,
      ),
    );
  }
}
