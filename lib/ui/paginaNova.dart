import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

class paginaNova extends StatefulWidget {
  @override
  _paginaNovaState createState() => _paginaNovaState();
}

class _paginaNovaState extends State<paginaNova> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Coisa loka'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            FocusScope.of(context).requestFocus(_nameFocus);
          }),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Nome"),
              focusNode: _nameFocus,
              onChanged: (text) {},
              controller: _nameController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Email"),
              onChanged: (text) {},
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.blueAccent,
                textColor: Colors.white,
                child: Text(
                  "SALVAR",
                  style: TextStyle(fontSize: 20.0),
                ),
                padding: EdgeInsets.only(left: 130.0, right: 130.0),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
