import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/blocs/blocs.dart';
import 'package:flutter_todo/generated/l10n.dart';
import 'package:flutter_todo/services/services.dart';
import 'package:flutter_todo/ui/screens/screens.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      var settings = BlocProvider.of<SettingsBloc>(context).settings;

      return Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Center(
                  child: Text(
                S.of(context).appName,
                style: Theme.of(context).textTheme.title,
              )),
            ),
            ListTile(
              leading: Icon(Icons.brightness_2),
              title: Text(S.of(context).darkModeTitle),
              trailing: CupertinoSwitch(
                activeColor: Theme.of(context).primaryColor,
                value: settings.themeMode == 2,
                onChanged: (value) {
                  settings.themeMode = value ? 2 : 1;
                  BlocProvider.of<SettingsBloc>(context)
                      .add(SettingsUpdateSettingsEvent(settings));
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text(S.of(context).languageTitle),
              onTap: () {
                locator<NavigationService>().push(LanguageScreen.routeName);
              },
            ),
          ],
        ),
      );
    });
  }
}
