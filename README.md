*This project is part of the [Simple Animations Framework](https://pub.dev/packages/simple_animations)*

# ⦷ MultiTween

MultiTween is a **powerful** `Animateable` that animates multiple properties at once.

## 🌞 Highlights

- **Animate multiple properties** (for example width, height and color) at once inside a single animation.

- **Chain multiple tweens** to create complex animations.

## ⛏ Usage

🛈 *The following code snippets use
[**supercharged**](https://pub.dev/packages/supercharged)
package for syntactic sugar and widgets from
[**simple_animations**](https://pub.dev/packages/simple_animations)
.*

### Getting started

Add MultiTween to your project by following the instructions on the 
**[install page](https://pub.dev/packages/sa_multi_tween#-installing-tab-)**.

To learn how to use MultiTween:

- Continue reading this page
- Study complete examples at
[**example page**](https://pub.dev/packages/sa_multi_tween#-example-tab-)
- Discover the
[**API documentation**](https://pub.dev/documentation/sa_multi_tween/latest/sa_multi_tween/sa_multi_tween-library.html)

### Basic usage pattern

Create an `enum` outside your widget class. It contains all properties you want to animate. *(For example: width, height or color)*
```dart
enum AniProps { width, height }
```

Then you create a `MultiTween` by instancing it with the `enum` you created in the first step.
Invoke the `add` method to arrange your animation.

```dart
final _tween = MultiTween<AniProps>()
  ..add(AniProps.width, 0.0.tweenTo(100.0), 1000.milliseconds)
  ..add(AniProps.width, 100.0.tweenTo(200.0), 500.milliseconds)
  ..add(AniProps.height, 0.0.tweenTo(200.0), 2500.milliseconds)
```

Pass the created `_tween` to your favorite animation builder framework. Here we use the `ControlledAnimation` widget from *[simple_animations](https://pub.dev/packages/simple_animations)*. 

```dart
ControlledAnimation<MultiTweenValues<AniProps>>(
  tween: _tween, // Pass in tween
  duration: _tween.duration, // Pass in total duration obtained from MultiTween
  builder: (context, animation) {
    return Container(
      width: animation.get(AniProps.width), // Get animated width value
      height: animation.get(AniProps.height), // Get animated height value
      color: Colors.yellow,
    );
  },
),
```

### Using the predefined enum for animation properties

It's always good to create your own `enum` that contain the precise animation properties the animation uses.
But we developers are sometimes lazy. 

If you feel lazy can also use the [`DefaultAnimationProperties`](https://github.com/felixblaschke/sa_multi_tween/blob/master/lib/multi_tween/default_animation_properties.dart) enum that contains a varity of common used animation properties.

```dart
final _tween = MultiTween<DefaultAnimationProperties>()
  ..add(DefaultAnimationProperties.width, 0.0.tweenTo(100.0), 1000.milliseconds)
```

### Some notes on using durations

#### Duration tracking

The `MultiTween` tracks the duration for each property you specified when arranging your tween. In the examples above we used this "tracked duration" (`_tween.duration`) to define the total animation duration.

#### Use own durations

You also also use your own `Duration`. MultiTween will automatically lengthen or shorten the tween animation.

```dart
ControlledAnimation<MultiTweenValues<AniProps>>(
  tween: _tween,
  duration: Durations(seconds: 3), // Use own duration
  builder: (context, animation) {
    return Container(
      width: animation.get(AniProps.width),
      height: animation.get(AniProps.height),
      color: Colors.yellow,
    );
  },
),
```

#### Default duration when adding tweens to MultiTween

Supplying a duration when calling `add` method is optional as well. It will use `Duration(seconds: 1)` as the default value.

```dart
final _tween = MultiTween<DefaultAnimationProperties>()
  ..add(DefaultAnimationProperties.width, 0.0.tweenTo(100.0)); // no duration supplied

_tween.duration; // Duration(seconds: 1)
```

#### Inhomogeneous durations

If properties have different durations `MultiTween` will extrapolate the last value for each property.

```dart
final tween = MultiTween<DefaultAnimationProperties>()
  ..add(DefaultAnimationProperties.width, 0.0.tweenTo(100.0), 1.seconds) // width takes 1 second
  ..add(DefaultAnimationProperties.height, 0.0.tweenTo(1000.0), 2.seconds); // height takes 2 seconds
```
After a second the `width` reaches it's target value of `100.0`. Meanwhile the `height` property is halfway at `500.0`. From now on `width` will stay at `100.0` untils `height` reaches it's target value of `1000.0`. The whole tween is completed after 2 seconds.

### Non-linear animations

You can make your animation more interesting by adding non-linear tweens.
When adding your tweens you can use the (optional) fourth parameter to specify a `Curve`.

🛈 *Flutter offers predefined curves inside the `Curves` class.*

```dart
final tween = MultiTween<DefaultAnimationProperties>()
  ..add(DefaultAnimationProperties.width, 0.0.tweenTo(100.0), 1000.milliseconds, Curves.easeOut);
```