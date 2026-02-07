import 'dart:async';

import 'package:flutter/material.dart';

class TimerViewModel extends ChangeNotifier {
  bool isPlaying = false;
  Timer? timer;
  Duration duration = Duration.zero;

  void startTimer(int initialMinutes, ValueNotifier<bool> isPausedNotifier) {
    duration = Duration.zero;
    isPlaying = true;
    notifyListeners();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (isPausedNotifier.value) return;

      if (duration.inMinutes < initialMinutes) {
        duration += Duration(seconds: 1);
        notifyListeners();
      } else {
        stopTimer();
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
    isPlaying = false;
    notifyListeners();
  }

}