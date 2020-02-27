import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/sevices/locator.dart';
import 'package:flutter_todo/sevices/services.dart';
import 'package:flutter_todo/utils/themes.dart';
import 'blocs/blocs.dart';

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc(),
        ),
        BlocProvider<TodoBloc>(
          create: (context) => TodoBloc(),
        ),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, snapshot) {
        return MaterialApp(
          navigatorKey: locator<NavigationService>().navigatorKey,
          title: "Todo",
          darkTheme: Themes.getTheme(ThemeMode.dark),
          theme: Themes.getTheme(ThemeMode.light),
        );
      }),
    );
  }
}
