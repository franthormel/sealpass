import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/provider.dart';
import 'screens/security.dart';
import 'theme.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AccountsModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final theme = themeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      initialRoute: '/',
      routes: {
        '/': (context) => SecurityScreen(),
      },
    );
  }
}
