// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S(this.localeName);
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S(localeName);
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  final String localeName;

  String get appName {
    return Intl.message(
      'To Do',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  String get allLabel {
    return Intl.message(
      'All',
      name: 'allLabel',
      desc: '',
      args: [],
    );
  }

  String get addLabel {
    return Intl.message(
      'Add',
      name: 'addLabel',
      desc: '',
      args: [],
    );
  }

  String get addTimeLabel {
    return Intl.message(
      'Add time',
      name: 'addTimeLabel',
      desc: '',
      args: [],
    );
  }

  String get backAgainToLeaveMessage {
    return Intl.message(
      'Back again to leave',
      name: 'backAgainToLeaveMessage',
      desc: '',
      args: [],
    );
  }

  String get completedLabel {
    return Intl.message(
      'Completed',
      name: 'completedLabel',
      desc: '',
      args: [],
    );
  }

  String get darkModeTitle {
    return Intl.message(
      'Dark mode',
      name: 'darkModeTitle',
      desc: '',
      args: [],
    );
  }

  String get descriptionHintText {
    return Intl.message(
      'Description',
      name: 'descriptionHintText',
      desc: '',
      args: [],
    );
  }

  String get incompleteLabel {
    return Intl.message(
      'Incomplete',
      name: 'incompleteLabel',
      desc: '',
      args: [],
    );
  }

  String get languageTitle {
    return Intl.message(
      'Language',
      name: 'languageTitle',
      desc: '',
      args: [],
    );
  }

  String get myTasksTitle {
    return Intl.message(
      'My Tasks',
      name: 'myTasksTitle',
      desc: '',
      args: [],
    );
  }

  String oneDeletedMessage(dynamic number) {
    return Intl.message(
      '$number deleted',
      name: 'oneDeletedMessage',
      desc: '',
      args: [number],
    );
  }

  String oneCompletedMessage(dynamic number) {
    return Intl.message(
      '$number completed',
      name: 'oneCompletedMessage',
      desc: '',
      args: [number],
    );
  }

  String oneMarkedIncompleteMessage(dynamic number) {
    return Intl.message(
      '$number marked incomplete',
      name: 'oneMarkedIncompleteMessage',
      desc: '',
      args: [number],
    );
  }

  String get saveLabelButton {
    return Intl.message(
      'Save',
      name: 'saveLabelButton',
      desc: '',
      args: [],
    );
  }

  String get titleHintText {
    return Intl.message(
      'Title',
      name: 'titleHintText',
      desc: '',
      args: [],
    );
  }

  String get undoLabelButton {
    return Intl.message(
      'Undo',
      name: 'undoLabelButton',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale('en', ''), Locale('vi', ''),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}