import 'package:flutter/material.dart';
import 'package:yoBus/http/webclient.dart';

import 'newLista.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: newLista(),
      //body: MapSample(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.search),
          backgroundColor: new Color(0xFFE57373),
          onPressed: () {
            findLinhas().then((value) => null);
          }),
    );
  }
}
