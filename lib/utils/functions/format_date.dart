import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return '${DateFormat('yyyy-MM-dd').format(date)} | ${DateFormat('hh:mm a').format(date)}';
}
