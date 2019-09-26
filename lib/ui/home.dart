import 'dart:io';
import 'package:flutter/material.dart';
import 'paginaNova.dart';
import 'login.dart';
import 'pessoa.dart';
import 'package:url_launcher/url_launcher.dart';
import '../helper/pessoa_helper.dart';
import '../helper/login_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

enum OrderOptions { orderaz, orderza, sair }

class _HomePageState extends State<HomePage> {
  LoginHelper helperLog = LoginHelper();
  PersonHelper helper = PersonHelper();
  List<Person> person = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('App maneiro'),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton<OrderOptions>(
                itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
                      const PopupMenuItem<OrderOptions>(
                        child: Text('Ordenar de A-Z'),
                        value: OrderOptions.orderaz,
                      ),
                      const PopupMenuItem<OrderOptions>(
                        child: Text('Ordenar de Z-A'),
                        value: OrderOptions.orderza,
                      ),
                      const PopupMenuItem<OrderOptions>(
                          child: Text('Sair'),
                          value: OrderOptions.sair,
                      )
                    ],
                onSelected: _orderList)
          ],
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showContactPage();
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: person.length,
            itemBuilder: (context, index) {
              return _personCard(context, index);
            }));
  }

  void _showContactPage({Person person}) async {
    final recContact = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => paginaNova(
                  pessoinha: person,
                )));
    if (recContact != null) {
      if (person != null) {
        await helper.updatePerson(recContact);
      } else {
        await helper.savePerson(recContact);
      }
      _getAllPersons();
    }
  }

  Widget _personCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              title: Text('Nome: ' + person[index].nome),
              subtitle: Text('Número: ' + person[index].telefone),
              trailing: Text(person[index].id.toString()),
              leading: Icon(
                Icons.camera_alt,
                size: 40.0,
              ),
            )),
      ),
      onTap: () {
        _showOptions(context, index);
      },
    );
  }

  void _orderList(OrderOptions result) async{
    switch (result) {
      case OrderOptions.orderaz:
        person.sort((a, b) {
          return a.nome.toLowerCase().compareTo(b.nome.toLowerCase());
        });
        break;
      case OrderOptions.orderza:
        person.sort((a, b) {
          return b.nome.toLowerCase().compareTo(a.nome.toLowerCase());
        });
        break;
      case OrderOptions.sair:
          helperLog.deleteLogado();
          Navigator.pop(context);
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginPage()));
        break;
    }
    setState(() {});
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.phone, color: Colors.blueAccent),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Ligar',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 20.0),
                                    )
                                  ],
                                ))
                          ],
                        ),
                        onPressed: () {
                          launch("tel:${person[index].telefone}");
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.edit, color: Colors.blueAccent),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Editar',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 20.0),
                                    )
                                  ],
                                ))
                          ],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          _showContactPage(person: person[index]);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.delete, color: Colors.white),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Deletar',
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 20.0),
                                    )
                                  ],
                                ))
                          ],
                        ),
                        onPressed: () {
                          helper.deletePerson(person[index].id);
                          setState(() {
                            person.removeAt(index);
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  void _getAllPersons() {
    helper.getAllPersons().then((list) {
      setState(() {
        person = list;
      });
    });
  }
}
