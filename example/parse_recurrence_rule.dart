import 'package:calendar_recurrence/calendar_recurrence.dart';
import 'package:calendar_recurrence/src/calendar_recurrence.dart';

void main() {
  final List<String> recurrenceRuleTexts = [
    'RRULE:FREQ=DAILY',
    // put recurrence rule texts
  ];

  List<RecurrenceRule> rules;
  try {
    rules = Recurrence.fromTexts(recurrenceRuleTexts);
  } catch (ex) {
    // There is possibility to occur InvalidSyntaxException and/or ConditionalException
    // do something
    rethrow;
  }

  for (RecurrenceRule rule in rules) {
    print(rule.asRuleText());
  }
}
