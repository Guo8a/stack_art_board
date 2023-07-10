import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/safe_value_notifier.dart';

part 'scale_service.g.dart';

@riverpod
SafeValueNotifier<ScaleStartDetails> scaleStart(ScaleStartRef ref) {
  return SafeValueNotifier(ScaleStartDetails());
}

@riverpod
SafeValueNotifier<ScaleUpdateDetails> scaleUpdate(ScaleUpdateRef ref) {
  return SafeValueNotifier(ScaleUpdateDetails());
}
