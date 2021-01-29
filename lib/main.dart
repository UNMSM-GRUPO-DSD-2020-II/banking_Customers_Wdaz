import 'package:banking_app/src/routers/RouterPage.router.dart';
import 'package:banking_app/src/states/contador.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => new ContadorState(),
          )
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'App',
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', 'US'), // English
              const Locale('es', 'ES'),
            ],
            initialRoute: '/',
            onGenerateRoute: RouterPage.generateRoute));
  }
}
