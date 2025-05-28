import 'package:flutter/foundation.dart';

class RunnerHelper {
  RunnerHelper._();

  void onZoneError(Object error, StackTrace stackTrace) {
    debugPrint('🔴');
    debugPrint(stackTrace.toString());
    debugPrint(error.toString());
  }
}

final runnerHelper = RunnerHelper._();
