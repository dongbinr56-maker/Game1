import 'dart:math';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

import 'cafe_state.dart';

class CafeSim {
  final CafeState state;

  /// Placeholder metrics for required 1s logs.
  /// Replace with real calculations as systems land.
  int queueLen = 0;
  int brewBacklog = 0;
  int cashierBacklog = 0;
  double coinsPerMin = 0;
  String bottleneck = 'none';

  CafeSim({required this.state});

  void tick1s() {
    state.coins.value += 1;

    // Update placeholder metrics (replace with real values later).
    queueLen = max(queueLen - 1, 0);
    coinsPerMin = state.coins.value.toDouble() * 60;
    bottleneck = 'placeholder';

    _logTick();
  }

  void _logTick() {
    final message = {
      'queueLen': queueLen,
      'brewBacklog': brewBacklog,
      'cashierBacklog': cashierBacklog,
      'coinsPerMin': coinsPerMin,
      'bottleneck': bottleneck,
    }.toString();

    developer.log(message, name: 'CafeSim.tick1s');
    if (kDebugMode) {
      debugPrint('CafeSim.tick1s $message');
    }
  }
}
