
import 'package:calendar_recurrence/src/data/byday.dart';
import 'package:calendar_recurrence/src/exception/conditional_exception.dart';
import 'package:calendar_recurrence/src/symbol/frequency.dart';
import 'package:calendar_recurrence/src/symbol/weekday.dart';

/// RecurrenceRule is a data type that represents recurrence rule of calendar.
class RecurrenceRule {
  RecurrenceRule(
    this.frequency, {
    this.count,
    this.until,
    this.interval,
    this.byday,
  }) {
    if (frequency == null) {
      throw new ConditionalException('`FREQ` is missing. the parameter is mandatory');
    }

    if (byday != null && byday.getNth() != null && byday.getWeekday().length >= 2) {
      throw new ConditionalException(
          'conflicted. it is prohibited to specify `Nth` of `BYDAY` with multiple weekdays.');
    }

    if (count != null && until != null) {
      throw new ConditionalException(
          'conflicted. it is prohibited to specify `COUNT` and `UNTIL` together.');
    }

    if (frequency == Frequency.DAILY && byday != null) {
      throw new ConditionalException(
          'conflicted. it is prohibited to specify `BYDAY` when `FREQ` is DAILY.');
    }

    if (frequency == Frequency.WEEKLY && byday != null && byday.getNth() != null) {
      throw new ConditionalException(
          'conflicted. it is prohibited to specify `Nth` of `BYDAY` when `FREQ` is WEEKLY.');
    }

    if (frequency == Frequency.YEARLY && byday != null) {
      throw new ConditionalException(
          'conflicted. it is prohibited to specify `BYDAY` when `FREQ` is YEARLY.');
    }
  }

  ///
  final Frequency frequency;

  ///
  final int count;

  ///
  final DateTime until;

  ///
  final int interval;

  ///
  final Byday byday;

  /// getFrequency returns frequency of recurrence that is specified by FREQ.
  Frequency getFrequency() => frequency;

  /// getCount returns count of recurrence that is specified by COUNT.
  int getCount() => count;

  /// getUntil returns until of recurrence that is specified by UNTIL.
  DateTime getUntil() => until;

  /// getInterval returns interval of recurrence that is specified by INTERVAL.
  int getInterval() => interval;

  /// getByday returns byday of recurrence that is specified by BYDAY.
  Byday getByday() => byday;

  /// asRuleText dumps the rule as a text.
  String asRuleText() {
    final StringBuffer sb =
        new StringBuffer('RRULE:FREQ=${FrequencyOperator.getSimpleName(frequency)}');

    if (count != null) {
      sb.write(';COUNT=$count');
    }

    if (until != null) {
      final String untilStr =
          until.toIso8601String().replaceAll(new RegExp(r'(?:[-:]|[.]000)'), '');
      sb.write(';UNTIL=$untilStr');
      if (!untilStr.endsWith('Z')) {
        sb.write('Z');
      }
    }

    if (interval != null) {
      sb.write(';INTERVAL=$interval');
    }

    if (byday != null) {
      final int nth = byday.getNth();
      final String weekdays = byday.getWeekday().map(WeekdayOperator.getSimpleName).join(',');
      sb.write(';BYDAY=${nth ?? ''}$weekdays');
    }

    return sb.toString();
  }
}
