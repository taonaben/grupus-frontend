import 'dart:math' as math;

class WebSocketReconnectPolicy {
  final int maxAttempts;
  final int minDelaySeconds;
  final int maxDelaySeconds;

  int _attempts = 0;

  WebSocketReconnectPolicy({
    this.maxAttempts = 5,
    this.minDelaySeconds = 3,
    this.maxDelaySeconds = 30,
  });

  int get attempts => _attempts;

  bool get canRetry => _attempts < maxAttempts;

  void reset() {
    _attempts = 0;
  }

  Duration nextDelay() {
    _attempts++;
    final delaySeconds = math
        .pow(2, _attempts)
        .toInt()
        .clamp(minDelaySeconds, maxDelaySeconds);

    return Duration(seconds: delaySeconds);
  }
}
