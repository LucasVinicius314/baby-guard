import 'package:baby_guard/utils/utils.dart';
import 'package:intl/intl.dart';

enum DateFormattingMode {
  dayMonthShort,
  slashSeparated,
  slashSeparatedLong,
}

class Formatting {
  static final _dateFormatDayMonthShort = DateFormat.MMMd('pt_BR');
  static final _dateFormatSlashSeparated = DateFormat('dd/MM/yyyy');
  static final _dateFormatSlashSeparatedLong =
      DateFormat('dd/MM/yyyy HH:mm:ss');

  static String date(DateTime? dateTime, {required DateFormattingMode mode}) {
    if (dateTime == null) {
      return '';
    }

    switch (mode) {
      case DateFormattingMode.dayMonthShort:
        return _dateFormatDayMonthShort.format(dateTime);
      case DateFormattingMode.slashSeparated:
        return _dateFormatSlashSeparated.format(dateTime);
      case DateFormattingMode.slashSeparatedLong:
        return _dateFormatSlashSeparatedLong.format(dateTime);
      default:
        return '';
    }
  }

  static String daysAgoString(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }

    final today = Utils.getToday();

    final then = dateTime.toUtc();
    final targetDay = DateTime.utc(then.year, then.month, then.day);

    final duration = today.difference(targetDay);

    final days = duration.inDays;

    if (days == 0) {
      return 'Hoje';
    }

    if (days == 1) {
      return 'Ontem';
    }

    return 'Há ${days.toStringAsFixed(0)} dias';
  }
}
