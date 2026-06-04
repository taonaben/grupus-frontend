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
      '',
    ];

    // Construct from scratch to avoid Uri.replace() carrying over an empty
    // fragment field, which serialises as a trailing '#' and breaks the upgrade.
    final wsUri = Uri(
      scheme: wsScheme,
      host: parsedBase.host,
      port: parsedBase.port,
      pathSegments: pathSegments,
      queryParameters: {'token': token},
    );

    return wsUri.toString();
  }
}
