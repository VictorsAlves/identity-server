package com.zellar.identity_server.webview.chrome_custom_tabs;

import com.zellar.identity_server.webview.Options;

public class ChromeCustomTabsOptions extends Options {
    final static String LOG_TAG = "ChromeCustomTabsOptions";

    public boolean addShareButton = true;
    public boolean showTitle = true;
    public String toolbarBackgroundColor = "";
    public boolean enableUrlBarHiding = false;
    public boolean instantAppsEnabled = false;
}
