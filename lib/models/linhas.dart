class Linha {
  String id;
  String nome;
  String codigo;

  Linha({this.id, this.nome, this.codigo});
  
  Linha.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    codigo = json['codigo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['codigo'] = this.codigo;
    return data;
  }
}
