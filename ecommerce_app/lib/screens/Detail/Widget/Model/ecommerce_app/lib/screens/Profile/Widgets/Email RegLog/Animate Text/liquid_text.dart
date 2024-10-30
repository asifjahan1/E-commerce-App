// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class LiquidText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Color waveColor;
  final Duration duration;

  const LiquidText({
    super.key,
    required this.text,
    required this.textStyle,
    this.waveColor = Colors.blueAccent,
    this.duration = const Duration(seconds: 3),
  });

  @override
  _LiquidTextState createState() => _LiquidTextState();
}

class _LiquidTextState extends State<LiquidText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [widget.waveColor, Colors.transparent],
              stops: [_controller.value - 0.2, _controller.value + 0.2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.mirror,
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: Text(
            widget.text,
            style: widget.textStyle,
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
