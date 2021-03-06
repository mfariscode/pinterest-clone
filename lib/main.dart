import 'package:flutter/material.dart';
import 'package:pinterest_clone/provider/homescreen_provider.dart';
import 'package:provider/provider.dart';

import 'view/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const HomeScreen(),
    ),
     );
  }
}

