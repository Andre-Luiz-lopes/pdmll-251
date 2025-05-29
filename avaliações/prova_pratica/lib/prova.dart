import 'dart:convert';
import 'dart:io';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';



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

void main() async {
  // Cria os objetos
  var cliente = Cliente(1, 'João da Silva', 2);
  var vendedor = Vendedor(101, 'Maria Oliveira', 0.05);
  var veiculo = Veiculo(501, 'Carro Sedan', 45000.0);

  var item1 = ItemPedido(1, 'Rodas esportivas', 2, 1500.0);
  var item2 = ItemPedido(2, 'Som automotivo', 1, 2000.0);

  var pedido = PedidoVenda('P001', DateTime.now(), cliente, vendedor, veiculo, [item1, item2]);


  String jsonPedido = jsonEncode(pedido.toJson());


  final jsonFile = File('pedido.json');
  await jsonFile.writeAsString(jsonPedido);

  print('✅ Arquivo pedido.json criado!');


  final String username = 'andre.luiz60@aluno.ifce.edu.br';
  final String password = 'jwpr twmq qzjj knpe';

  final smtpServer = gmail(username, password);


  final attachment = FileAttachment(jsonFile)
    ..location = Location.inline
    ..cid = '<pedido.json>';

  final message = Message()
    ..from = Address(username, 'André Luiz')
    ..recipients.add('taveira@ifce.edu.br') 
    ..subject = 'arquivo JSON do Pedido'
    ..text = 'segue em anexo o arquivo JSON gerado pelo sistema'
    ..attachments = [attachment];

  try {
    final sendReport = await send(message, smtpServer);
    print('E-mail enviado com sucesso!');
    print('Detalhes do envio: $sendReport');
  } on MailerException catch (e) {
    print('Falha ao enviar e-mail: ${e.toString()}');
  }
}
