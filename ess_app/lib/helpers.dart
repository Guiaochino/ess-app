
import 'dart:math';
import 'package:flutter/cupertino.dart';

/**
 * Helper Functions for used generally in the screens
 */



String generateUID() {
  final random = Random.secure();
  final digits = List.generate(4, (_) => random.nextInt(9) + 1);
  digits.insert(0, random.nextInt(9) + 1);
  return digits.join('');
}

// String generateUID() {
//     return UniqueKey().toString();
//   }