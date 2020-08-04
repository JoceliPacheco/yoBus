import 'dart:async';

import 'package:animations/animations.dart';
import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'controller.dart';
import 'http/webclient.dart';

import 'models/hora.dart';

int tempo1 = 1000;
int tempo2 = tempo1 + 1000;

String urlImage = 'images/bus.png';

String busca = "";

class newLista extends StatelessWidget {
  final Controller controller;

  newLista(this.controller);

  @override
  Widget build(BuildContext context) {
    controller.increment();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue, Colors.red]),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 30,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Animator<double>(
                resetAnimationOnRebuild: true,
                duration: Duration(milliseconds: (tempo1 * 2)),
                cycles: 1,
                builder: (_, anim, __) => Transform.scale(
                  alignment: Alignment.bottomLeft,
                  scale: anim.value,
                  child: Image.network(
                    'https://pngimg.com/uploads/bus/bus_PNG8618.png',
                    height: 200,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 10,
            height: (MediaQuery.of(context).size.height / 1.7),
            width: (MediaQuery.of(context).size.width) - 20,
            child: Animator<double>(
              resetAnimationOnRebuild: true,
              duration: Duration(milliseconds: (tempo1)),
              cycles: 1,
              builder: (_, anim, __) => Transform.scale(
                alignment: Alignment.bottomCenter,
                scale: anim.value,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0)),
                    color: Colors.white,
                  ),
                  child: Container(),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            height: MediaQuery.of(context).size.height / 1.4,
            width: MediaQuery.of(context).size.width,
            child: Observer(
              builder: (_) {
                print('rea ${controller.counter} $tempo2');

                if (controller.counter > 1) {
                  tempo2 = 500;
                }

                return Listagem(controller, tempo2);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Listagem extends StatelessWidget {
  final Controller controller;
  int tempo2;

  Listagem(this.controller, this.tempo2);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Hora>>(
        future: Future.delayed(Duration(milliseconds: this.tempo2))
            .then((value) => findLinhas(controller, busca)),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
              break;

            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );

              break;

            case ConnectionState.active:
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
              break;

            case ConnectionState.done:
              final List<Hora> lista = snapshot.data;
              if (lista.length <= 0) {
                return Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 0,
                      left: 0,
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: notFound(),
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              busca = '';
                              controller.increment();
                            },
                            child: Icon(Icons.clear),
                          )
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return ListaBox(lista, controller);
              }
              break;
          }
        });
  }
}

class ListaBox extends StatelessWidget {
  final List<Hora> lista;
  final Controller controller;

  ListaBox(this.lista, this.controller);

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    myController.text = busca;
    return Stack(
      children: <Widget>[
        ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              final Hora linha = lista[index];
              return itemBox(linha);
            }),
        Positioned(
          bottom: 0,
          left: 0,
          height: 100,
          width: (MediaQuery.of(context).size.width),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: Colors.white,
                child: Center(
                  child: TextField(
                    textInputAction: TextInputAction.go,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(24.0),
                      border: OutlineInputBorder(),
                      labelText: 'Busca...',
                    ),
                    controller: myController,
                    onChanged: (value) {
                      busca = value;
                    },
                    onSubmitted: (value) {
                      busca = value;
                      Timer(Duration(seconds: 1), () {
                        controller.increment();
                        /* if (busca != '') {
                          setState(() {
                            // MaterialPageRoute(builder: (context) => newLista());
                          });
                        } else {
                          controller.increment();
                        } */
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class itemBox extends StatelessWidget {
  final Hora linha;
  itemBox(this.linha);
  @override
  Widget build(BuildContext context) {
    // if (linha.linha.toLowerCase().toString().contains(busca.toLowerCase())) {
    return OpenContainer(
      closedColor: Colors.transparent,
      closedElevation: 0.0,
      closedBuilder: (BuildContext context, void Function() action) =>
          itemLista(linha),
      openBuilder:
          (BuildContext context, void Function({Object returnValue}) action) {
        return page(linha);
      },
    );
    /* } else {
      return Container();
    }*/
  }
}

class itemLista extends StatelessWidget {
  final Hora linha;
  itemLista(this.linha);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
      child: Animator<double>(
        resetAnimationOnRebuild: true,
        duration: Duration(milliseconds: (200)),
        cycles: 1,
        builder: (_, anim, __) => Transform.scale(
          alignment: Alignment.center,
          scale: anim.value,
          child: Container(
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(const Radius.circular(40.0)),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.red]),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0, // soften the shadow
                  spreadRadius: 1.0, //extend the shadow
                  offset: Offset(5.0, 5.0),
                )
              ],
            ),
            child: Card(
              child: coreCard(linha),
            ),
          ),
        ),
      ),
    );
    ;
  }
}

class coreCard extends StatelessWidget {
  final Hora linha;
  coreCard(this.linha);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          leading: Image.asset(urlImage),
          title: Text(this.linha.linha),
          subtitle: Text(this.linha.sentido),
        ),
      ),
    );
  }
}

class page extends StatelessWidget {
  final Hora linha;
  page(this.linha);
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue, Colors.red]),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
              height: MediaQuery.of(context).size.height - 140,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5.0, // soften the shadow
                    spreadRadius: 1.0, //extend the shadow
                    offset: Offset(0.0, 10.0),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListagemHorarios(this.linha, controller),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Voltar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListagemHorarios extends StatelessWidget {
  final Hora linha;
  final Controller controller;
  ListagemHorarios(this.linha, this.controller);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Hora>>(
        future: Future.delayed(Duration(milliseconds: tempo2))
            .then((value) => findHours(linha, controller)),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;

            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );

              break;

            case ConnectionState.active:
              break;

            case ConnectionState.done:
              final List<Hora> lista = snapshot.data;

              if (lista.length <= 0) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: notFound()),
                );
              } else {
                return GridView.count(
                  primary: true,
                  crossAxisCount: 3,
                  childAspectRatio: 1.5,
                  children: List.generate(lista.length, (index) {
                    final Hora hora = lista[index];
                    return Chip(
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(hora.horarioLargada),
                      ),
                    );
                  }),
                );
                /*ListView.builder(
                  itemCount: lista.length,
                  itemBuilder: (context, index) {
                    final Hora hora = lista[index];
                    return Chip(
                      label: Text(hora.horarioLargada),
                    );
                  });*/
              }
              break;
          }
        });
  }
}

class notFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              '$busca',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Nenhum resultado localizado!'),
          ],
        ),
      ),
    );
  }
}
