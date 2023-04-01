import 'package:flutter/material.dart';

import 'color_schemes.g.dart';
import 'login_screen/login_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Video Demo',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const LoginScreen(),
    );
  }
}

//VideoBG(asset: 'assets/video/rain.mp4'),
