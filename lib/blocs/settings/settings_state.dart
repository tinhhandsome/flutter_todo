import "package:equatable/equatable.dart";
import "package:flutter/foundation.dart";
import 'package:flutter_todo/models/models.dart';

@immutable
abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitialState extends SettingsState {}

class SettingsLoadingState extends SettingsState {}

class SettingsErrorState extends SettingsState {
  final String message;

  const SettingsErrorState(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => "SettingsErrorState {message: $message}";
}

class SettingsUpdatedSettingsState extends SettingsState {
  final Settings settings;
  const SettingsUpdatedSettingsState(this.settings);

  @override
  List<Object> get props => [settings];

  @override
  String toString() =>
      "SettingsUpdatedSettingsState {settings: ${settings.toJson()}";
}
