import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class DetallesProducto extends StatefulWidget {

  int index;
  List lista;

  DetallesProducto({ this.index, this.lista });

  @override
  _DetallesProductoState createState() => _DetallesProductoState();

}

class _DetallesProductoState extends State<DetallesProducto> {
  TextEditingController controlCantidad = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text("DETALLES DEL PRODUCTO"),
      ),

      body: new Container(
        padding: EdgeInsets.all(10.0),
        child: new Center(
          child: Column(
            children: <Widget>[

              new Text(
                widget.lista[widget.index]['NombreProducto'],
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
              ),

              new Text(
                "ID #"+widget.lista[widget.index]['idProducto'],
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),

              new Text(
                "Categoria: "+widget.lista[widget.index]['NombreCategoria'],
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),

              new Text(
                "₡"+widget.lista[widget.index]['precio'],
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),

              new TextField(
                controller: controlCantidad,
                decoration: new InputDecoration(
                    labelText: "Cantidad"
                ),
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
              ),

              new Text(
                "",
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),

              new RaisedButton(
                onPressed: () {
                  var url = "http://localhost/flutter-php-mysql/backend/agregarPedido.php";

                  if(controlCantidad.text == ""){
                    Toast.show(
                        "Debe ingresar una cantidad para el producto",
                        context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.CENTER,
                        backgroundColor: Colors.redAccent,
                        textColor: Colors.white
                    );
                  }else{
                    http.post(url, body: {
                      "idProducto": widget.lista[widget.index]['idProducto'],
                      "cantidad": controlCantidad.text
                    });

                    Toast.show(
                        "Se agregó a tu carrito de compras",
                        context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.CENTER,
                        backgroundColor: Colors.green,
                        textColor: Colors.white
                    );

                    Navigator.of(context).pop();
                  }
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
                  const Text('AGREGAR AL CARRITO', style: TextStyle(fontSize: 25)),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

}