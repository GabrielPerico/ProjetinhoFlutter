import 'dart:async';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import '../helper/login_helper.dart';
import 'package:flutter_meuprojeto/main.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  final Login login;

  LoginScreen({this.login});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginHelper helper = LoginHelper();
  final _nameController = TextEditingController();
  final _senhaController = TextEditingController();
  final _nameFocus = FocusNode();

  Login _editedContact;
  Logado _editedLogado;
  bool _userEdited = false;

  @override
  void initState() {
    super.initState();
    if (widget.login == null) {
      _editedContact = Login();
      _editedLogado = Logado();
    } else {
      _editedContact = Login.fromMap(widget.login.toMap());
      _nameController.text = _editedContact.nome;
      _senhaController.text = _editedContact.senha;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Nome"),
              focusNode: _nameFocus,
              onChanged: (text) {
                _userEdited = true;
                setState(() {
                  _editedContact.nome = text;
                });
              },
              controller: _nameController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Senha"),
              onChanged: (text) {
                _userEdited = true;
                _editedContact.senha = text;
              },
              keyboardType: TextInputType.visiblePassword,
              controller: _senhaController,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: ButtonTheme(
                minWidth: double.infinity,
                child: RaisedButton(
                  padding:
                  EdgeInsets.symmetric(vertical: 15.0),
                  elevation: 3,
                  child: Text("Entrar"),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressed: () async {
                    if (await helper.getLogin(
                        _editedContact.nome, _editedContact.senha) !=
                        null) {
                      helper.saveLogado(_editedLogado);
                      Navigator.pop(context);
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
                child: ButtonTheme(
                  minWidth: double.infinity,
                  child: RaisedButton(
                      padding:
                      EdgeInsets.symmetric(vertical: 15.0),
                      child: Text("Cadastrar"),
                      elevation: 3,
                      color: Colors.white,
                      textColor: Colors.blueAccent,
                      onPressed: () async {
                        if (_editedContact.nome != null &&
                            _editedContact.senha != null) {
                          helper.saveLogin(_editedContact);
                        }
                        setState(() {
                          _nameController.text = '';
                          _senhaController.text = '';
                        });
                      }),
                ),
            ),

          ],
        ),
      ),
    );
  }
}
