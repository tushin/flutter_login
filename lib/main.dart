import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'color_schemes.g.dart';

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

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/images/login_bg.jpg",
              fit: BoxFit.cover,
            ),
          ),
          const LoginForm(),
        ],
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key,});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),
              const Text(
                'Lorem Ipsum',
                style: TextStyle(fontSize: 40, fontFamily: 'Woodshop'),
              ),
              const Spacer(),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.account_circle),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(35.0),
                    ),
                  ),
                  hintText: "User name",
                  hintStyle: TextStyle(fontSize: 14),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(35.0),
                    ),
                  ),
                  hintText: "Password",
                  hintStyle: TextStyle(fontSize: 14),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: const BorderSide(width: 1),
                      ),
                      child: const Text("Login"),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text('Create an account.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class LoginViewModel extends ChangeNotifier {

}

