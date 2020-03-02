import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/blocs/blocs.dart';
import 'package:flutter_todo/models/app_tabs.dart';

void main() {
  TabsBloc tabsBloc;
  setUp(() {
    tabsBloc = TabsBloc();
  });

  tearDown(() {
    tabsBloc?.close();
  });

  group("TabsBloc", () {
    blocTest<TabsBloc, TabsEvent, TabsState>(
      'emits [TabsSelectedTabState(AppTab.completed)]'
      'when successful',
      build: () async {
        return tabsBloc;
      },
      act: (bloc) async =>
          tabsBloc.add(const TabsSelectTabEvent(AppTabs.completed)),
      expect: [
        const TabsSelectedTabState(AppTabs.completed),
      ],
    );
    blocTest<TabsBloc, TabsEvent, TabsState>(
      'emits [TabsSelectedTabState(AppTab.incomplete)]'
      'when successful',
      build: () async {
        return tabsBloc;
      },
      act: (bloc) async =>
          tabsBloc.add(const TabsSelectTabEvent(AppTabs.incomplete)),
      expect: [
        const TabsSelectedTabState(AppTabs.incomplete),
      ],
    );
  });
}
