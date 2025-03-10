import 'package:commons/commons.dart';

enum ApiConnection {
  apiConnection,
  otherApi,
  noApi,
}

extension ApiConnectionExtension on ApiConnection {
  String? get url {
    switch (this) {
      case ApiConnection.apiConnection:
        return Environment.apiEndpoint;
      case ApiConnection.otherApi:
        return '';
      case ApiConnection.noApi:
        return '';
    }
  }
}
