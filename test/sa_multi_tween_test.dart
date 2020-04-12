import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sa_multi_tween/sa_multi_tween.dart';

void main() {
  test('single track / one tween', () {
    final mt = MultiTween()
      ..add(_Props.width, Tween(begin: 0.0, end: 1.0), Duration(seconds: 1));

    expect(mt.transform(0.0).get<double>(_Props.width), 0.0);
    expect(mt.transform(0.5).get<double>(_Props.width), 0.5);
    expect(mt.transform(1.0).get<double>(_Props.width), 1.0);
  });

  test('single track / two tweens with same length', () {
    final mt = MultiTween()
      ..add(_Props.width, Tween(begin: 0.0, end: 1.0), Duration(seconds: 1))
      ..add(
          _Props.width, Tween(begin: 100.0, end: 200.0), Duration(seconds: 1));

    expect(mt.transform(0.0).get<double>(_Props.width), 0.0);
    expect(mt.transform(0.25).get<double>(_Props.width), 0.5);
    expect(mt.transform(0.5).get<double>(_Props.width), 100.0);
    expect(mt.transform(0.75).get<double>(_Props.width), 150.0);
    expect(mt.transform(1.0).get<double>(_Props.width), 200.0);
  });

  test('single track / two tweens with different lengths', () {
    final mt = MultiTween()
      ..add(_Props.width, Tween(begin: 0.0, end: 1.0), Duration(seconds: 1))
      ..add(
          _Props.width, Tween(begin: 100.0, end: 400.0), Duration(seconds: 3));

    expect(mt.transform(0.0).get<double>(_Props.width), 0.0);
    expect(mt.transform(0.125).get<double>(_Props.width), 0.5);
    expect(mt.transform(0.25).get<double>(_Props.width), 100.0);
    expect(mt.transform(0.5).get<double>(_Props.width), 200.0);
    expect(mt.transform(0.75).get<double>(_Props.width), 300.0);
    expect(mt.transform(1.0).get<double>(_Props.width), 400.0);
  });

  test('multiple tracks', () {
    final mt = MultiTween()
      ..add(_Props.width, Tween(begin: 0.0, end: 1.0), Duration(seconds: 1))
      ..add(_Props.width, Tween(begin: 100.0, end: 200.0), Duration(seconds: 1))
      ..add(_Props.height, Tween(begin: 0.0, end: 1000.0), Duration(seconds: 1));

    expect(mt.transform(0.0).get<double>(_Props.width), 0.0);
    expect(mt.transform(0.25).get<double>(_Props.width), 0.5);
    expect(mt.transform(0.5).get<double>(_Props.width), 100.0);
    expect(mt.transform(0.75).get<double>(_Props.width), 150.0);
    expect(mt.transform(1.0).get<double>(_Props.width), 200.0);

    expect(mt.transform(0.0).get<double>(_Props.height), 0.0);
    expect(mt.transform(0.25).get<double>(_Props.height), 500.0);
    expect(mt.transform(0.5).get<double>(_Props.height), 1000.0);
    expect(mt.transform(0.75).get<double>(_Props.height), 1000.0);
    expect(mt.transform(1.0).get<double>(_Props.height), 1000.0);

  });

  test('access non-existing property', () {
    final mt = MultiTween();

    expect(() => mt.transform(0.0).get<double>(_Props.width),
        throwsAssertionError);
  });
}

enum _Props { width, height }
