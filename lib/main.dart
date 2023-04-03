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
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Scaffold(
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
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<LoginViewModel>(context);
    return Center(
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
              controller: viewModel._idController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.account_circle),
                suffixIcon: viewModel.id.isNotEmpty
                    ? IconButton(
                        onPressed: () => viewModel._idController.clear(),
                        icon: const Icon(Icons.clear))
                    : null,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(35.0),
                  ),
                ),
                hintText: "User name",
                hintStyle: const TextStyle(fontSize: 14),
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: viewModel._passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.password),
                suffixIcon: viewModel.password.isNotEmpty
                    ? IconButton(
                    onPressed: () => viewModel._passwordController.clear(),
                    icon: const Icon(Icons.clear))
                    : null,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(35.0),
                  ),
                ),
                hintText: "Password",
                hintStyle: const TextStyle(fontSize: 14),
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: (viewModel.id.isNotEmpty && viewModel.password.isNotEmpty)
                        ? () => viewModel.login()
                        : null,
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
    );
  }
}

class LoginViewModel extends ChangeNotifier {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String id = "";
  String password = "";

  LoginViewModel() {
    _idController.addListener(() {
      id = _idController.text;
      notifyListeners();
    });
    _passwordController.addListener(() {
      password = _passwordController.text;
      notifyListeners();
    });
  }

  void login() {

  }
}
