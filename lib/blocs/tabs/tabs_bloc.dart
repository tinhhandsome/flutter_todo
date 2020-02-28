import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_todo/models/models.dart';
import './bloc.dart';

class TabsBloc extends Bloc<TabsEvent, TabsState> {
  AppTabs _tab = AppTabs.all;

  AppTabs get tab => _tab;

  @override
  TabsState get initialState => TabsSelectedTabState(_tab);

  @override
  Stream<TabsState> mapEventToState(
    TabsEvent event,
  ) async* {
    if (event is TabsSelectTabEvent) {
      yield* _handleTabsSelectTabEvent(event);
      return;
    }
  }

  Stream<TabsState> _handleTabsSelectTabEvent(TabsSelectTabEvent event) async* {
    _tab = event.tab;
    yield TabsSelectedTabState(event.tab);
  }
}
