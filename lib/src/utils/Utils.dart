import 'dart:math';
import 'package:flutter/material.dart';

class Utils {
  Color getColor() {
    switch (getRandom()) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.orange;
        break;
      case 3:
        return Colors.yellow;
        break;
      case 4:
        return Colors.green;
        break;
      default:
        return Colors.green;
    }
  }

  int getRandom() {
    var max = 10;
    var min = 1;
    Random rnd = new Random();
    return min + rnd.nextInt(max - min);
  }
}
