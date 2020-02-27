import 'package:flutter_todo/database/database.dart';
import 'package:flutter_todo/sevices/naivigation.dart';
import 'package:flutter_todo/sevices/services.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<StorageDeviceService>(
      () => StorageDeviceService());
  locator.registerLazySingleton<DatabaseProvider>(() => DatabaseProvider());
  await locator<StorageDeviceService>().boot();
  await locator<DatabaseProvider>().boot();
}
