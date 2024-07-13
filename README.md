# DoTween

Bring your Flutter apps to life with DOTween! This fast, efficient animation library simplifies coding and makes animating anything a breeze.

It is based on [tweener](https://github.dev/flutterkit/tweener) and the base code remains the same.

The goal of DoTween is to provide some extra functions and properties that tweener doesn't offer.

## Features

* Does one thing and one thing only: tween properties
* Very simple to use, but it can achieve a lot of effects
* Easing functions are reusable outside of Tween

## Installation

> Install the [DoTween](https://pub.dev/packages/dotween) pacakge:

#### You should ensure that you add the following dependency in your Flutter project.
```
dependencies:
  dotween: ^1.0.0
```

#### install packages from the command line:
```
flutter packages get
```

## Useage

#### import class
```
import 'package:dotween/do_tween.dart';
```

#### use DoTween
```
DoTween({"x": 0, "y": 0, "alpha": 0, "custom_prop_abc": 123})
    .to({"x": 100, "y": 500, "alpha": 1, "custom_prop_abc": 321}, 2000)
    .easing(DoTween.ease.elastic.easeOut)
    .onUpdate((obj) {
        setState(() {
            _x = obj["x"];
            _y = obj["y"];
            _alpha = obj["alpha"];
            _abc = obj["custom_prop_abc"];
        });
    })
    .onComplete((obj){
        /// 
    })
    .start();
```

```
var tween1 = new DoTween(sprite)
	.to({x: 700, y: 200, rotation: 359}, 2000)
	.delay(1000)
	.easing(Ease.back.easeOut)
	.onUpdate(update);

var tween2 = new DoTween(sprite)
	.to({x: 10, y: 20, rotation: 30}, 2000)
	.onUpdate(update);

tween1.chain(tween2);
tween1.start();
```

## Thanks

DoTween takes most of it's base implementation from [tweener](https://github.dev/flutterkit/tweener). The base implementation was realy awesome, so the package and it's author deservs all the best.
