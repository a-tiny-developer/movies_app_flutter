import 'dart:async';

import 'package:flutter/cupertino.dart';

class Debouncer {
  Debouncer({
    required this.duration,
  });

  final Duration duration;
  Timer? _timer;

  void start(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(duration, () {
      callback();
    });
  }
}
