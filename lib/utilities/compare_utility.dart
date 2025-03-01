class CompareUtility {
  static bool nonStrictCompareIgnoreCase(String text1, String text2) {
    return RegExp(_createAnswerRegexForNonStrictCompareIgnoreCase(text1),
            unicode: true, caseSensitive: false)
        .hasMatch(text2);
  }

  static bool nonStrictCompare(String text1, String text2) {
    return RegExp(_createAnswerRegexForNonStrictCompareIgnoreCase(text1),
            unicode: true, caseSensitive: true)
        .hasMatch(text2);
  }

  static String _createAnswerRegexForNonStrictCompareIgnoreCase(String text) {
    String regex1String = r"\s*";
    RegExp regex1 = RegExp(regex1String, unicode: true);
    RegExp regex2 = RegExp(r"[\s\p{P}]", unicode: true);
    String toBeMatchedRegex = regex1String;
    for (int i = 0; i < text.length; i++) {
      if (regex2.hasMatch(text[i])) {
        if (!RegExp(r"[\.\^\$\*\+\?\(\)\[\{\\\|]", unicode: true)
            .hasMatch(text[i])) {
          if (!RegExp(r"\s", unicode: true).hasMatch(text[i])) {
            toBeMatchedRegex += "$regex1String${text[i]}";
          } else {
            if (regex1.hasMatch(text.substring(0, i)) ||
                regex1.hasMatch(text.substring(i + 1, text.length)) ||
                regex2.hasMatch(text[i + 1]) ||
                regex2.hasMatch(text[i - 1])) {
              toBeMatchedRegex += regex1String;
            } else {
              toBeMatchedRegex += r"\s+";
            }
          }
        } else {
          toBeMatchedRegex += "\\s*\\${text[i]}$regex1String";
        }
      } else {
        toBeMatchedRegex += text[i];
      }
      if (i == text.length - 1) {
        toBeMatchedRegex += regex1String;
      }
    }
    return toBeMatchedRegex;
  }
}
