import 'package:calendar_recurrence/src/exception/invalid_syntax_exception.dart';
import 'package:calendar_recurrence/src/parser/parsable.dart';
import 'package:calendar_recurrence/src/parser/parse_result.dart';

class CountParser implements Parsable<int> {
  static final RegExp _countRE = new RegExp(r'COUNT=([0-9]+);?');

  @override
  ParseResult<int> parse(final String subject) {
    final Iterable<Match> matches = _countRE.allMatches(subject);

    if (matches.isEmpty) {
      return new ParseResult<int>(subject, null);
    }

    if (matches.length >= 2) {
      throw new InvalidSyntaxException(
          'syntax error: `COUNT` can appear to once at most.');
    }

    final Match countMatched = matches.single;
    return new ParseResult<int>(
      subject.replaceAll(_countRE, ''),
      int.parse(countMatched.group(1), radix: 10),
    );
  }
}
