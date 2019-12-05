import 'package:identity_server/model/authorization-parameters.dart';
import 'package:identity_server/model/config.dart';
import 'common-request-details.dart';

class AuthorizationRequest extends CommonRequestDetails
    with AuthorizationParameters {
  String url;
  String redirectUrl;
  Map<String, String> parameters;
  Map<String, String> headers;
  bool fullScreen;
  bool clearCookies;

  AuthorizationRequest(Config config,
      {String clientId,
      String redirectUrl,
      String loginHint,
      List<String> scopes,
      String issuer,
      String discoveryUrl,
      List<String> promptValues,
      bool fullScreen: true,
      bool clearCookies: false}) {

    this.url = config.authorizationUrl;
    this.redirectUrl = config.redirectUri;
    this.parameters = {
      "client_id": config.clientId,
      "response_type": config.responseType,
      "redirect_uri": config.redirectUri,
      "scope": config.scope.join(" "),
    };
    this.fullScreen = fullScreen;
    this.clearCookies = clearCookies;
    this.clientId = clientId;
    this.redirectUrl = redirectUrl;
    this.scopes = scopes;
    this.serviceConfiguration = serviceConfiguration;
    this.additionalParameters = additionalParameters;
    this.issuer = issuer;
    this.discoveryUrl = discoveryUrl;
    this.loginHint = loginHint;
    this.promptValues = promptValues;
  }

  Map<String, dynamic> toMap() {
    var map = super.toMap();
    return map;
  }
}
