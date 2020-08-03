import 'package:mobx/mobx.dart';

import 'models/hora.dart';

class Controller {
  var _counter = Observable(0);
  int get counter => _counter.value;
  set counter(int newValue) => _counter.value = newValue;

  var _lista = List<Hora>();
  List<Hora> get lista => _lista;
  set lista(List<Hora> newLista) => lista = newLista;

  Action increment;

  Controller() {
    increment = Action(_increment);

    autorun((_) {
      print('opa');
    });
  }

  _increment() {
    counter++;
    print(counter);
  }
}
