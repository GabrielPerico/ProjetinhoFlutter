import 'dart:io';
import 'package:flutter/material.dart';

class Pessoa {
  final int id;
  final String nome;
  final String telefone;

  Pessoa(this.id, this.nome, this.telefone);
}

final pessoinha = List<Pessoa>.generate(
  10,
  (i) => Pessoa(
    i,
    'Nome$i',
    '($i$i) $i$i$i$i-$i$i$i$i',
  ),
);

class DetailScreen extends StatelessWidget {
  final Pessoa pessoinha;

  DetailScreen(this.pessoinha);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pessoinha.id.toString() + "  |  " + pessoinha.nome,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(pessoinha.telefone),
      ),
    );
  }
}

Widget _ScreenLokassa(BuildContext context) {
  return ListView.builder(
    itemCount: pessoinha.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text('Nome: ' + pessoinha[index].nome),
        subtitle: Text('Numero: ' + pessoinha[index].telefone),
        trailing: Text(pessoinha[index].id.toString()),
      );
    },
  );
}
