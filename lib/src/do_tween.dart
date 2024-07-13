import './miticker.dart';
import './ease.dart';

List<DoTween> _tweens = [];

class DoTween {
  static EaseInstanceClass ease = EaseInstanceClass();
  ///////////////////////////////////////////////////////////////////////////
  ///
  /// DoTween static methods
  ///
  ///////////////////////////////////////////////////////////////////////////
  static List<DoTween> getAll() {
    return _tweens;
  }

  static void removeAll() {
    _tweens = [];
  }

  static void add(DoTween tween) {
    _tweens.add(tween);
  }

  static void remove(DoTween tween) {
    var i = _tweens.indexOf(tween);

    if (i != -1) {
      _tweens.removeAt(i);
    }
  }

  static bool _enableManualUpdate = false;
  static void enableManualUpdate() {
    _enableManualUpdate = true;
  }

  static void setup() {
    if (_enableManualUpdate) return;
    Miticker.init(DoTween._tickerHandler);
    Miticker.start();
  }

  static void close() {
    Miticker.stop();
  }

  static bool update([time]) {
    if (_tweens.isEmpty) return false;

    int i = 0, l = _tweens.length;
    time = time ?? DateTime.now().millisecondsSinceEpoch;

    while (i < l) {
      if (_tweens[i]._update(time)) {
        i++;
      } else {
        _tweens.removeAt(i);
        l--;
      }
    }

    return true;
  }

  static void _tickerHandler(Duration duration) {
    DoTween.update();
  }

  ///////////////////////////////////////////////////////////////////////////
  ///
  /// DoTween class
  ///
  ///////////////////////////////////////////////////////////////////////////
  Map<String, dynamic> _object = {};
  Map<String, dynamic> _valuesStart = {};
  Map<String, dynamic> _valuesEnd = {};

  int _duration = 0;
  int _delayTime = 0;
  int _startTime = 0;

  DoTween? _chainedTween;
  Function? _easingFunction;
  Function? _onUpdateCallback;
  Function? _onCompleteCallback;

  DoTween(Map<String, dynamic> object) {
    _object = object;
    _valuesStart = {};
    _valuesEnd = {};
    _duration = 1000;
    _delayTime = 0;
    _easingFunction = Ease.linear.none;
  }

  DoTween to(Map<String, dynamic> properties, [int duration = 1000]) {
    _duration = duration;
    _valuesEnd = properties;
    return this;
  }

  DoTween start([time]) {
    DoTween.setup();
    DoTween.add(this);

    _startTime = time ?? DateTime.now().millisecondsSinceEpoch;
    _startTime += _delayTime;

    for (var property in _valuesEnd.keys) {
      if (_object[property] == null) {
        continue;
      }

      _valuesStart[property] = _object[property];
    }

    return this;
  }

  DoTween stop() {
    DoTween.remove(this);
    return this;
  }

  DoTween delay(int amount) {
    _delayTime = amount;
    return this;
  }

  DoTween easing(easing) {
    _easingFunction = easing;
    return this;
  }

  DoTween chain(DoTween chainedTween) {
    _chainedTween = chainedTween;
    return this;
  }

  DoTween onUpdate(Function onUpdateCallback) {
    _onUpdateCallback = onUpdateCallback;
    return this;
  }

  DoTween onComplete(Function onCompleteCallback) {
    _onCompleteCallback = onCompleteCallback;
    return this;
  }

  bool _update(int time) {
    if (time < _startTime) {
      return true;
    }

    var elapsed = (time - _startTime) / _duration;
    elapsed = elapsed > 1 ? 1 : elapsed;

    var value = _easingFunction!(elapsed);

    for (var property in _valuesStart.keys) {
      var start = _valuesStart[property];
      var end = _valuesEnd[property];

      _object[property] = start + (end - start) * value;
    }

    if (_onUpdateCallback != null) {
      _onUpdateCallback!(_object);
    }

    if (elapsed == 1) {
      if (_onCompleteCallback != null) {
        _onCompleteCallback!(_object);
      }

      if (_chainedTween != null) {
        _chainedTween?.start();
      }

      return false;
    }

    return true;
  }
}
