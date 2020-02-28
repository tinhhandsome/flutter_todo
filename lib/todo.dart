import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/sevices/locator.dart';
import 'package:flutter_todo/sevices/services.dart';
import 'package:flutter_todo/utils/themes.dart';
import 'blocs/blocs.dart';
import 'ui/screens/screens.dart';

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
      child:
          BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
        return BlocProvider<TasksBloc>(
          create: (context) =>
              TasksBloc(todoBloc: BlocProvider.of<TodoBloc>(context)),
          child: MaterialApp(
            navigatorKey: locator<NavigationService>().navigatorKey,
            title: "Todo",
            darkTheme: Themes.getTheme(ThemeMode.dark),
            theme: Themes.getTheme(ThemeMode.light),
            themeMode: ThemeMode.values[
                BlocProvider.of<SettingsBloc>(context).settings.themeMode],
            initialRoute: NavigationScreen.routeName,
            onGenerateRoute: (settings) {
              Widget page;
              switch (settings.name) {
                case NavigationScreen.routeName:
                  page = NavigationScreen();
                  break;
              }
              return MaterialPageRoute(builder: (context) => page);
            },
          ),
        );
      }),
    );
  }
}
