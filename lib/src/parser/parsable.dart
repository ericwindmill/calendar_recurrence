import 'package:calendar_recurrence/src/parser/parse_result.dart';

abstract class Parsable<T> {
  ParseResult<T> parse(final String subject);
}
