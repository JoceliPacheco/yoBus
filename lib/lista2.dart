import 'package:flutter/material.dart';
import 'package:yoBus/http/webclient.dart';

import 'models/linhas.dart';

class Lista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue, Colors.red]),
      ),
      child: FutureBuilder<List<Linha>>(
        future: Future.delayed(Duration(seconds: 2))
            .then((value) => findAll('onibus')),
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
              final List<Linha> lista = snapshot.data;

              return Stack(children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: Center(
                    child: Text('youBus'),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(40.0),
                            topRight: const Radius.circular(40.0)),
                        color: Colors.white,
                      ),
                      child: OverflowBox(
                        minWidth: MediaQuery.of(context).size.width,
                        maxWidth: MediaQuery.of(context).size.width,
                        minHeight: MediaQuery.of(context).size.height / 1.55,
                        maxHeight: MediaQuery.of(context).size.height / 1.55,
                        child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              final Linha linha = lista[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 16, 40, 16),
                                child: InkWell(
                                  onTap: () {
                                    print('Clicou');
                                  },
                                  child: Container(
                                    decoration: new BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 5.0, // soften the shadow
                                          spreadRadius: 1.0, //extend the shadow
                                          offset: Offset(
                                            5.0, // Move to right 10  horizontally
                                            10.0, // Move to bottom 10 Vertically
                                          ),
                                        )
                                      ],
                                    ),
                                    child: Card(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          title: Text(linha.codigo),
                                          subtitle: Text(linha.nome),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ),
              ]);
              break;
          }

          return Text('Erro desconhecido');
        },
      ),
    );
  }
}

/*
ListView.builder(
                            itemCount: lista.length,
                            itemBuilder: (context, index) {
                              final Linha linha = lista[index];
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 8.0, 16.0, 8.0),
                                child: InkWell(
                                  onTap: () {
                                    print('Clicou');
                                  },
                                  child: Container(
                                    decoration: new BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 5.0, // soften the shadow
                                          spreadRadius: 1.0, //extend the shadow
                                          offset: Offset(
                                            0.0, // Move to right 10  horizontally
                                            5.0, // Move to bottom 10 Vertically
                                          ),
                                        )
                                      ],
                                    ),
                                    child: Card(
                                      color: Colors.white,
                                      child: ListTile(
                                        title: Text(linha.codigo),
                                        subtitle: Text(linha.nome),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
 */
