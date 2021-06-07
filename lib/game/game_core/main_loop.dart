import 'dart:isolate';

bool _running = true;

void mainLoop(SendPort sendPort) async {
  final double _fps = 50;
  final double _second = 1000;
  final double _frameTime = _second / _fps;

  Stopwatch _frameTimeWatch = Stopwatch();
  _frameTimeWatch.start();
  Stopwatch _fpsWatch = Stopwatch();
  _fpsWatch.start();

  int _counter = 0;

  while (_running) {
    if (_frameTimeWatch.elapsedMilliseconds >= _frameTime) {
      _counter++;
      sendPort.send(true);
      _frameTimeWatch.reset();
    }

    if (_fpsWatch.elapsedMilliseconds >= _second) {
      print('FPS: $_counter');
      _counter = 0;
      _fpsWatch.reset();
    }
  }
}

void stopLoop() {
  _running = false;
}
