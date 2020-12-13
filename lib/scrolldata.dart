import 'package:flutter/cupertino.dart';

class ScrollData extends ChangeNotifier {
  double _scroll = 0;

  void increme(double dat) {
    print(_scroll);
    if (_scroll + (dat / 2) >= 0) _scroll += (dat / 2);
    notifyListeners();
  }

  double get sc {
    return _scroll;
  }
}
