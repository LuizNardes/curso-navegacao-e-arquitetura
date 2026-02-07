import 'dart:async';

import 'package:flutter/material.dart';

class TimerViewModel extends ChangeNotifier {
  bool isRunning = false;
  Timer? timer;
  Duration duration = Duration.zero;

  void startTimer(int initialMinutes) {
    duration = Duration.zero;
    isRunning = true;
    notifyListeners();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
    isRunning = false;
    notifyListeners();
  }

}