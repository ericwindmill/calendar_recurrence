import 'package:calendar_recurrence/src/exception/invalid_syntax_exception.dart';
import 'package:calendar_recurrence/src/parser/parsable.dart';
import 'package:calendar_recurrence/src/parser/parse_result.dart';
import 'package:calendar_recurrence/src/symbol/frequency.dart';

class FrequencyParser implements Parsable<Frequency> {
  static final RegExp _freqRE = new RegExp(r'FREQ=([^;]+);?');

  @override
  ParseResult<Frequency> parse(final String subject) {
    final Iterable<Match> matches = _freqRE.allMatches(subject);

    if (matches.isEmpty) {
      return new ParseResult<Frequency>(subject, null);
    }

    if (matches.length >= 2) {
      throw new InvalidSyntaxException(
          'syntax error: `FREQ` can appear to once at most.');
    }

    final Match freqMatched = matches.single;
    return new ParseResult<Frequency>(
      subject.replaceAll(_freqRE, ''),
      FrequencyOperator.fromString(freqMatched.group(1)),
    );
  }
}
