import 'package:crypto_fate/controllers/crud_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/crud_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserController>(create: (_) => UserController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CryptoScreen(),
      ),
    );
  }
}
