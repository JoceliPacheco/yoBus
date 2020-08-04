import 'package:mobx/mobx.dart';

import 'models/hora.dart';

class Controller {
  var _counter = Observable(0);
  int get counter => _counter.value;
  set counter(int newValue) => _counter.value = newValue;

  var _lista = List<Hora>();
  List<Hora> get lista => _lista;
  set lista(List<Hora> newLista) => lista = newLista;

  var _lista2 = List<Hora>();
  List<Hora> get lista2 => _lista2;
  set lista2(List<Hora> newLista) => lista2 = newLista;

  var _linha = Observable('');
  String get linha => _linha.value;
  set linha(String newValue) => _linha.value = newValue;

  var _sentido = Observable('');
  String get sentido => _sentido.value;
  set sentido(String newValue) => _sentido.value = newValue;

  Action increment;
  Action reseta;

  Controller() {
    increment = Action(_increment);
    reseta = Action(_reseta);
    autorun((_) {
      print('opa');
    });
  }
  _reseta() {
    _lista2 = List<Hora>();
  }

  _increment() {
    counter++;
    print(counter);
  }
}
