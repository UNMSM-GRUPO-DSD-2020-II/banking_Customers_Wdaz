//import 'package:app_consultaperu/src/utils/RemoteConfig.util.dart.txt';
import 'package:banking_app/src/states/contador.state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final contadorState = Provider.of<ContadorState>(context);
    return Scaffold(
        appBar: _appBar(),
        body: Center(
          child: Column(
            children: [
              Divider(),
              Text("CONTADOR : " + contadorState.contador.toString()),
              Divider(),
              Center(
                child: RaisedButton(
                    child: Text("Ver contador"),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        'contador',
                      );
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    shape: StadiumBorder()),
              )
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: Text('https://banking.com.pe'),
                accountName: Text('Banking'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/user_default.png"),
                ),
              ),
              ListTile(
                leading: Icon(Icons.feedback),
                title: Text("Enviar sugerencia"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'contador');
                  /*Navigator.pushNamed(context, 'lista_atencion',
                      arguments: new Paciente.withId(0, null));*/
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Compartir App"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  final RenderBox box = context.findRenderObject();
                  Share.share("text content",
                      sharePositionOrigin:
                          box.localToGlobal(Offset.zero) & box.size);
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Customers"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    'customers',
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 31),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    setState(() {
                      contadorState.remove();
                    });
                  },
                  child: Icon(Icons.remove),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  setState(() {
                    contadorState.add();
                  });
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ));
  }

  Widget _appBar() {
    return new AppBar(
      title: Text("Banking App"),
      elevation: 0,
    );
  }
}
