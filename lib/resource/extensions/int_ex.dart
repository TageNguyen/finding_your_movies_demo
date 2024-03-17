extension IntEX on int {
  static int parseFromDynamic(dynamic source) => int.tryParse(source.toString()) ?? 0;
}
