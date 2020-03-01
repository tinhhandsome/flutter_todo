import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_todo/blocs/blocs.dart';
import 'package:flutter_todo/utils/themes/themes.dart';

void showDateTimePicker(BuildContext context,
    {DateTime current, Function(DateTime) onConfirm}) {
  DatePicker.showDateTimePicker(
    context,
    showTitleActions: true,
    locale: BlocProvider.of<SettingsBloc>(context).settings.languageCode == "vi"
        ? LocaleType.vi
        : LocaleType.en,
    theme: Themes.getDateThemPickerTheme(context),
    minTime: DateTime(2018, 3, 5),
    maxTime: DateTime.now().add(const Duration(days: 365)),
    onChanged: (date) {},
    onConfirm: onConfirm,
    currentTime: current,
  );
}
