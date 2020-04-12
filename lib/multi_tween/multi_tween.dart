import 'package:flutter/widgets.dart';
import 'package:supercharged/supercharged.dart';

class MultiTween<P> extends Animatable<MultiTweenAnimatable<P>> {
  final _tracks = Map<P, _TweenTrack>();

  get duration => _tracks.values
      .map((track) => track.duration)
      .maxBy((a, b) => a.compareTo(b));

  void add(P property, Tween tween,
      [Duration duration = const Duration(seconds: 1)]) {
    if (!_tracks.containsKey(property)) {
      _tracks[property] = _TweenTrack();
    }

    _tracks[property].add(tween, duration);
  }

  @override
  transform(double t) => MultiTweenAnimatable<P>(this.duration, _tracks, t);
}

class MultiTweenAnimatable<P> {
  final Duration _maxDuration;
  final Map<P, _TweenTrack> _tracks;
  final double time;

  MultiTweenAnimatable(this._maxDuration, this._tracks, this.time);

  T get<T>(P property) {
    assert(_tracks.containsKey(property),
        "Property '${property.toString()}' does not exists.");

    var timeWhenTweenStarts = 0.0;
    final track = _tracks[property];

    for (var tweenWithDuration in track.tweensWithDuration) {
      final tweenDurationInTimeDecimals =
          _divideDurations(tweenWithDuration.duration, _maxDuration);

      // We need to figure out which tween-slice of track applied to the requested time (t)
      if (time < timeWhenTweenStarts + tweenDurationInTimeDecimals) {
        final normalizedTime =
            (time - timeWhenTweenStarts) / tweenDurationInTimeDecimals;
        return tweenWithDuration.tween.transform(normalizedTime);
      }
      timeWhenTweenStarts += tweenDurationInTimeDecimals;
    }

    // the for-loop above doesn't catches t=1.0, that's why we handle this case manually
    return track.tweensWithDuration.last.tween.transform(1.0);
  }
}

class _TweenTrack {
  final tweensWithDuration = List<_TweenWithDuration>();

  void add(Tween tween, Duration duration) {
    tweensWithDuration.add(_TweenWithDuration(tween, duration));
  }

  get duration => tweensWithDuration
      .map((it) => it.duration)
      .reduce((value, it) => value + it);
}

class _TweenWithDuration {
  final Tween tween;
  final Duration duration;

  _TweenWithDuration(this.tween, this.duration);
}

// TODO maybe supercharged function
_divideDurations(Duration a, Duration b) =>
    a.inMicroseconds.toDouble() / b.inMicroseconds.toDouble();
