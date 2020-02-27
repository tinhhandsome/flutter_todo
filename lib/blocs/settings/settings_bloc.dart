import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/repositories/repositories.dart';
import 'bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _repository = SettingsRepository();

  Settings get settings => _repository.settings;

  @override
  SettingsState get initialState => InitialSettingsState();

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is SettingsUpdateSettingsEvent) {
      yield* _handleUpdateSettingsSettingsEvent(event);
      return;
    }
  }

  Stream<SettingsState> _handleUpdateSettingsSettingsEvent(
      SettingsUpdateSettingsEvent event) async* {
    yield SettingsLoadingState();
    try {
      await _repository.updateSetting(event.settings);
      yield SettingsUpdatedSettingsState(event.settings);
    } catch (exception) {
      yield SettingsErrorState(exception.toString());
    }
  }
}
