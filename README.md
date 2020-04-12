*This project is part of the [Simple Animations Framework](https://pub.dev/packages/simple_animations)*

> ⚠ Note: This project is still in development. Don't use it in production for now.

# MultiTween 

MultiTween is a **powerful** `Animateable` that animates multiple properties at once. Typical use cases are

- Staggered animations by **combining multiple** tweens
- Multiple properties (i.e. color and width) are animated **simultaneously**



## 📝 Example

> Note: This example uses **[supercharged](https://pub.dev/packages/supercharged)** package for syntactic sugar and **[simple_animations](https://pub.dev/packages/simple_animations)** 
> for using `ControlledAnimation` widget.

```dart
// Define properties as enum
enum AniProps { width, height }

// Specify MultiTween
final _tween = MultiTween<AniProps>()
  ..add(AniProps.width, 0.0.tweenTo(100.0), 1000.milliseconds)
  ..add(AniProps.width, 100.0.tweenTo(200.0), 500.milliseconds)
  ..add(AniProps.height, 0.0.tweenTo(200.0), 2500.milliseconds)
```

Use the created `_tween` in your `builder()` function:
```dart
ControlledAnimation<MultiTweenAnimatable<AniProps>>(
  tween: _tween,
  // Obtain total duration from MultiTween
  duration: _tween.duration,
  builder: (context, animation) {
    return Container(
      // Get animated width value
      width: animation.get(AniProps.width),
      // Get animated height value
      height: animation.get(AniProps.height),
      color: Colors.yellow,
    );
  },
),
```

### Use the predefined enum for animation properties

You can also use the [`DefaultAnimationProperties`](https://github.com/felixblaschke/sa_multi_tween/blob/master/lib/multi_tween/default_animation_properties.dart) enum that contains a varity of common used animation properties.

> Example:
```dart
final _tween = MultiTween<DefaultAnimationProperties>()
  ..add(DefaultAnimationProperties.width, 0.0.tweenTo(100.0), 1000.milliseconds)
```

### Use own durations

You can simply ignore the `_tween.duration` property and use your own `Duration`. *MultiTween will automatically lengthen or shorten the tween animation.*

> Example:
```dart
ControlledAnimation<MultiTweenAnimatable<AniProps>>(
  tween: _tween,
  // Use own duration
  duration: Durations(seconds: 3),
  builder: (context, animation) {
    return Container(
      width: animation.get(AniProps.width),
      height: animation.get(AniProps.height),
      color: Colors.yellow,
    );
  },
),
```