import 'package:flutter/material.dart';

import 'basic_animation_0/main.dart';
import 'basic_animation_1/main.dart';
import 'basic_animation_2/nested_animator.dart';

class Teste extends StatelessWidget {
  Color baseColor = Color(0xFFF2F2F2);

  goto(Widget page, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text("Basic Animation 0"),
            onPressed: () => goto(BasicAnimation0(), context),
          ),
          RaisedButton(
            child: Text("Basic Animation 1"),
            onPressed: () => goto(BasicAnimation1(), context),
          ),
          RaisedButton(
            child: Text("Basic Animation 2"),
            onPressed: () => goto(MyCustomPainterAnimation(), context),
          ),
        ],
      ),
    );
  }
}
