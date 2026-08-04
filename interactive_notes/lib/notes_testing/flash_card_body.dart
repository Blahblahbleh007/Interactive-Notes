import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:developer';

class FlashCardBody extends StatefulWidget {
  final Widget front;
  final Widget back;
  final VoidCallback? onTapNext;
  final VoidCallback? onTapBack;
  const FlashCardBody({
    super.key,
    required this.front,
    required this.back,
    this.onTapNext,
    this.onTapBack
  });
  @override
  State<FlashCardBody> createState() => _FlashCardBody();
}

class _FlashCardBody extends State<FlashCardBody> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
  }

  // void _flip() {
  //   if (_controller.isAnimating) return;
  //   if (_showFront) {
  //     // First tap: flip to back
  //     _controller.forward(from: 0);
  //     setState(() => _showFront = false);
  //   } else {
  //     // Second tap (already on back)
  //     setState(() => _showFront = true);
  //     // widget.onTapNext?.call();
  //   }
  // }
  void _flip() {
    if (_controller.isAnimating) return;
    setState(() => _showFront = !_showFront);
    if (_showFront) {
      _controller.reverse(); // back -> front, animates 1 -> 0
    } else {
      _controller.forward(); // front -> back, animates 0 -> 1
    }
  }

  void _handleHorizontalDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    // Positive velocity means swiping left
    if (velocity < 0) { // swipe right
      log('swipe left, back');
      widget.onTapBack?.call();
    } else if (velocity > 0) { // swiping left
      log('swipe right, next');
      widget.onTapNext?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      onHorizontalDragEnd: _handleHorizontalDragEnd,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final angle = _controller.value * math.pi;
          final isFlipped = angle > math.pi / 2;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateY(angle),
            child: isFlipped
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(math.pi),
                    child: widget.back,
                  )
                : widget.front,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}