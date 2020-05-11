import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sa_multi_tween/sa_multi_tween.dart';
import 'package:supercharged/supercharged.dart';

void main() {
  test('single track / one tween', () {
    final mt = MultiTween<_Props>()
      ..add(_Props.width, Tween<double>(begin: 0.0, end: 1.0), Duration(seconds: 1));

    expect(mt.duration, 1.seconds);

    expect(mt.transform(0.0).get<double>(_Props.width), 0.0);
    expect(mt.transform(0.5).get<double>(_Props.width), 0.5);
    expect(mt.transform(1.0).get<double>(_Props.width), 1.0);
  });

  test('single track / two tweens with same length', () {
    final mt = MultiTween<_Props>()
      ..add(_Props.width, Tween<double>(begin: 0.0, end: 1.0), Duration(seconds: 1))
      ..add(
          _Props.width, Tween<double>(begin: 100.0, end: 200.0), Duration(seconds: 1));

    expect(mt.duration, 2.seconds);

    expect(mt.transform(0.0).get<double>(_Props.width), 0.0);
    expect(mt.transform(0.25).get<double>(_Props.width), 0.5);
    expect(mt.transform(0.5).get<double>(_Props.width), 100.0);
    expect(mt.transform(0.75).get<double>(_Props.width), 150.0);
    expect(mt.transform(1.0).get<double>(_Props.width), 200.0);
  });

  test('single track / two tweens with different lengths', () {
    final mt = MultiTween<_Props>()
      ..add(_Props.width, Tween<double>(begin: 0.0, end: 1.0), Duration(seconds: 1))
      ..add(
          _Props.width, Tween<double>(begin: 100.0, end: 400.0), Duration(seconds: 3));

    expect(mt.duration, 4.seconds);

    expect(mt.transform(0.0).get<double>(_Props.width), 0.0);
    expect(mt.transform(0.125).get<double>(_Props.width), 0.5);
    expect(mt.transform(0.25).get<double>(_Props.width), 100.0);
    expect(mt.transform(0.5).get<double>(_Props.width), 200.0);
    expect(mt.transform(0.75).get<double>(_Props.width), 300.0);
    expect(mt.transform(1.0).get<double>(_Props.width), 400.0);
  });

  test('multiple tracks', () {
    final mt = MultiTween<_Props>()
      ..add(_Props.width, Tween<double>(begin: 0.0, end: 1.0), Duration(seconds: 1))
      ..add(_Props.width, Tween<double>(begin: 100.0, end: 200.0), Duration(seconds: 1))
      ..add(_Props.height, Tween<double>(begin: 0.0, end: 1000.0), Duration(seconds: 1));

    expect(mt.duration, 2.seconds);

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
    final mt = MultiTween<_Props>();

    expect(() => mt.transform(0.0).get<double>(_Props.width),
        throwsAssertionError);
  });

  test('single track / no explicit duration', () {
    final mt = MultiTween<_Props>()
      ..add(_Props.width, Tween<double>(begin: 0.0, end: 1.0));

    expect(mt.duration, 1.seconds);

    expect(mt.transform(0.0).get<double>(_Props.width), 0.0);
    expect(mt.transform(0.5).get<double>(_Props.width), 0.5);
    expect(mt.transform(1.0).get<double>(_Props.width), 1.0);
  });

  test('single track / no item', () {
    final mt = MultiTween<_Props>();

    expect(mt.duration, 0.seconds);
  });

  test('single track / with curve', () {
    final mt = MultiTween<_Props>()
      ..add(_Props.width, Tween<double>(begin: 0.0, end: 1.0), 1.seconds, Curves.easeIn);

    expect(mt.duration, 1.seconds);

    expect(mt.transform(0.0).get<double>(_Props.width), 0.0);
    expect(mt.transform(0.25).get<double>(_Props.width), 0.09407757222652435);
    expect(mt.transform(0.5).get<double>(_Props.width), 0.31640625);
    expect(mt.transform(0.75).get<double>(_Props.width), 0.6219428777694702);
    expect(mt.transform(1.0).get<double>(_Props.width), 1.0);
  });
}

enum _Props { width, height }
