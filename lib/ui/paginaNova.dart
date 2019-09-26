import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import '../helper/pessoa_helper.dart';

class paginaNova extends StatefulWidget {
  final Person pessoinha;

  paginaNova({this.pessoinha});

  @override
  _paginaNovaState createState() => _paginaNovaState();
}

class _paginaNovaState extends State<paginaNova> {
  final _nameController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _nameFocus = FocusNode();

  Person _editedPessoinha;
  bool _userEdited = false;

  @override
  void initState() {
    super.initState();
    if (widget.pessoinha == null) {
      _editedPessoinha = Person();
    } else {
      _editedPessoinha = Person.fromMap(widget.pessoinha.toMap());
      _nameController.text = _editedPessoinha.nome;
      _telefoneController.text = _editedPessoinha.telefone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: Text(_editedPessoinha.nome ?? 'Novo contato'),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.save),
              backgroundColor: Colors.blueAccent,
              onPressed: () {
                if (_editedPessoinha.nome != null &&
                    _editedPessoinha.nome.isNotEmpty) {
                  Navigator.pop(context, _editedPessoinha);
                } else {
                  FocusScope.of(context).requestFocus(_nameFocus);
                }
              }),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: "Nome"),
                  focusNode: _nameFocus,
                  onChanged: (text) {
                    _userEdited = true;
                    _editedPessoinha.nome = text;
                  },
                  controller: _nameController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Telefone"),
                  onChanged: (text) {
                    _userEdited = true;
                    _editedPessoinha.telefone = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: _telefoneController,
                ),
              ],
            ),
          ),
        ));
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Descartar alterações?'),
              content: Text('Se sair as alterações serão perdidas.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text('Sim'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
