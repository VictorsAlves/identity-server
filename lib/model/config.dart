import 'dart:convert';
import 'dart:math';


import 'package:flutter/widgets.dart';

class Config {

  String authorizationUrl;
  String tokenUrl;
  final String clientId;
  final String clientSecret;
  String redirectUri;
  String redirectUriEncoded;
  final String responseType;
  final String contentType;
  final String scope;
  final String resource;
  final String loginUrl;
  String codeVerifier;

  Rect screenSize;

  Config(this.clientId, this.scope, this.redirectUri,
      {this.clientSecret,
        this.redirectUriEncoded,
        this.codeVerifier,
        this.loginUrl = "https://identity-server-dev.zellar.com.br/Account/Login?ReturnUrl=",
        this.resource,
        this.responseType = "code",
        this.contentType = "application/x-www-form-urlencoded",
        this.screenSize}) {
    this.authorizationUrl = "https://identity-server-dev.zellar.com.br/connect/authorize";
    this.tokenUrl = "https://identity-server-dev.zellar.com.br/connect/token";
  }

  String createURL() {
    this.codeVerifier = this.generateCodeChallenge();
    /*inicializo a variavel que será encodada duas vezes*/
    this.redirectUriEncoded = this.redirectUri;
    return loginUrl + requestUrlEncode("/connect/authorize/callback?redirect_uri=$redirectUriEncoded&client_id=$clientId&response_type=code&scope=$scope&code_challenge=$codeVerifier&code_challenge_method=S256");
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
