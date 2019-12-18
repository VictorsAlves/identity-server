package com.zellar.identity_server.webview;

import android.annotation.TargetApi;
import android.content.Context;
import android.hardware.display.DisplayManager;
import android.os.Build;
import android.view.View;
import android.webkit.WebStorage;
import android.webkit.WebViewClient;

import java.util.Collections;
import java.util.List;
import java.util.Map;


import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.platform.PlatformView;

public class FlutterWebView implements PlatformView {
    Map<String, Object> arguments;
    Map<String, String> header;
    String argument;
    String url;
    Object obj;

    private void populaMapper() {
        this.argument = "argument";
        this.url = "https://www.google.com.br";

        for (int i = 0; i < 5; i++) {
            this.arguments.put("value", "item");
        }

        for (int i = 0; i < 5; i++) {
            this.header.put("value", "item");

        }
    }


    private static final String JS_CHANNEL_NAMES_FIELD = "javascriptChannelNames";
    private final InputAwareWebView webView;
    // private final MethodChannel methodChannel;
    private final FlutterWebViewClient flutterWebViewClient;
    // private final Handler platformThreadHandler;


    @SuppressWarnings("unchecked")
    public FlutterWebView(
            final Context context,
            BinaryMessenger messenger,
            Map<String, Object> params,
            final View containerView) {

        params.put("settings","settings");

        params.put("autoMediaPlaybackPolicy","settings");

        params.put("settings","settings");


        DisplayListenerProxy displayListenerProxy = new DisplayListenerProxy();
        DisplayManager displayManager =
                (DisplayManager) context.getSystemService(Context.DISPLAY_SERVICE);
        displayListenerProxy.onPreWebViewInitialization(displayManager);
        webView = new InputAwareWebView(context, containerView);
        displayListenerProxy.onPostWebViewInitialization(displayManager);

//        platformThreadHandler = new Handler(context.getMainLooper());
        // Allow local storage.
        webView.getSettings().setDomStorageEnabled(true);

        //methodChannel = new MethodChannel(messenger, "plugins.flutter.io/webview_" + id);
        //methodChannel.setMethodCallHandler(this);
        populaMapper();
        String method = null;
        flutterWebViewClient = new FlutterWebViewClient(method);
        applySettings((Map<String, Object>) params.get("settings"));

  /*      if (params.containsKey(JS_CHANNEL_NAMES_FIELD)) {
            registerJavaScriptChannelNames((List<String>) params.get(JS_CHANNEL_NAMES_FIELD));
        }*/

        updateAutoMediaPlaybackPolicy((Integer) params.get("autoMediaPlaybackPolicy"));
        if (params.containsKey("userAgent")) {
            String userAgent = (String) params.get("userAgent");
            updateUserAgent(userAgent);
        }
        if (params.containsKey("initialUrl")) {
            String url = (String) params.get("initialUrl");
            webView.loadUrl(url);
        }
    }

    public void escolhaDeMetodo(String metodo) {
        switch (metodo) {
            case "loadUrl":
                loadUrl(url, header);
                break;
            case "updateSettings":
                updateSettings(arguments);
                break;
            case "canGoBack":
                canGoBack();
                break;
            case "canGoForward":
                canGoForward();
                break;
            case "goBack":
                goBack();
                break;
            case "goForward":
                goForward();
                break;
            case "reload":
                reload();
                break;
            case "currentUrl":
                currentUrl();
                break;
            case "evaluateJavascript":
                evaluateJavaScript(argument);
                break;
            case "addJavascriptChannels":
                addJavaScriptChannels(arguments);
                break;
            case "removeJavascriptChannels":
                removeJavaScriptChannels(arguments);
                break;
            case "clearCache":
                clearCache(obj);
                break;
            default:
                System.out.println("erro, não foi dessa vez!");
        }
    }

    @Override
    public View getView() {
        return webView;
    }

    private void canGoBack() {
        webView.canGoBack();
    }

    private void canGoForward() {
        webView.canGoForward();
    }

