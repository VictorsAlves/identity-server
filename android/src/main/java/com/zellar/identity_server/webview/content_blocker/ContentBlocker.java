package com.zellar.identity_server.webview.content_blocker;

public class ContentBlocker {
    public ContentBlockerTrigger trigger;
    public ContentBlockerAction action;

    public ContentBlocker (ContentBlockerTrigger trigger, ContentBlockerAction action) {
        this.trigger = trigger;
        this.action = action;
    }
}

