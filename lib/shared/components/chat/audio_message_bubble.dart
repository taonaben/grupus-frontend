import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class AudioMessageBubble extends StatelessWidget {
  final Function(double) onSeekChanged;
  final Function() onPlayPauseButtonClick;
  final bool isPlaying;
  final bool isLoading;
  final bool isPaused;
  final bool isSentByMe;
  final bool delivered;
  final bool seen;
  final bool sent;
  const AudioMessageBubble({
    super.key,
    required this.onSeekChanged,
    required this.onPlayPauseButtonClick,
    required this.isPlaying,
    required this.isLoading,
    required this.isPaused,
    required this.isSentByMe,
    required this.delivered,
    required this.seen,
    required this.sent,
  });

  @override
  Widget build(BuildContext context) {
    return BubbleNormalAudio(
      color: Theme.of(context).colorScheme.primary,
      isPlaying: isPlaying,
      isLoading: isLoading,
      isPause: isPaused,
      seen: seen,
      sent: sent,
      delivered: delivered,
      isSender: isSentByMe,
      onSeekChanged: onSeekChanged,
      onPlayPauseButtonClick: onPlayPauseButtonClick,
    );
  }
}
