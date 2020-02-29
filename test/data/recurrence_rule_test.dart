import 'package:calendar_recurrence/calendar_recurrence.dart';

import 'package:test/test.dart';

void main() {
  group('instantiate', () {
    test('should instantiate successfully', () {
      [
        RecurrenceRule(
          Frequency.DAILY,
          count: null,
          until: null,
          interval: null,
          byday: null,
        ),
        RecurrenceRule(
          Frequency.MONTHLY,
          count: 123,
          until: null,
          interval: 2,
          byday: Byday(
            [Weekday.MO],
            nth: 2,
          ),
        ),
        RecurrenceRule(
          Frequency.WEEKLY,
          count: null,
          until: DateTime.now(),
          interval: 2,
          byday: Byday(
            [Weekday.MO, Weekday.FR],
            nth: null,
          ),
        ),
      // ignore: avoid_function_literals_in_foreach_calls
      ].forEach((r) => expect(r is RecurrenceRule, isTrue));
    });

    test('should fail instantiate without frequency', () {
      Exception err;
      try {
        RecurrenceRule(null);
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is ConditionalException, isTrue);
      expect(err.toString(), equals('`FREQ` is missing. the parameter is mandatory'));
    });

    test('should fail instantiate with Nth and multiple weekdays', () {
      Exception err;
      try {
        RecurrenceRule(
          Frequency.MONTHLY,
          byday: Byday(
            <Weekday>[Weekday.MO, Weekday.TU],
            nth: 2,
          ),
        );
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is ConditionalException, isTrue);
      expect(
          err.toString(),
          equals(
              'conflicted. it is prohibited to specify `Nth` of `BYDAY` with multiple weekdays.'));
    });

    test('should fail instantiate when both of count and until are not null', () {
      Exception err;
      try {
        RecurrenceRule(
          Frequency.DAILY,
          count: 123,
          until: DateTime.now(),
          interval: 2,
          byday: Byday(
            [Weekday.MO],
            nth: 2,
          ),
        );
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is ConditionalException, isTrue);
      expect(err.toString(),
          equals('conflicted. it is prohibited to specify `COUNT` and `UNTIL` together.'));
    });

    test('should fail instantiate when `BYDAY` is specified even if frequency is DAILY', () {
      Exception err;
      try {
        RecurrenceRule(
          Frequency.DAILY,
          byday: Byday([Weekday.MO]),
        );
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is ConditionalException, isTrue);
      expect(err.toString(),
          equals('conflicted. it is prohibited to specify `BYDAY` when `FREQ` is DAILY.'));
    });

    test('should fail instantiate when `Nth` of `BYDAY` is specified even if frequency is WEEKLY',
        () {
      Exception err;
      try {
        RecurrenceRule(
          Frequency.WEEKLY,
          byday: Byday(
            [Weekday.MO],
            nth: 2,
          ),
        );
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is ConditionalException, isTrue);
      expect(
          err.toString(),
          equals(
              'conflicted. it is prohibited to specify `Nth` of `BYDAY` when `FREQ` is WEEKLY.'));
    });

    test('should fail instantiate when `BYDAY` is specified even if frequency is YEARLY', () {
      Exception err;
      try {
        RecurrenceRule(
          Frequency.YEARLY,
          byday: Byday(
            [Weekday.MO],
          ),
        );
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is ConditionalException, isTrue);
      expect(err.toString(),
          equals('conflicted. it is prohibited to specify `BYDAY` when `FREQ` is YEARLY.'));
    });
  });

  group('.asRuleText', () {
    test('most simple case', () {
      expect(RecurrenceRule(Frequency.DAILY).asRuleText(), equals('RRULE:FREQ=DAILY'));
    });

    test('with count', () {
      expect(
          RecurrenceRule(
            Frequency.DAILY,
            count: 10,
          ).asRuleText(),
          equals('RRULE:FREQ=DAILY;COUNT=10'));
    });

    test('with until', () {
      final DateTime dt = DateTime(2020, 6, 12, 20, 12, 32);
      expect(
          RecurrenceRule(
            Frequency.DAILY,
            until: dt,
          ).asRuleText(),
          equals('RRULE:FREQ=DAILY;UNTIL=20200612T201232Z'));
    });

    test('with interval', () {
      expect(
          RecurrenceRule(
            Frequency.DAILY,
            interval: 2,
          ).asRuleText(),
          equals('RRULE:FREQ=DAILY;INTERVAL=2'));
    });

    test('with byday (single, wituhout Nth)', () {
      expect(
          RecurrenceRule(Frequency.WEEKLY,
              byday: Byday(
                [Weekday.TU],
              )).asRuleText(),
          equals('RRULE:FREQ=WEEKLY;BYDAY=TU'));
    });

    test('with byday (multi, wituhout Nth)', () {
      expect(
          RecurrenceRule(
            Frequency.WEEKLY,
            byday: Byday(
              [Weekday.MO, Weekday.TU, Weekday.WE, Weekday.TH, Weekday.FR],
            ),
          ).asRuleText(),
          equals('RRULE:FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR'));
    });

    test('with byday (single, with Nth)', () {
      expect(
          RecurrenceRule(
            Frequency.MONTHLY,
            byday: Byday(
              [Weekday.TU],
              nth: 3,
            ),
          ).asRuleText(),
          equals('RRULE:FREQ=MONTHLY;BYDAY=3TU'));
    });

    test('complex case', () {
      expect(
          RecurrenceRule(
            Frequency.WEEKLY,
            count: 123,
            interval: 2,
            byday: Byday(
              [Weekday.SA, Weekday.SU],
            ),
          ).asRuleText(),
          equals('RRULE:FREQ=WEEKLY;COUNT=123;INTERVAL=2;BYDAY=SA,SU'));
    });
  });
}
