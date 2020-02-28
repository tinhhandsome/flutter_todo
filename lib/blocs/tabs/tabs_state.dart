import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_todo/models/models.dart';

@immutable
abstract class TabsState extends Equatable {
  const TabsState();

  @override
  List<Object> get props => [];
}

class TabsSelectedTabState extends TabsState {
  final AppTabs tab;

  const TabsSelectedTabState(this.tab);

  @override
  String toString() => "TabsSelectTabState {tab: $tab}";

  @override
  List<Object> get props => [tab];
}
