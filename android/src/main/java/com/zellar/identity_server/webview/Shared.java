package com.zellar.identity_server.webview;

import android.app.Activity;
import android.content.Context;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.PluginRegistry;

public class Shared {
    public static Context applicationContext;
    public static PluginRegistry.Registrar registrar;
    public static FlutterPlugin.FlutterAssets flutterAssets;
    public static ActivityPluginBinding activityPluginBinding;
    public static Activity activity;
}
