import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:sqlite3/sqlite3.dart';

void main() {
  final db = sqlite3.open('alunos.db');

  // Criação da tabela TB_ALUNO se não existir
  db.execute('''
    CREATE TABLE IF NOT EXISTS TB_ALUNO (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL CHECK(length(nome) <= 50)
    );
  ''');

  print('=== Cadastro de Alunos ===');

  while (true) {
    print('\nEscolha uma opção:');
    print('1 - Inserir novo aluno');
    print('2 - Listar alunos');
    print('0 - Sair');
    stdout.write('Opção: ');
    String? opcao = stdin.readLineSync();

    if (opcao == '1') {
      inserirAluno(db);
    } else if (opcao == '2') {
      listarAlunos(db);
    } else if (opcao == '0') {
      print('Saindo...');
      break;
    } else {
      print('Opção inválida, tente novamente.');
    }
  }

  db.dispose();
}

void inserirAluno(Database db) {
  stdout.write('Digite o nome do aluno (até 50 caracteres): ');
  String? nome = stdin.readLineSync();

  if (nome == null || nome.trim().isEmpty) {
    print('Nome inválido. Não pode ser vazio.');
    return;
  }

  if (nome.length > 50) {
    print('Nome muito longo. Máximo 50 caracteres.');
    return;
  }

  final stmt = db.prepare('INSERT INTO TB_ALUNO (nome) VALUES (?);');
  try {
    stmt.execute([nome.trim()]);
    print('Aluno inserido com sucesso.');
  } catch (e) {
    print('Erro ao inserir aluno: \$e');
  } finally {
    stmt.dispose();
  }
}

void listarAlunos(Database db) {
  final ResultSet resultSet = db.select('SELECT id, nome FROM TB_ALUNO ORDER BY id;');

  if (resultSet.isEmpty) {
    print('Nenhum aluno cadastrado.');
  } else {
    print('\nLista de alunos:');
    for (final row in resultSet) {
      print("ID: ${row['id']} - Nome: ${row['nome']}");
    }
  }
}
