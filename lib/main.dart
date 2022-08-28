import 'package:flutter/material.dart';

import 'router/r_delegate.dart';
import 'router/r_parser.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    
    final delegate = ShoppingRouterDelegate();
    final parser = ShoppingParser();

    
    return MaterialApp.router(
      title: 'Navigator Examples',
      routeInformationParser: parser,
      routerDelegate: delegate,
    );
  }
}