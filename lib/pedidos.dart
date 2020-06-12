import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'detalles_pedido.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new ListaPedidos(),
    );
  }
}

class ListaPedidos extends StatefulWidget {
  @override
  _ListaPedidosState createState() => _ListaPedidosState();
}

class _ListaPedidosState extends State<ListaPedidos> {
  var isLoading = false;

  Future<List> obtenerPedidos() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get("http://localhost/flutter-php-mysql/backend/obtenerPedidos.php");
    setState(() {
      isLoading = false;
    });
    return json.decode(response.body);

  }

  _getPedidos() async {
    final response = await http.get("http://localhost/flutter-php-mysql/backend/obtenerPedidos.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text("CARRITO DE COMPRAS"),
      ),

      body: new FutureBuilder<List> (
        future: obtenerPedidos(),
        builder: (context, snapshot) {
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ElementoLista(
            lista: snapshot.data,
          )
              : new Center(
            child: new CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          var url = "http://localhost/flutter-php-mysql/backend/comprar.php";
          http.post(url, body: {
            "comprar": "comprar"
          });

          Toast.show(
              "Se realizó tu compra correctamente",
              context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.CENTER,
              backgroundColor: Colors.green,
              textColor: Colors.white
          );
        },
        label: Text('Comprar'),
        icon: Icon(Icons.check),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class ElementoLista extends StatelessWidget {

  final List lista;

  ElementoLista({ this.lista });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
      itemCount: lista == null ? 0 : lista.length,
      itemBuilder: (context, posicion) {
        return new Container(
          padding: EdgeInsets.all(2.0),
          child: new GestureDetector(
            onTap: () {
            },
            child: new Card(
              color: Colors.deepPurpleAccent,
              child: InkWell(
                splashColor: Colors.white.withAlpha(60),
                onTap: () {
                  Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new DetallesPedido(
                          index: posicion,
                          lista: lista,
                        ),
                      )
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    lista[posicion]['nombre']+" - "+" | ₡"+lista[posicion]['precio']+" | "+lista[posicion]['cantidad']+" unidades",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),

          ),
        );
      },
    );
  }
}