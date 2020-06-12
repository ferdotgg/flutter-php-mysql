import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class DetallesPedido extends StatefulWidget {

  int index;
  List lista;

  DetallesPedido({ this.index, this.lista });

  @override
  _DetallesPedidoState createState() => _DetallesPedidoState();

}

class _DetallesPedidoState extends State<DetallesPedido> {

  @override
  Widget build(BuildContext context) {
    TextEditingController controlCantidad = new TextEditingController(text: widget.lista[widget.index]['cantidad']);
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text("DETALLES DEL PEDIDO"),
      ),

      body: new Container(
        padding: EdgeInsets.all(10.0),
        child: new Center(
          child: Column(
            children: <Widget>[

              new Text(
                widget.lista[widget.index]['nombre'],
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
              ),

              new Text(
                "ID #"+widget.lista[widget.index]['idPedido'],
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
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              ),

              new Text(
                "",
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),

              new RaisedButton(
                onPressed: () {
                  var url = "http://localhost/flutter-php-mysql/backend/editarPedido.php";

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
                      "idPedido": widget.lista[widget.index]['idPedido'],
                      "cantidad": controlCantidad.text
                    });

                    Toast.show(
                        "Pedido actualizado correctamente",
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
                  const Text('EDITAR PEDIDO', style: TextStyle(fontSize: 25)),
                ),
              ),

              new Text(
                "",
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),

              new RaisedButton(
                onPressed: () {
                  var url = "http://localhost/flutter-php-mysql/backend/borrarPedido.php";
                  http.post(url, body: {
                    "idPedido": widget.lista[widget.index]['idPedido']
                  });

                  Toast.show(
                      "Pedido eliminado correctamente",
                      context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.CENTER,
                      backgroundColor: Colors.green,
                      textColor: Colors.white
                  );

                  Navigator.of(context).pop();
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFFE53935),
                        Color(0xFFD32F2F),
                        Color(0xFFC62828),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child:
                  const Text('ELIMINAR PEDIDO', style: TextStyle(fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

}