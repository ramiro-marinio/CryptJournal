import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd hh:mm').format(date);
}
