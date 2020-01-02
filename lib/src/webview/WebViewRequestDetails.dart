import 'package:identity_server/src/mappable.dart';

class WebViewRequestDetails implements Mappable {
  /// The client id
  String initialUrl;

  /// The issuer
  String issuer;

  /// The URL of where the discovery document can be found
  String initialData;

  /// The redirect URL
  String initialOptions;

  /// The request scopes
  Map<String, String> initialHeaders;


  /// Additional parameters to include in the request
  Map<String, String> additionalParameters;

  /// Whether to allow non-HTTPS endpoints (only applicable on Android)
  bool allowInsecureConnections;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'initialUrl': initialUrl,
      'issuer': issuer,
      'initialData': initialData,
      'initialHeaders': initialHeaders,
      'initialOptions': initialOptions,
           'additionalParameters': additionalParameters,
      'allowInsecureConnections': allowInsecureConnections
    };
  }
}