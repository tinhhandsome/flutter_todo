import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/blocs/blocs.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/repositories/repositories.dart';
import 'package:mockito/mockito.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  SettingsBloc settingsBloc;
  MockSettingsRepository settingsRepository;

  setUp(() {
    settingsRepository = MockSettingsRepository();
    settingsBloc = SettingsBloc(repository: settingsRepository);
  });

  tearDown(() {
    settingsBloc?.close();
  });

  group("SettingsBloc", () {
    test('initial state is correct', () {
      expect(settingsBloc.initialState, SettingsInitialState());
    });

    test('Get settings', () {
      when(settingsRepository.settings)
          .thenAnswer((_) => Settings(themeMode: 1));

      var settings = settingsBloc.settings;

      expect(1, equals(settings.themeMode));
    });

    blocTest<SettingsBloc, SettingsEvent, SettingsState>(
      'emits [SettingsLoadingState, SettingsUpdatedSettingsState]'
      ' when successful',
      build: () async {
        var settings = Settings(themeMode: 2);
        when(settingsRepository.updateSetting(settings))
            .thenAnswer((_) async => true);
        return settingsBloc;
      },
      act: (bloc) async =>
          settingsBloc.add(SettingsUpdateSettingsEvent(Settings(themeMode: 2))),
      expect: [
        SettingsLoadingState(),
        SettingsUpdatedSettingsState(Settings(themeMode: 2))
      ],
    );
  });
}
