import 'package:flutter/material.dart';

import 'dart:async';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'productos.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController controlUsuario = new TextEditingController();
  TextEditingController controlContrasena = new TextEditingController();

  Future<List> obtenerUsuario() async {
    var url = "http://localhost/flutter-php-mysql/backend/obtenerUsuario.php";
    final response = await http.post(url, body: {
      "usuario": controlUsuario.text,
      "password": controlContrasena.text
    });

    if(response.body == "CORRECTO") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ListaProductos()),
            (Route<dynamic> route) => false,
      );
      Toast.show(
          "LOGIN CORRECTO",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white
      );

    } else if(response.body == "ERROR") {
      Toast.show(
          "LOGIN INCORRECTO",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(

      body:


      Container(

        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 5, top: 30, right: 5),

        child: Column(
          children: <Widget>[

            new Text(
              "",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),

            new Text(
              "",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),

            Image.asset("./assets/logo.png"),
         Container(
              padding: EdgeInsets.only(left: 50, top: 25, right: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  TextField(
                    controller: controlUsuario,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: "USUARIO",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  TextField(
                    controller: controlContrasena,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "CONTRASEÑA",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(50),
              child: new RaisedButton(
                onPressed: () {
                  obtenerUsuario();
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child:
                  const Text('INICIAR SESIÓN', style: TextStyle(fontSize: 20)),
                ),
              ),
            ),

          ],
        ),

      ),

    );
  }

}