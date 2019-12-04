class RequestUtils {
  String requestUrlEncode(String url) {
    String value = Uri.encodeComponent(url);
    return Uri.encodeComponent(value);
  }
}
