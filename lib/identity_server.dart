import 'dart:async';

import 'package:flutter/services.dart';
import 'package:identity_server/request/token-request.dart';
import 'package:identity_server/response/token-response.dart';
import 'request/authorization-request.dart';
import 'response/authorization-response.dart';
import 'request/authorization-token-request.dart';
import 'response/authorization-token-response.dart';

class FlutterAppAuth {
  static const MethodChannel _channel =
      const MethodChannel('identity_server');

    static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// Convenience method for authorizing and then exchanges code
  Future<AuthorizationTokenResponse> authorizeAndExchangeCode(
      AuthorizationTokenRequest request) async {
    var result = await _channel.invokeMethod(
        'authorizeAndExchangeCode', request.toMap());
    return AuthorizationTokenResponse(
        result['accessToken'],
        result['refreshToken'],
        result['accessTokenExpirationTime'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(
            result['accessTokenExpirationTime'].toInt()),
        result['idToken'],
        result['tokenType'],
        result['authorizationAdditionalParameters']?.cast<String, dynamic>(),
        result['tokenAdditionalParameters']?.cast<String, dynamic>());
  }

  Future<AuthorizationResponse> authorize(AuthorizationRequest request) async {
    var result = await _channel.invokeMethod('authorize', request.toMap());
    return AuthorizationResponse(
        result['authorizationCode'],
        result['codeVerifier'],
        result['authorizationAdditionalParameters']?.cast<String, dynamic>());
  }

  /// For exchanging tokens
  Future<TokenResponse> token(TokenRequest request) async {
    var result = await _channel.invokeMethod('token', request.toMap());
    return TokenResponse(
        result['accessToken'],
        result['refreshToken'],
        result['accessTokenExpirationTime'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(
            result['accessTokenExpirationTime'].toInt()),
        result['idToken'],
        result['tokenType'],
        result['tokenAdditionalParameters']?.cast<String, String>());
  }
}

