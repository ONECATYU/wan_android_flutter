extension TrimHTML on String {
  String trimHTML() {
    return this
        .replaceAll(RegExp("(<[^>]*>)|(</*>)"), "")
        .replaceAll(RegExp("\\n{2,}"), "")
        .replaceAll(RegExp("\\s{2,}"), "")
        .replaceAll("&nbsp;", " ")
        .replaceAll("&amp;", "&")
        .replaceAll("&ldquo;", "“")
        .replaceAll("&rdquo;", "”");
  }
}
