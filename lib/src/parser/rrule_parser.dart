import 'package:calendar_recurrence/src/exception/invalid_syntax_exception.dart';
import 'package:calendar_recurrence/src/parser/parsable.dart';
import 'package:calendar_recurrence/src/parser/parse_result.dart';

class RruleParser implements Parsable<dynamic> {
  static final RegExp _startRE = new RegExp(r'^RRULE:');

  @override
  ParseResult<dynamic> parse(final String subject) {
    if (!_startRE.hasMatch(subject)) {
      throw new InvalidSyntaxException(
          'syntax error: rule text must be started with `RRULE:`.');
    }

    final String remain = subject.replaceFirst(_startRE, '');

    return new ParseResult<dynamic>(remain, null);
  }
}
