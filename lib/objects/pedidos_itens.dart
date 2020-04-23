class Hist {
  //Classe para criar os itens
  final String codPedido;
  final String status;
  final String statusDescricao;
  final String usuario;
  final String placa;
  final String box;
  final String tipoVeiculo;
  final String dtCadastro;
  final String hrCadastro;

  Hist(
      {this.codPedido,
      this.status,
      this.statusDescricao,
      this.usuario,
      this.placa,
      this.box,
      this.tipoVeiculo,
      this.dtCadastro,
      this.hrCadastro});

  factory Hist.fromJson(Map<String, dynamic> json) {
    return Hist(
        codPedido: json['cod_pedido'],
        status: json['status'],
        statusDescricao: json['status_descricao'],
        usuario: json['usuario'],
        placa: json['placa'],
        box: json['box'],
        tipoVeiculo: json['tipo_veiculo'],
        dtCadastro: json['dt_cadastro'],
        hrCadastro: json['hr_cadastro']);
  }
}

class Ped {
  //Classe para criar os itens
  final String codPedido;
  final String status;
  final String statusDescricao;
  final String descricao;

  Ped({this.codPedido, this.status, this.statusDescricao, this.descricao});

  factory Ped.fromJson(Map<String, dynamic> json) {
    return Ped(
        codPedido: json['cod_pedido'],
        status: json['status'],
        statusDescricao: json['status_descricao'],
        descricao: json['descricao']);
  }
}
