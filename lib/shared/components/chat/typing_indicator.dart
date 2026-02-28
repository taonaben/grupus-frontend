import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:grupus/shared/constants/app_constants.dart';

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return TypingIndicatorWave(
      showIndicator: true,
      bubbleColor: Theme.of(context).colorScheme.primary,
      dotColor: Theme.of(context).colorScheme.onPrimary,
      borderRadius: AppConstants.borderRadiusMedium,
      animationDuration: Duration(milliseconds: 500),
    );
  }
}
