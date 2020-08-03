import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:yoBus/http/webclient.dart';
import 'controller.dart';
import 'http/webclient.dart';
import 'newLista.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Controller controller = Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: newLista(controller),
      //body: MapSample(),

      /*  floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.search),
          backgroundColor: new Color(0xFFE57373),
          onPressed: () {
            controller.increment();
          }),*/
    );
  }
}
