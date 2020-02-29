import 'package:calendar_recurrence/src/exception/calendar_recurrence_exception.dart';

/// ConditionalException raises when recurrence rule has any conflicted states.
class ConditionalException implements RecurrenceException {
  ConditionalException(this._cause);

  final String _cause;

  @override
  String toString() => _cause;
}
