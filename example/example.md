
# 📝 Examples

Note: These examples uses **[supercharged](https://pub.dev/packages/supercharged)** package for syntactic sugar and **[simple_animations](https://pub.dev/packages/simple_animations)** 
for using `ControlledAnimation` widget.

## Animate multiple properties

This example animates width, height and color of a box.

```dart
import 'package:flutter/material.dart';
import 'package:sa_multi_tween/sa_multi_tween.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

void main() => runApp(MyApp());

// Create enum that defines the animated properties
enum AniProps { width, height, color }

class MyApp extends StatelessWidget {
  
  // Specify your tween
  final _tween = MultiTween<AniProps>()
    ..add(AniProps.width, 0.0.tweenTo(100.0), 1000.milliseconds)
    ..add(AniProps.width, 100.0.tweenTo(200.0), 500.milliseconds)
    ..add(AniProps.height, 0.0.tweenTo(200.0), 2500.milliseconds)
    ..add(AniProps.color, Colors.red.tweenTo(Colors.blue), 3.seconds);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ControlledAnimation<MultiTweenValues<AniProps>>(
            tween: _tween, // Pass in tween
            duration: _tween.duration, // Obtain duration from MultiTween
            builder: (context, animation) {
              return Container(
                width: animation.get(AniProps.width), // Get animated value for width
                height: animation.get(AniProps.height), // Get animated value for height
                color: animation.get(AniProps.color), // Get animated value for color
              );
            },
          ),
        ),
      ),
    );
  }
}

```

## Chained tweens in single animation

This example moves a box clockwise in a rectangular pattern.

```dart
import 'package:flutter/material.dart';
import 'package:sa_multi_tween/sa_multi_tween.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

void main() => runApp(MyApp());

// Create enum that defines the animated properties
enum AniProps { offset }

class MyApp extends StatelessWidget {
  // Specify your tween
  final _tween = MultiTween<AniProps>()
    ..add( // top left => top right
        AniProps.offset,
        Tween(begin: Offset(-100, -100), end: Offset(100, -100)),
        1000.milliseconds)
    ..add( // top right => bottom right
        AniProps.offset,
        Tween(begin: Offset(100, -100), end: Offset(100, 100)),
        1000.milliseconds)
    ..add( // bottom right => bottom left
        AniProps.offset,
        Tween(begin: Offset(100, 100), end: Offset(-100, 100)),
        1000.milliseconds)
    ..add( // bottom left => top left
        AniProps.offset,
        Tween(begin: Offset(-100, 100), end: Offset(-100, -100)),
        1000.milliseconds);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ControlledAnimation<MultiTweenValues<AniProps>>(
            tween: _tween, // Pass in tween
            duration: _tween.duration, // Obtain duration from MultiTween
            playback: Playback.LOOP,
            builder: (context, animation) {
              return Transform.translate(
                offset: animation.get(AniProps.offset), // Get animated offset
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

```

## Complex example

This example combines aspects of the examples above, including chaining and multiple properties.

```dart
import 'package:flutter/material.dart';
import 'package:sa_multi_tween/sa_multi_tween.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

void main() => runApp(MyApp());

// Create enum that defines the animated properties
enum AniProps { offset, color }

class MyApp extends StatelessWidget {
  // Specify your tween
  final _tween = MultiTween<AniProps>()
    ..add(
        // top left => top right
        AniProps.offset,
        Tween(begin: Offset(-100, -100), end: Offset(100, -100)),
        1000.milliseconds, Curves.easeInOutSine)
    ..add(
        // top right => bottom right
        AniProps.offset,
        Tween(begin: Offset(100, -100), end: Offset(100, 100)),
        1000.milliseconds, Curves.easeInOutSine)
    ..add(
        // bottom right => bottom left
        AniProps.offset,
        Tween(begin: Offset(100, 100), end: Offset(-100, 100)),
        1000.milliseconds, Curves.easeInOutSine)
    ..add(
        // bottom left => top left
        AniProps.offset,
        Tween(begin: Offset(-100, 100), end: Offset(-100, -100)),
        1000.milliseconds, Curves.easeInOutSine)
    ..add(AniProps.color, Colors.red.tweenTo(Colors.yellow), 1.seconds)
    ..add(AniProps.color, Colors.yellow.tweenTo(Colors.blue), 2.seconds)
    ..add(AniProps.color, Colors.blue.tweenTo(Colors.red), 1.seconds);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ControlledAnimation<MultiTweenValues<AniProps>>(
            tween: _tween, // Pass in tween
            duration: _tween.duration, // Obtain duration from MultiTween
            playback: Playback.LOOP,
            builder: (context, animation) {
              return Transform.translate(
                offset: animation.get(AniProps.offset), // Get animated offset
                child: Container(
                  width: 100,
                  height: 100,
                  color: animation.get(AniProps.color), // Get animated color
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

```