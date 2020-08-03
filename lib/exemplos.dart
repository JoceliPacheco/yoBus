import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:clay_containers/widgets/clay_text.dart';
import 'package:flutter/material.dart';

class Exemplo extends StatelessWidget {
  Color baseColor = Color(0xFFF2F2F2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClayContainer(
          borderRadius: 40,
          color: baseColor,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: ClayText("Seize the Clay!", emboss: true, size: 40),
          ),
        ),
      ),
    );
  }
}
