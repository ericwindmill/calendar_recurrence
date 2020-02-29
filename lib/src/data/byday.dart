import 'package:calendar_recurrence/src/symbol/weekday.dart';

/// Byday is a data type that represents BYDAY node.
class Byday {
  Byday(this.weekday, {this.nth});

  final List<Weekday> weekday;
  final int nth;

  /// getWeekday returns a list of weekday(s) that is specified by BYDAY.
  List<Weekday> getWeekday() => weekday;

  /// getNth returns a Nth specifier (to specify Nth weekday).
  int getNth() => nth;
}
