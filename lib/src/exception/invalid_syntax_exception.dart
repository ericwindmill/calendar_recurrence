import 'package:calendar_recurrence/src/exception/calendar_recurrence_exception.dart';

/// InvalidSyntaxException raises when recurrence rule sytax has something wrong.
class InvalidSyntaxException implements RecurrenceException {
  InvalidSyntaxException(this._cause);

  final String _cause;

  @override
  String toString() => _cause;
}
