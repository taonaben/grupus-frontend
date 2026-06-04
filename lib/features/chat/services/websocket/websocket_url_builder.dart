class WebSocketUrlBuilder {
  const WebSocketUrlBuilder();

  String build({
    required String baseUrl,
    required String roomId,
    required String token,
  }) {
    final parsedBase = Uri.parse(baseUrl);
    final wsScheme = parsedBase.scheme == 'https' ? 'wss' : 'ws';

    final pathSegments = <String>[
      ...parsedBase.pathSegments.where((segment) => segment.isNotEmpty),
      'ws',
      'chat',
      roomId,
    ];

    final wsUri = parsedBase.replace(
      scheme: wsScheme,
      pathSegments: pathSegments,
      queryParameters: {'token': token},
    );

    return wsUri.toString();
  }
}
