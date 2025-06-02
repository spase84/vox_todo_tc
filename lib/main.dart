// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:easy_logger/easy_logger.dart' show LevelMessages;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vox_todo/app.dart' show App;
import 'package:vox_todo/app/core/runner_helper.dart' show runnerHelper;
import 'package:vox_todo/app/di/injector.dart' show Injector;

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    EasyLocalization.logger.enableLevels = [
      LevelMessages.error,
    ];
    await Injector.setup();
    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('ru', 'RU')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ru', 'RU'),
        startLocale: const Locale('ru', 'RU'),
        child: const App(),
      ),
    );
  }, (error, stack) {
    runnerHelper.onZoneError(error, stack);
  });
}
