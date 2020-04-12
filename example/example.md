
> Note: This example uses **[supercharged](https://pub.dev/packages/supercharged)** package for syntactic sugar and **[simple_animations](https://pub.dev/packages/simple_animations)** 
> for using `ControlledAnimation` widget.

```dart
// Define properties as enum
enum AniProps { width, height }

// Specify MultiTween
final _tween = MultiTween<AniProps>()
  ..add(AniProps.width, Tween(begin: 0.0, end: 100.0), 1000.milliseconds)
  ..add(AniProps.width, Tween(begin: 100.0, end: 200.0), 500.milliseconds)
  ..add(AniProps.height, Tween(begin: 0.0, end: 200.0), 2500.milliseconds);
```

Use the created `_tween` in your `builder()` function:
```dart
ControlledAnimation<MultiTweenAnimatable<AniProps>>(
  tween: _tween,
  // Obtain total duration from MultiTween
  duration: _tween.duration,
  builder: (context, animation) {
    return Container(
      // Get animated width as double value
      width: animation.get<double>(AniProps.width),
      // Get animated height as double value
      height: animation.get<double>(AniProps.height),
      color: Colors.yellow,
    );
  },
),
```