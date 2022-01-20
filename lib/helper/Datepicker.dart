import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class Datepicker {
  Datepicker._();
  static selectDate(context) async {
    print(Localizations.localeOf(context).toString());
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 50),
      lastDate: DateTime(2025),
    );
    if (picked != null) return picked;
  }
}
