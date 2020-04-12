
Note: This example uses **[supercharged](https://pub.dev/packages/supercharged)** package for syntactic sugar and **[simple_animations](https://pub.dev/packages/simple_animations)** 
for using `ControlledAnimation` widget.

```dart
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import 'package:sa_multi_tween/sa_multi_tween.dart';

void main() => runApp(MyApp());

// Create enum that defines the animated properties
enum AniProps { width, height }

class MyApp extends StatelessWidget {
  // Specify your tween
  final _tween = MultiTween<AniProps>()
    ..add(AniProps.width, Tween(begin: 0.0, end: 100.0), 1000.milliseconds)
    ..add(AniProps.width, Tween(begin: 100.0, end: 200.0), 500.milliseconds)
    ..add(AniProps.height, Tween(begin: 0.0, end: 200.0), 2500.milliseconds);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ControlledAnimation<MultiTweenAnimatable<AniProps>>(
            tween: _tween,
            // Obtain duration from MultiTween
            duration: _tween.duration,
            playback: Playback.PLAY_FORWARD,
            builder: (context, animation) {
              return Container(
                // Get animated values for width and height
                width: animation.get<double>(AniProps.width),
                height: animation.get<double>(AniProps.height),
                color: Colors.yellow,
              );
            },
          ),
        ),
      ),
    );
  }
}


```