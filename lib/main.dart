import 'dart:async';

import 'package:easy_localization/easy_localization.dart' show EasyLocalization;
import 'package:flutter/material.dart';
import 'package:vox_todo/app/core/runner_helper.dart';
import 'package:vox_todo/app/di/injector.dart' show Injector;

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await Injector.setup();
    runApp(const MainApp());
  }, (error, stack) {
    runnerHelper.onZoneError(error, stack);
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
