import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:identity_server/model/config.dart';
import 'package:identity_server/request/request-util.dart';

import 'authorization-request.dart';

class RequestCode {
  final StreamController<String> _onCodeListener = new StreamController();
  final FlutterWebviewPlugin _webView = new FlutterWebviewPlugin();
  final Config _config;
  AuthorizationRequest _authorizationRequest;

  var _onCodeStream;

  Stream<String> get _onCode =>  _onCodeStream ??= _onCodeListener.stream.asBroadcastStream();

  RequestCode(Config config) : _config = config {
    _authorizationRequest = new AuthorizationRequest(config);
  }

  Future<String> requestCode() async {
    var code;
    final String openId = "ZPonto";
    final String codeChallengeMethod = "S256";
    final String responseType = "code";
    final String identityServerLoginUrl =
        "https://identity-server-dev.zellar.com.br/Account/Login";
    final String urlParams = _constructUrlParams();
    final String redirectUrl = "net.openid.appzponto";
    final String autorizationCode =
        "0029e96585ee5bfaa7b01347565bd06cedc2f096526e5229887d8697a0fa4268";
    /*   final String url = "$identityServerLoginUrl?ReturnUrl=%2Fconnect%"
        "2Fauthorize%2Fcallback%3Fredirect_uri%3D$redirectUrl%253A%252Foauth2redirect%26c"
        "lient_id%3D$openId%26response_type%3D$responseType%26scope%3Dopenid%"
        "2520profile%2520email%2520offline_access%2520moltres.acesso.api.full%26code_challenge%"
        "3D$autorizationCode%26code_challenge_method%3D$codeChallengeMethod";*/
    RequestUtils rs;

    String url = _config.createURL();
    String codeVerifier = _config.codeVerifier;

    await _webView.launch(url,
        clearCookies: _authorizationRequest.clearCookies,
        hidden: false,
        rect: _config.screenSize);

    _webView.onUrlChanged.listen((String url) {
      Uri uri = Uri.parse(url);

      if (uri.queryParameters["error"] != null) {
        _webView.close();
        throw new Exception("Access denied or authentation canceled.");
      }

      if (uri.queryParameters["code"] != null) {
        print( "O Code Challange é : "+
            uri.queryParameters["code"]);
        _webView.close();
        _onCodeListener.add(uri.queryParameters["code"]);
      }
    });

    code = await _onCode.first;
    return code;
  }

  Future<void> clearCookies() async {
    await _webView.launch("", hidden: true, clearCookies: true);
    await _webView.close();
  }

  String _constructUrlParams() =>
      _mapToQueryParams(_authorizationRequest.parameters);

  String _mapToQueryParams(Map<String, String> params) {
    final queryParams = <String>[];
    params
        .forEach((String key, String value) => queryParams.add("$key=$value"));
    return queryParams.join("&");
  }
}
