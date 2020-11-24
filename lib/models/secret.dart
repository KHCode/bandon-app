class Secret {
  final String apiKey;

  const Secret({this.apiKey = ''});

  String get key => apiKey;

  factory Secret.fromJson(Map<String, dynamic> jsonMap) =>
      Secret(apiKey: jsonMap['api_key']);
}
