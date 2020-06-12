import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'pedidos.dart';
import 'detalles_producto.dart';
import 'dart:developer';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new ListaProductos(),
    );
  }
}

class ListaProductos extends StatefulWidget {
  @override
  _ListaProductosState createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {
  var isLoading = false;

  Future<List> obtenerUsuarios() async {
    final response = await http.get("http://localhost/flutter-php-mysql/backend/obtenerProductos.php");
    return json.decode(response.body);

  }

  _getUsuarios() async {
    final response = await http.get("http://localhost/flutter-php-mysql/backend/obtenerProductos.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text("LISTA DE PRODUCTOS"),
      ),

      body: new FutureBuilder<List> (
        future: obtenerUsuarios(),
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

      floatingActionButton: new FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        backgroundColor: Colors.orange,
        onPressed: () => Navigator.of(context).push(
            new MaterialPageRoute(builder: (BuildContext context) => new ListaPedidos(),
            )
        ),
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
                builder: (BuildContext context) => new DetallesProducto(
                  index: posicion,
                  lista: lista,
                ),
              )
          );
        },
        child: Container(
          padding: EdgeInsets.all(30),
        child: Text(
        lista[posicion]['NombreCategoria']+" - "+lista[posicion]['NombreProducto']+" | ₡"+lista[posicion]['precio'],
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