import 'dart:convert';

class Cliente {
  int codigo;
  String nome;
  int tipoCliente;

  Cliente(this.codigo, this.nome, this.tipoCliente);

  Map<String, dynamic> toJson() =>
      {'codigo': codigo, 'nome': nome, 'tipoCliente': tipoCliente};
}

class Vendedor {
  int codigo;
  String nome;
  double comissao;

  Vendedor(this.codigo, this.nome, this.comissao);

  Map<String, dynamic> toJson() =>
      {'codigo': codigo, 'nome': nome, 'comissao': comissao};
}

class Veiculo {
  int codigo;
  String descricao;
  double valor;

  Veiculo(this.codigo, this.descricao, this.valor);

  Map<String, dynamic> toJson() =>
      {'codigo': codigo, 'descricao': descricao, 'valor': valor};
}

class ItemPedido {
  int sequencial;
  String descricao;
  int quantidade;
  double valor;

  ItemPedido(this.sequencial, this.descricao, this.quantidade, this.valor);

  Map<String, dynamic> toJson() => {
        'sequencial': sequencial,
        'descricao': descricao,
        'quantidade': quantidade,
        'valor': valor
      };
}

class PedidoVenda {
  String codigo;
  DateTime data;
  Cliente cliente;
  Vendedor vendedor;
  Veiculo veiculo;
  List<ItemPedido> items;

  PedidoVenda(this.codigo, this.data, this.cliente, this.vendedor,
      this.veiculo, this.items);

  double calcularPedido() =>
      items.fold(0, (total, item) => total + item.valor * item.quantidade);

  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'data': data.toIso8601String(),
        'cliente': cliente.toJson(),
        'vendedor': vendedor.toJson(),
        'veiculo': veiculo.toJson(),
        'items': items.map((e) => e.toJson()).toList(),
        'valorPedido': calcularPedido()
      };
}

void main() {
  var cliente = Cliente(1, 'João da Silva', 2);
  var vendedor = Vendedor(101, 'Maria Oliveira', 0.05);
  var veiculo = Veiculo(501, 'Carro Sedan', 45000.0);

  var item1 = ItemPedido(1, 'Rodas esportivas', 2, 1500.0);
  var item2 = ItemPedido(2, 'Som automotivo', 1, 2000.0);

  var pedido = PedidoVenda('P001', DateTime.now(), cliente, vendedor, veiculo, [item1, item2]);

  String jsonPedido = jsonEncode(pedido.toJson());

  print(jsonPedido);
}

