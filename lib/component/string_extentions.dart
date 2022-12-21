class StringExtentions {
  static String ucwords(String str) {
    return str
        .toLowerCase()
        .split(" ")
        .map((e) => "${e[0].toUpperCase()}${e.substring(1)}")
        .join(" ");
  }
}
