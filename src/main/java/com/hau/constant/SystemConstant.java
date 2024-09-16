package com.hau.constant;

public class SystemConstant {
    public static final int ACTIVE_STATUS = 1;
    public static final int INACTIVE_STATUS = 0;
    public static String GOOGLE_CLIENT_ID = "236344479421-3djectr8kffvuu3ec4o7ceges5jv2jld.apps.googleusercontent.com";

    public static String GOOGLE_CLIENT_SECRET = "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";

    public static String GOOGLE_REDIRECT_URI = "http://localhost:8080/spring-mvc/login-google";

    public static String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";

    public static String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";

    public static String GOOGLE_GRANT_TYPE = "authorization_code";
}
