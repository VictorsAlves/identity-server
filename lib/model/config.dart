import 'dart:convert';
import 'dart:math';


import 'package:flutter/widgets.dart';
import 'package:identity_server/authorization-service-configuration.dart';

class Config {
  String authorizationUrl;
  String tokenUrl;
  final String clientId;
  final String clientSecret;
  String redirectUri;
  String redirectUriEncoded;
  final String responseType;
  final String contentType;
  final List<String> scope;
  final String resource;
  final String loginUrl;
  String code;
  AuthorizationServiceConfiguration clientConfig;


  Rect screenSize;

  Config(this.clientId, this.scope, this.redirectUri,
      {this.clientSecret,
        this.redirectUriEncoded,
        this.code,
        this.loginUrl =
        "https://identity-server-dev.zellar.com.br/Account/Login?ReturnUrl=",
        this.resource,
        this.responseType = "code",
        this.contentType = "application/x-www-form-urlencoded",
        this.screenSize}) {
    this.authorizationUrl = clientConfig.authorizationEndpoint;
    this.tokenUrl = clientConfig.tokenEndpoint;
  }

  String createURL() {
    this.code = this. generateCodeChallenge();
    this.redirectUriEncoded = this.redirectUri;
    return loginUrl +
        requestUrlEncode(
            "/connect/authorize/callback?redirect_uri=$redirectUriEncoded&client_id=$clientId&response_type=code&scope=$scope&code_challenge=$code&code_challenge_method=S256");
  }

  String generateCodeChallenge() {
    var random = Random.secure();
    var values = List<int>.generate(32, (i) => random.nextInt(256));
    while (base64Url.encode(values).length < 44) {
      values = List<int>.generate(32, (i) => random.nextInt(256));
      print(values);
    }
    //return base64Url.encode(values);
    return "8IIEoqcNYZwEp08WgeqsPeZlu7RlZuTjLPx26h8yRfc="; }

  String requestUrlEncode(String url) {
    this.redirectUriEncoded = Uri.encodeComponent(redirectUri);
    return Uri.encodeComponent(url);
  }





}
