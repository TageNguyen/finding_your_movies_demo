extension DurationEX on Duration {
  static Duration parseFromISO8601(String source) {
    final minuteString = RegExp(r'\d+').firstMatch(source)?.group(0) ?? '0';
    return Duration(minutes: int.parse(minuteString));
  }
}
