import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/blocs/blocs.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/repositories/repositories.dart';
import 'package:mockito/mockito.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {
//  Settings _settings = Settings();
//
//  @override
//  Settings get settings => _settings;
//
//  @override
//  Future<bool> updateSetting(Settings settings) async {
//    _settings = settings;
//    return true;
//  }
}

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

    test('Get and update settings', () {
      var settings = settingsBloc.settings;

      final expectedResponse = <SettingsState>[
        SettingsInitialState(),
        SettingsLoadingState(),
      ];

      when(settingsRepository.updateSetting(Settings(themeMode: 1)))
          .thenAnswer((_) => Future.value(true));

      expectLater(
        settingsBloc,
        emitsInOrder(expectedResponse),
      );
      settingsBloc.add(SettingsUpdateSettingsEvent(Settings(themeMode: 1)));
    });
  });
}
