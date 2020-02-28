import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_todo/models/models.dart';

@immutable
abstract class TabsEvent extends Equatable {
  const TabsEvent();
  @override
  List<Object> get props => [];
}

class TabsSelectTabEvent extends TabsEvent {
  final AppTabs tab;

  const TabsSelectTabEvent(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => "SelectTabsEvent {tab: $tab}";
}
