import 'package:banking_app/src/states/contador.state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContadorPage extends StatefulWidget {
  ContadorPage({Key key}) : super(key: key);

  @override
  _ContadorPageState createState() => _ContadorPageState();
}

class _ContadorPageState extends State<ContadorPage> {
  @override
  Widget build(BuildContext context) {
    final contadorState = Provider.of<ContadorState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Contador"),
      ),
      body: Center(
        child: Text("Contador : " + contadorState.contador.toString()),
      ),
    );
  }
}
