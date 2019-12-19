package com.zellar.identity_server.webview.chrome_custom_tabs;

import androidx.browser.customtabs.CustomTabsClient;

public interface ServiceConnectionCallback {
    void onServiceConnected(CustomTabsClient client);

    void onServiceDisconnected();
}
