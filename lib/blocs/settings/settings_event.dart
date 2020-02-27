import "package:equatable/equatable.dart";
import "package:flutter/foundation.dart";
import 'package:flutter_todo/models/models.dart';

@immutable
abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
  @override
  List<Object> get props => [];
}

class SettingsUpdateSettingsEvent extends SettingsEvent {
  final Settings settings;
  const SettingsUpdateSettingsEvent(this.settings);

  @override
  List<Object> get props => [settings];

  @override
  String toString() =>
      "SettingsUpdateSettingsEvent {settings: ${settings.toJson()}}";
}
