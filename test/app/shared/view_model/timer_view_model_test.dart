import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fokus/app/view_model/timer_view_model.dart';

void main() {
  group('TimerViewModel', () {
    late TimerViewModel vm;
    late ValueNotifier<bool> isPaused;

    setUp(() {
      vm       = TimerViewModel();
      isPaused = ValueNotifier<bool>(false);
    });
    test('Inicia parado com duração zero', () {
      expect(vm.isPlaying, isFalse);
      expect(vm.duration, Duration.zero);
    });

    group('startTimer', () {
      test('Liga o temporizador e zera a duração', () {
        vm.duration = Duration(minutes: 10);
        vm.startTimer(5, isPaused);

        expect(vm.isPlaying, isTrue);
        expect(vm.duration, Duration.zero);
      });

      test('Incrementa a cada segundo quando nao está pausado', () async {
        vm.startTimer(5, isPaused);
        await Future.delayed(Duration(seconds: 1));
        expect(vm.duration.inSeconds, 1);
      });

      test('Não incrementa o valor quando está pausado', () async {
        isPaused.value = true;
        vm.startTimer(5, isPaused);
        await Future.delayed(Duration(seconds: 1));
        expect(vm.duration.inSeconds, 0);

        isPaused.value = false;
        await Future.delayed(Duration(seconds: 1));
        expect(vm.duration.inSeconds, 1);
      });
    });

    group('stopTime', () {
      test('Desliga o temporizado', () {
        vm.startTimer(1, isPaused);
        vm.stopTimer();
        expect(vm.isPlaying, isFalse);
      });
    });
  });
}