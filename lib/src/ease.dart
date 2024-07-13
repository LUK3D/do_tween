import 'dart:math';

abstract class BaseEasing {
  double none(double k);
  double easeOut(double k);
  double easeInOut(double k);
  double easeIn(double k);
}

class Linear extends BaseEasing {
  @override
  double none(double k) {
    return k;
  }

  @override
  double easeOut(double k) {
    return k;
  }

  @override
  double easeInOut(double k) {
    return k;
  }

  @override
  double easeIn(double k) {
    return k;
  }
}

class Quad extends BaseEasing {
  @override
  double none(double k) {
    return k;
  }

  @override
  double easeOut(double k) {
    return k * (2 - k);
  }

  @override
  double easeInOut(double k) {
    if ((k *= 2) < 1) return 0.5 * k * k;
    return -0.5 * (--k * (k - 2) - 1);
  }

  @override
  double easeIn(double k) {
    return k * k;
  }
}

class Cubic extends BaseEasing {
  @override
  double none(double k) {
    return k;
  }

  @override
  double easeOut(double k) {
    return --k * k * k + 1;
  }

  @override
  double easeInOut(double k) {
    if ((k *= 2) < 1) return 0.5 * k * k * k;
    return 0.5 * ((k -= 2) * k * k + 2);
  }

  @override
  double easeIn(double k) {
    return k * k * k;
  }
}

class Quart extends BaseEasing {
  @override
  double none(double k) {
    return k;
  }

  @override
  double easeIn(double k) {
    return k * k * k * k;
  }

  @override
  double easeOut(double k) {
    return 1 - --k * k * k * k;
  }

  @override
  double easeInOut(double k) {
    if ((k *= 2) < 1) return 0.5 * k * k * k * k;
    return -0.5 * ((k -= 2) * k * k * k - 2);
  }
}

class Quint extends BaseEasing {
  @override
  double none(double k) {
    return k;
  }

  @override
  double easeIn(double k) {
    return k * k * k * k * k;
  }

  @override
  double easeOut(double k) {
    return --k * k * k * k * k + 1;
  }

  @override
  double easeInOut(double k) {
    if ((k *= 2) < 1) return 0.5 * k * k * k * k * k;
    return 0.5 * ((k -= 2) * k * k * k * k + 2);
  }
}

class Sine extends BaseEasing {
  @override
  double none(double k) {
    return k;
  }

  @override
  double easeIn(double k) {
    return 1 - cos(k * pi / 2);
  }

  @override
  double easeOut(double k) {
    return sin(k * pi / 2);
  }

  @override
  double easeInOut(double k) {
    return 0.5 * (1 - cos(pi * k));
  }
}

class Expo extends BaseEasing {
  @override
  double none(double k) {
    return k;
  }

  @override
  double easeIn(double k) {
    return k == 0 ? 0.0 : pow(1024, k - 1).toDouble();
  }

  @override
  double easeOut(double k) {
    return k == 1 ? 1 : 1 - pow(2, -10 * k).toDouble();
  }

  @override
  double easeInOut(double k) {
    if (k == 0) return 0;
    if (k == 1) return 1;
    if ((k *= 2) < 1) return 0.5 * pow(1024, k - 1);
    return 0.5 * (-pow(2, -10 * (k - 1)) + 2);
  }
}

class Circ extends BaseEasing {
  @override
  double none(double k) {
    return k;
  }

  @override
  double easeIn(double k) {
    return 1 - sqrt(1 - k * k);
  }

  @override
  double easeOut(double k) {
    return sqrt(1 - --k * k);
  }

  @override
  double easeInOut(double k) {
    if ((k *= 2) < 1) return -0.5 * (sqrt(1 - k * k) - 1);
    return 0.5 * (sqrt(1 - (k -= 2) * k) + 1);
  }
}

class Elastic extends BaseEasing {
  @override
  double none(double k) {
    return k;
  }

