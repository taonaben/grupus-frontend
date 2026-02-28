import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:grupus/shared/constants/app_constants.dart';

class ImageMessageBubble extends StatelessWidget {
  final String id;
  final Image image;
  final VoidCallback onTap;
  final bool isSentByMe;
  final bool delivered;
  final bool seen;
  final bool sent;
  const ImageMessageBubble({
    super.key,
    required this.id,
    required this.image,
    required this.onTap,
    required this.isSentByMe,
    required this.delivered,
    required this.seen,
    required this.sent,
  });

  @override
  Widget build(BuildContext context) {
    return BubbleNormalImage(
      id: id,
      image: image,
      color: Theme.of(context).colorScheme.primary,
      bubbleRadius: AppConstants.borderRadiusMedium,
      onTap: onTap,
      seen: seen,
      sent: sent,
      delivered: delivered,
      isSender: isSentByMe,
    );
  }
}
