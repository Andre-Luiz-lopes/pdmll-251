# Avaliação 04 - Cadastro de Alunos (Dart + SQLite)

Este projeto é um sistema simples de cadastro de alunos utilizando Dart e SQLite. Ele permite inserir e listar alunos em um banco de dados local, sendo ideal para fins didáticos e avaliações de programação.

## Enunciado da Avaliação

### **PRINTS** --->[`Avaliação-04.pdf`](./Avaliação-04.pdf).

## Estrutura do Projeto

```
.
├── bin/
│   ├── avaliacao_04.dart      # Código principal do sistema
│   ├── alunos.db              # Banco de dados SQLite gerado pelo sistema
│   └── sqlite3.dll            # Biblioteca nativa do SQLite para Windows
├── lib/
│   └── avaliacao_04.dart      # (Opcional) Código compartilhado ou modularizado
├── test/
│   └── avaliacao_04_test.dart # Testes automatizados (se houver)
├── pubspec.yaml               # Gerenciador de dependências do Dart
├── Avaliação-04.pdf           # Enunciado da avaliação
└── README.md                  # Este arquivo
```



## Pré-requisitos

- [Dart SDK](https://dart.dev/get-dart) instalado
- [sqlite3.dll](https://www.sqlite.org/download.html) na pasta `bin/` (veja instruções abaixo)

## Instalação e Execução

1. **Clone o repositório ou baixe os arquivos.**
2. **Instale as dependências:**
   ```powershell
   dart pub get
   ```
3. **Baixe o arquivo `sqlite3.dll`:**
   - Acesse: https://www.sqlite.org/download.html
   - Baixe o arquivo "sqlite-dll-win64-x64-\*.zip" (ou win32-x86 para sistemas 32 bits)
   - Extraia e coloque o `sqlite3.dll` dentro da pasta `bin/` do projeto
4. **Execute o sistema:**
   ```powershell
   cd bin
   dart run avaliacao_04.dart
   ```

## Como Usar

- **1 - Inserir novo aluno:** Digite o nome do aluno (até 50 caracteres). Nomes vazios ou muito longos não são aceitos.
- **2 - Listar alunos:** Exibe todos os alunos cadastrados no banco de dados.
- **0 - Sair:** Encerra o programa.

## Observações

- O banco de dados `alunos.db` será criado automaticamente na primeira execução.
- O arquivo `sqlite3.dll` é obrigatório para o funcionamento do SQLite no Windows.
- Para checar a versão do SQLite instalada, use no terminal:
  ```powershell
  sqlite3 --version
  ```

## Licença

Este projeto é apenas para fins educacionais.
