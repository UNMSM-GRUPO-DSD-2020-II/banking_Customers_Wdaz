import 'package:flutter/material.dart';

class ContadorState extends ChangeNotifier {
  int _contador = 0;
  get contador => _contador;

  add() {
    this._contador++;
  }

  remove() {
    this._contador--;
  }
}
