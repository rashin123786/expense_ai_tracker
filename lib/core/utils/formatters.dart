import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  static final DateFormat _dayMonth = DateFormat('MMM d, yyyy');

  static String date(DateTime date) => _dayMonth.format(date);
}
