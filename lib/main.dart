import 'package:flutter/material.dart';
import 'ui/home.dart';
import 'ui/login.dart';
import 'helper/login_helper.dart';

void main() async{
  LoginHelper helper = LoginHelper();

  runApp(MaterialApp(
      home: (await helper.getLogado() == true)?HomePage():LoginPage(),
      debugShowCheckedModeBanner: false,
    ));


}


