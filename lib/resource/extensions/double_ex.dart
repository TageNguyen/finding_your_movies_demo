import 'package:intl/intl.dart';

extension DoubleEX on double {
  static double parseFromDynamic(dynamic source) =>
      double.tryParse(source.toString()) ?? 0.0;

  String toStringFormat() {
    if (this == truncateToDouble()) {
      return NumberFormat.decimalPattern().format(toInt());
    } else {
      return NumberFormat.decimalPattern().format(this);
    }
  }
}
