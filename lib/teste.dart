import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:yoBus/lista.dart';

class Teste extends StatelessWidget {
  Color baseColor = Color(0xFFF2F2F2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: OpenContainer(
              transitionDuration: Duration(seconds: 3),
              openBuilder: (BuildContext context,
                      void Function({Object returnValue}) action) =>
                  Container(
                child: Lista(),
              ),
              closedBuilder: (BuildContext context, void Function() action) =>
                  Center(
                child: ListTile(
                  title: Text('Clica'),
                  subtitle: Icon(Icons.add),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