  @override
  double easeIn(double k) {
    double s, a = 0.1, p = 0.4;
    if (k == 0) return 0;
    if (k == 1) return 1;
    if (a < 1) {
      a = 1;
      s = p / 4;
    } else {
      s = p * asin(1 / a) / (2 * pi);
    }
    return -(a * pow(2, 10 * (k -= 1)) * sin((k - s) * (2 * pi) / p));
  }

  @override
  double easeOut(double k) {
    double s, a = 0.1, p = 0.4;
    if (k == 0) return 0;
    if (k == 1) return 1;
    if (a < 1) {
      a = 1;
      s = p / 4;
    } else {
      s = p * asin(1 / a) / (2 * pi);
    }
    return (a * pow(2, -10 * k) * sin((k - s) * (2 * pi) / p) + 1);
  }

  @override
  double easeInOut(double k) {
    double s, a = 0.1, p = 0.4;
    if (k == 0) return 0;
    if (k == 1) return 1;
    if (a < 1) {
      a = 1;
      s = p / 4;
    } else {
      s = p * asin(1 / a) / (2 * pi);
    }
    if ((k *= 2) < 1) {
      return -0.5 * (a * pow(2, 10 * (k -= 1)) * sin((k - s) * (2 * pi) / p));
    }
    return a * pow(2, -10 * (k -= 1)) * sin((k - s) * (2 * pi) / p) * 0.5 + 1;
  }
}

class Back extends BaseEasing {
  @override
  double none(double k) {
    return k;
  }

  @override
  double easeIn(double k) {
    var s = 1.70158;
    return k * k * ((s + 1) * k - s);
  }

  @override
  double easeOut(double k) {
    var s = 1.70158;
    return --k * k * ((s + 1) * k + s) + 1;
  }

  @override
  double easeInOut(double k) {
    var s = 1.70158 * 1.525;
    if ((k *= 2) < 1) return 0.5 * (k * k * ((s + 1) * k - s));
    return 0.5 * ((k -= 2) * k * ((s + 1) * k + s) + 2);
  }
}

class Bounce extends BaseEasing {
  @override
  double none(double k) {
    return k;
  }

  @override
  double easeIn(double k) {
    return 1 - easeOut(1 - k);
  }

  @override
  double easeOut(double k) {
    if (k < (1 / 2.75)) {
      return 7.5625 * k * k;
    } else if (k < (2 / 2.75)) {
      return 7.5625 * (k -= (1.5 / 2.75)) * k + 0.75;
    } else if (k < (2.5 / 2.75)) {
      return 7.5625 * (k -= (2.25 / 2.75)) * k + 0.9375;
    } else {
      return 7.5625 * (k -= (2.625 / 2.75)) * k + 0.984375;
    }
  }

  @override
  double easeInOut(double k) {
    if (k < 0.5) return easeIn(k * 2) * 0.5;
    return easeOut(k * 2 - 1) * 0.5 + 0.5;
  }
}

class Ease {
  static BaseEasing linear = Linear();
  static BaseEasing quad = Quad();
  static BaseEasing cubic = Cubic();
  static BaseEasing quart = Quart();
  static BaseEasing quint = Quint();
  static BaseEasing sine = Sine();
  static BaseEasing expo = Expo();
  static BaseEasing circ = Circ();
  static BaseEasing elastic = Elastic();
  static BaseEasing back = Back();
  static BaseEasing bounce = Bounce();
}

class EaseInstanceClass {
  BaseEasing linear = Linear();
  BaseEasing quad = Quad();
  BaseEasing cubic = Cubic();
  BaseEasing quart = Quart();
  BaseEasing quint = Quint();
  BaseEasing sine = Sine();
  BaseEasing expo = Expo();
  BaseEasing circ = Circ();
  BaseEasing elastic = Elastic();
  BaseEasing back = Back();
  BaseEasing bounce = Bounce();
}
