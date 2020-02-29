import 'package:calendar_recurrence/src/exception/illegal_argument_exception.dart';

/// Frequency represents the frequency of recurrence rule.
enum Frequency {
  DAILY,
  WEEKLY,
  MONTHLY,
  YEARLY,
}

/// FrequencyOperator is an operator for Frequency enum.
class FrequencyOperator {
  /// getSimpleName returns the simple name of a Frequency enum item.
  static String getSimpleName(Frequency freq) {
    switch (freq) {
      case Frequency.DAILY:
        return 'DAILY';
      case Frequency.WEEKLY:
        return 'WEEKLY';
      case Frequency.MONTHLY:
        return 'MONTHLY';
      case Frequency.YEARLY:
        return 'YEARLY';
    }

    // unreachable
    throw new IllegalArgumentException(
        'invalid frequency is given; something wrong in the library');
  }

  static final Map<String, Frequency> _str2freq =
      new Map<String, Frequency>.fromIterable(Frequency.values,
          // ignore: unnecessary_lambdas
          key: (dynamic v) => getSimpleName(v),
          value: (dynamic v) => v);

  /// fromString returns the Frequency enum item according to given argument.
  static Frequency fromString(final String given) {
    final Frequency freq = _str2freq[given];
    if (freq == null) {
      throw new IllegalArgumentException(
          'invalid frequency string is given: $given');
    }

    return freq;
  }
}
