import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

import 'secret.dart';

class SecretLoader {
  final String secretPath;
  final String key;

  const SecretLoader({this.secretPath, this.key});

  Future<Secret> load() => rootBundle.loadStructuredData<Secret>(
        secretPath,
        (jsonStr) async => Secret.fromJson(json.decode(jsonStr)),
      );
}
