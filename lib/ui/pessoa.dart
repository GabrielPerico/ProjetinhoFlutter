import 'dart:io';
import 'package:flutter/material.dart';
import '../helper/pessoa_helper.dart';

class DetailScreen extends StatelessWidget {
  PersonHelper helper = PersonHelper();
  final Person person;

  DetailScreen(this.person);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          person.id.toString() + "  |  " + person.nome,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(person.telefone),
      ),
    );
  }
}
