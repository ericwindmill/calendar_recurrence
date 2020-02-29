import 'package:calendar_recurrence/calendar_recurrence.dart';
import 'package:calendar_recurrence/src/calendar_recurrence.dart';

void main() {
  // ignore: avoid_single_cascade_in_expression_statements
  Recurrence.toTexts([
    RecurrenceRule(
      Frequency.DAILY,
      count: null,
      until: DateTime(2021),
      interval: 2,
      byday: null,
    ),
  ])
    ..forEach(print);
}
