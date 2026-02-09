import 'package:flutter/material.dart';
import 'package:grupus/shared/constants/index.dart';

class CustomOutlinedButton extends StatefulWidget {
  final String btnLabel;
  final VoidCallback? onTap;
  final bool expand;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomOutlinedButton({
    super.key,
    required this.btnLabel,
    this.onTap,
    this.expand = true,
    this.backgroundColor,
    this.textColor,
  });

  @override
  State<CustomOutlinedButton> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown() => _controller.forward();

  void _handleTapUp() {
    _controller.reverse();
    widget.onTap?.call();
  }

  void _handleTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _handleTapDown(),
      onTapUp: (_) => _handleTapUp(),
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          final isPressed = _scaleAnimation.value < 0.99;

          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: widget.expand ? 0 : 16,
              ),
              width: widget.expand ? double.infinity : null,
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? Colors.transparent,
                border: Border.all(
                  color: widget.textColor ?? Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(
                  AppConstants.borderRadiusMedium,
                ),
                boxShadow:
                    isPressed
                        ? const []
                        : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
              ),
              alignment: Alignment.center,
              child: Text(
                widget.btnLabel,
                style: TextStyle(
                  color: widget.textColor ?? Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
