import 'dart:async';

class DownloadService {
  Stream<double> fakeDownloadProgress() async* {
    for (var i = 0; i <= 100; i += 10) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      yield i / 100;
    }
  }
}
