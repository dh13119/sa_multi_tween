
# 📝 Examples

Note: These examples uses **[supercharged](https://pub.dev/packages/supercharged)** package for syntactic sugar and **[simple_animations](https://pub.dev/packages/simple_animations)** 
for using `ControlledAnimation` widget.

## Simple use case

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
            tween: _tween,
            // Obtain duration from MultiTween
            duration: _tween.duration,
            builder: (context, animation) {
              return Container(
                // Get animated values for width and height
                width: animation.get(AniProps.width),
                height: animation.get(AniProps.height),
                color: animation.get(AniProps.color),
              );
            },
          ),
        ),
      ),
    );
  }
}

```