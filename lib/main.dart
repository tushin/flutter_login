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
    var enableLogin = viewModel.id.isNotEmpty && viewModel.password.isNotEmpty;
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
              enabled: !viewModel.inProgress,
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
              enabled: !viewModel.inProgress,
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
                    onPressed: (enableLogin && !viewModel.inProgress)
                        ? () async {
                            onSuccess() => showLoginDialog(context, true);
                            onFail() => showLoginDialog(context, false);

                            final success = await viewModel.login();
                            if (success) {
                              onSuccess();
                            } else {
                              onFail();
                            }
                          }
                        : null,
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: const BorderSide(width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 14),
                        const Text("Login"),
                        SizedBox(
                            width: 14,
                            height: 14,
                            child: viewModel.inProgress
                                ? const CircularProgressIndicator()
                                : null
                        )
                      ],
                    ),
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

  void showLoginDialog(BuildContext context, bool success) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            success ? const Text("Success") : const Text("Fail"),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("close"),
            ),
          ],
        ),
      );
    });
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

  bool inProgress = false;

  Future<bool> login() async {
    inProgress = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 3));
    inProgress = false;
    notifyListeners();

    return id == 'aaa' && password == 'aaa';
  }
}
