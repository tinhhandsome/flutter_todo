import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/services/services.dart';
import 'package:flutter_todo/todo.dart';

import 'blocs/blocs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = AppBlocDelegate(debug: true);
  await setupLocator();

  runApp(
    DevicePreview(
      builder: (context) => TodoApp(),
    ),
  );
}
