import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/blocs/blocs.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      var settings = BlocProvider.of<SettingsBloc>(context).settings;

      return Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              child: Center(child: Text("Todo App")),
            ),
            ListTile(
              title: const Text("Dark mode"),
              trailing: CupertinoSwitch(
                activeColor: Theme.of(context).primaryColor,
                value: settings.themeMode == 2,
                onChanged: (value) {
                  settings.themeMode = value ? 2 : 1;
                  BlocProvider.of<SettingsBloc>(context)
                      .add(SettingsUpdateSettingsEvent(settings));
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
