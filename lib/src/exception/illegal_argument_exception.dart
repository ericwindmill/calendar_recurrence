import 'package:calendar_recurrence/src/exception/calendar_recurrence_exception.dart';

/// IllegalArgumentException raises when given argument is invalid.
class IllegalArgumentException extends RecurrenceException {
  IllegalArgumentException(this._cause);

  final String _cause;

  @override
  String toString() => _cause;
}
