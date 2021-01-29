import 'package:banking_app/src/pages/Contador.page.dart';
import 'package:banking_app/src/pages/CustomerList.page.dart';
import 'package:banking_app/src/pages/Main.page.dart';
import 'package:flutter/material.dart';

class RouterPage {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MainPage());

      case 'contador':
        return MaterialPageRoute(
          builder: (_) => ContadorPage(),
        );
      /*case 'consulta_website_view':
        return MaterialPageRoute(
          builder: (_) => ConsultaWebsiteViewPage(args),
        );
        */

      case 'customers':
        return MaterialPageRoute(
          builder: (_) => CustomerListPage(),
        );

      case 'customer_delete':
        return MaterialPageRoute(
          builder: (_) => CustomerListPage(),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('En desarrollo'),
        ),
        body: Center(
          child: Text('Pronto disponible'),
        ),
      );
    });
  }
}
