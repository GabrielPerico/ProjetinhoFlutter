import 'dart:io';
import 'package:flutter/material.dart';
import 'paginaNova.dart';
import 'pessoa.dart';
import 'package:url_launcher/url_launcher.dart';
import '../helper/pessoa_helper.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PersonHelper helper = PersonHelper();
  List<Person> person = List();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('App maneiro'),
            backgroundColor: Colors.blueAccent,
            centerTitle: true),
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
            itemCount: pessoinha.length,
            itemBuilder: (context, index) {
              return _contactCard(context, index);
            }));
  }

  void _showContactPage() async {
    final recContact = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => paginaNova(),
        ));
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              title: Text('Nome: '+pessoinha[index].nome),
              subtitle: Text('Número: '+pessoinha[index].telefone),
              trailing: Text(pessoinha[index].id.toString()),
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
                            Icon(Icons.person, color: Colors.blueAccent),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Ver',
                                      style: TextStyle(
                                          color: Colors.blueAccent, fontSize: 20.0),
                                    )
                                  ],
                                ))
                          ],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(pessoinha[index]),
                            ),
                          );
                        },
                      ),
                    ),
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
                                          color: Colors.blueAccent, fontSize: 20.0),
                                    )
                                  ],
                                ))
                          ],
                        ),
                        onPressed: () {
                          launch("tel:${pessoinha[index].telefone}");
                          Navigator.pop(context);
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
}



