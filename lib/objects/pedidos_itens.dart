class Pedido {
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

  Pedido(
      {this.codPedido,
      this.status,
      this.statusDescricao,
      this.usuario,
      this.placa,
      this.box,
      this.tipoVeiculo,
      this.dtCadastro,
      this.hrCadastro});

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
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

class Itens {
  //Classe para criar os itens
  final String codPedido;
  final String status;
  final String statusDescricao;
  final String descricao;

  Itens({this.codPedido, this.status, this.statusDescricao, this.descricao});

  factory Itens.fromJson(Map<String, dynamic> json) {
    return Itens(
        codPedido: json['cod_pedido'],
        status: json['status'],
        statusDescricao: json['status_descricao'],
        descricao: json['descricao']);
  }
}
