import 'package:identity_server/model/authorization-parameters.dart';
import 'package:identity_server/model/gran-type.dart';
import 'package:identity_server/request/token-request.dart';

import '../authorization-service-configuration.dart';


class AuthorizationTokenRequest extends TokenRequest
    with AuthorizationParameters {
  AuthorizationTokenRequest(String clientId, String redirectUrl,
      {String loginHint,
        String clientSecret,
        List<String> scopes,
        AuthorizationServiceConfiguration serviceConfiguration,
        Map<String, String> additionalParameters,
        String issuer,
        String discoveryUrl,
        List<String> promptValues})
      : super(clientId, redirectUrl,
      clientSecret: clientSecret,
      discoveryUrl: discoveryUrl,
      issuer: issuer,
      scopes: scopes,
      grantType: GrantType.authorizationCode,
      serviceConfiguration: serviceConfiguration,
      additionalParameters: additionalParameters) {
    this.loginHint = loginHint;
    this.promptValues = promptValues;
  }

  Map<String, dynamic> toMap() {
    var map = super.toMap();
    return map;
  }
}
