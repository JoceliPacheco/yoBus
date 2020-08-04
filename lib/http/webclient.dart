import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'package:yoBus/models/hora.dart';
import 'package:yoBus/models/linhas.dart';

import '../controller.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print(data);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print(data);
    return data;
  }
}

final Client client = HttpClientWithInterceptor.build(interceptors: [
  LoggingInterceptor(),
]);

Future<List<Linha>> findAll(String tipo) async {
  final String _tipo = tipo == 'lotacao' ? 'l' : 'o';
  final Response response = await client.get(
      'http://www.poatransporte.com.br/php/facades/process.php?a=nc&p=%&t=$_tipo');

  final List<dynamic> fromJson = jsonDecode(response.body);
  final List<Linha> lista = List();

  for (Map<String, dynamic> element in fromJson) {
    final Linha linha = Linha(
        id: element['id'], nome: element['nome'], codigo: element['codigo']);

    lista.add(linha);
  }

  return lista;
}

filtra(List<Hora> lista, String txt) {
  if (txt.isEmpty) {
    return lista;
  } else {
    return lista
        .where((item) => item.linha.toLowerCase().contains(txt.toLowerCase()))
        .toList();
  }
}

Future<List<Hora>> findLinhas(Controller controller, String txt) async {
  if (controller.lista.length > 0) {
    List<Hora> lista = controller.lista;
    return await filtra(lista, txt);
  } else {
    try {
      final Response response = await client
          .get('http://jocelidevops.000webhostapp.com/api/linhas.php')
          .timeout(const Duration(seconds: 5));

      print('STATUS ${response.statusCode}');

      final List<dynamic> fromJson = jsonDecode(response.body);
      final List<Hora> lista = List();

      for (Map<String, dynamic> element in fromJson) {
        final Hora hora = Hora(
          id: element['id'],
          linha: element['linha'],
          horarioLargada: element['horario_largada'],
          sigla: element['sigla'],
          sentido: element['sentido'],
        );

        lista.add(hora);
        controller.lista.add(hora);
      }

      return await filtra(lista, txt);
    } on TimeoutException catch (e) {
      print('Timeout');
      final List<Hora> lista = List();
      return lista;
    } on Error catch (e) {
      print('Error: $e');
      final List<Hora> lista = List();
      return lista;
    }
  }
}

Future<List<Hora>> findHours(Hora linha, Controller controller) async {
  if (controller.lista2.length > 0 &&
      linha.linha == controller.linha &&
      linha.sentido == controller.sentido) {
    List<Hora> lista = controller.lista2;
    return lista;
  } else {
    try {
      controller.linha = linha.linha;
      controller.sentido = linha.sentido;
      controller.reseta();
      final Response response = await client
          .get(
              'http://jocelidevops.000webhostapp.com/api/index.php?linha=${linha.linha}&sentido=${linha.sentido}')
          .timeout(const Duration(seconds: 5));

      final List<dynamic> fromJson = jsonDecode(response.body);
      final List<Hora> lista = List();
      print('STATUS ${response.statusCode}');

      for (Map<String, dynamic> element in fromJson) {
        final Hora hora = Hora(
          id: element['id'],
          linha: element['linha'],
          horarioLargada: element['horario_largada'],
          sigla: element['sigla'],
          sentido: element['sentido'],
        );
        controller.lista2.add(hora);
        lista.add(hora);
      }

      return lista;
    } on TimeoutException catch (e) {
      print('Timeout');
      final List<Hora> lista = List();
      return lista;
    } on Error catch (e) {
      print('Error: $e');
      final List<Hora> lista = List();
      return lista;
    }
  }
}
