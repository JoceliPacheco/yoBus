class Hora {
  String id;
  Null dataExtracao;
  String linha;
  String sentido;
  String tipoTabela;
  String tipoDia;
  String horarioLargada;
  String adaptadoDeficiente;
  String sigla;

  Hora(
      {this.id,
      this.dataExtracao,
      this.linha,
      this.sentido,
      this.tipoTabela,
      this.tipoDia,
      this.horarioLargada,
      this.adaptadoDeficiente,
      this.sigla});

  Hora.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dataExtracao = json['data_extracao'];
    linha = json['linha'];
    sentido = json['sentido'];
    tipoTabela = json['tipo_tabela'];
    tipoDia = json['tipo_dia'];
    horarioLargada = json['horario_largada'];
    adaptadoDeficiente = json['adaptado_deficiente'];
    sigla = json['sigla'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data_extracao'] = this.dataExtracao;
    data['linha'] = this.linha;
    data['sentido'] = this.sentido;
    data['tipo_tabela'] = this.tipoTabela;
    data['tipo_dia'] = this.tipoDia;
    data['horario_largada'] = this.horarioLargada;
    data['adaptado_deficiente'] = this.adaptadoDeficiente;
    data['sigla'] = this.sigla;
    return data;
  }
}
