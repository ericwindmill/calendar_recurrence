import 'package:calendar_recurrence/src/data/byday.dart';
import 'package:calendar_recurrence/src/data/recurrence_rule.dart';
import 'package:calendar_recurrence/src/parser/byday_parser.dart';
import 'package:calendar_recurrence/src/parser/count_parser.dart';
import 'package:calendar_recurrence/src/parser/frequency_parser.dart';
import 'package:calendar_recurrence/src/parser/interval_parser.dart';
import 'package:calendar_recurrence/src/parser/parse_result.dart';
import 'package:calendar_recurrence/src/parser/rrule_parser.dart';
import 'package:calendar_recurrence/src/parser/until_parser.dart';
import 'package:calendar_recurrence/src/symbol/frequency.dart';

class RecurrenceRuleParser {
  static RecurrenceRule parse(final String given) {
    // starts with `RRULE:`
    String remain = new RruleParser().parse(given).getRemain();

    // FREQ
    final ParseResult<Frequency> freqResult = new FrequencyParser().parse(remain);
    remain = freqResult.getRemain();

    // BYDAY
    final ParseResult<Byday> bydayResult = new BydayParser().parse(remain);
    remain = bydayResult.getRemain();

    // COUNT
    final ParseResult<int> countResult = new CountParser().parse(remain);
    remain = countResult.getRemain();

    // INTERVAL
    final ParseResult<int> intervalResult = new IntervalParser().parse(remain);
    remain = intervalResult.getRemain();

    // UNTIL
    final ParseResult<DateTime> untilResult = new UntilParser().parse(remain);
    remain = untilResult.getRemain();

    return new RecurrenceRule(
      freqResult.getValue(),
      count: countResult.getValue(),
      until: untilResult.getValue(),
      interval: intervalResult.getValue(),
      byday: bydayResult.getValue(),
    );
  }
}