    private void goBack() {
        if (webView.canGoBack()) {
            webView.goBack();
        }

    }

    private void addJavaScriptChannels(Map<String, Object> arguments) {
        List<String> channelNames = (List<String>) arguments;
        registerJavaScriptChannelNames(channelNames);

    }

    private void removeJavaScriptChannels(Map<String, Object> arguments) {
        List<String> channelNames = (List<String>) arguments;
        for (String channelName : channelNames) {
            webView.removeJavascriptInterface(channelName);
        }

    }

    private void registerJavaScriptChannelNames(List<String> channelNames) {
        Object obj = null;
        for (String channelName : channelNames) {
            webView.addJavascriptInterface(
                    obj, channelName);
        }
    }

    @TargetApi(Build.VERSION_CODES.KITKAT)
    private void evaluateJavaScript(String arguments) {
        String jsString = (String) arguments;
        if (jsString == null) {
            throw new UnsupportedOperationException("JavaScript string cannot be null");
        }
        webView.evaluateJavascript(
                jsString,
                new android.webkit.ValueCallback<String>() {
                    @Override
                    public void onReceiveValue(String value) {

                    }
                });
    }

    public void onInputConnectionUnlocked() {
        webView.unlockInputConnection();
    }

    public void onInputConnectionLocked() {
        webView.lockInputConnection();
    }

    private void clearCache(Object result) {
        webView.clearCache(true);
        WebStorage.getInstance().deleteAllData();
    }

    private void applySettings(Map<String, Object> settings) {
        for (String key : settings.keySet()) {
            switch (key) {
                case "jsMode":
                    updateJsMode((Integer) settings.get(key));
                    break;
                case "hasNavigationDelegate":
                    final boolean hasNavigationDelegate = (boolean) settings.get(key);

                    final WebViewClient webViewClient =
                            flutterWebViewClient.createWebViewClient(hasNavigationDelegate);

                    webView.setWebViewClient(webViewClient);
                    break;
                case "debuggingEnabled":
                    final boolean debuggingEnabled = (boolean) settings.get(key);

                    webView.setWebContentsDebuggingEnabled(debuggingEnabled);
                    break;
                case "userAgent":
                    updateUserAgent((String) settings.get(key));
                    break;
                default:
                    throw new IllegalArgumentException("Unknown WebView setting: " + key);
            }
        }
    }

    private void updateJsMode(int mode) {
        switch (mode) {
            case 0: // disabled
                webView.getSettings().setJavaScriptEnabled(false);
                break;
            case 1: // unrestricted
                webView.getSettings().setJavaScriptEnabled(true);
                break;
            default:
                throw new IllegalArgumentException("Trying to set unknown JavaScript mode: " + mode);
        }
    }

    private void updateAutoMediaPlaybackPolicy(int mode) {
        // This is the index of the AutoMediaPlaybackPolicy enum, index 1 is always_allow, for all
        // other values we require a user gesture.
        boolean requireUserGesture = mode != 1;
        webView.getSettings().setMediaPlaybackRequiresUserGesture(requireUserGesture);
    }

 /*   private void registerJavaScriptChannelNames(List<String> channelNames) {
        for (String channelName : channelNames) {
            webView.addJavascriptInterface(
                    new JavaScriptChannel(methodChannel, channelName, platformThreadHandler), channelName);
        }
    }*/

    private void updateUserAgent(String userAgent) {
        webView.getSettings().setUserAgentString(userAgent);
    }


    private void goForward() {
        if (webView.canGoForward()) {
            webView.goForward();
        }

    }

    private void reload() {
        webView.reload();

    }

    private void currentUrl() {
        webView.getUrl();
    }

    @SuppressWarnings("unchecked")
    private void updateSettings(Map<String, Object> arguments) {
        applySettings((Map<String, Object>) arguments);

    }

    private void loadUrl(String url, Map<String, String> headers) {

        if (headers == null) {
            headers = Collections.emptyMap();
        }
        webView.loadUrl(url, headers);
    }

    @Override
    public void dispose() {
        webView.dispose();
        webView.destroy();
    }

}
