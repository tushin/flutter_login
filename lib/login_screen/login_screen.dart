import 'package:flutter/material.dart';
import 'package:flutter_login/widgets/video_bg.dart';
import 'package:provider/provider.dart';

import 'login_button.dart';
import 'login_header.dart';
import 'login_input.dart';
import 'login_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Scaffold(
        body: Stack(
          children: const [
            VideoBG(asset: 'assets/video/rain.mp4', opacity: 0.2),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loginViewModel = Provider.of<LoginViewModel>(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Spacer(),
            const LoginHeader(),
            const Spacer(),
            LoginInput(
              icon: Icons.account_circle,
              hint: 'Username',
              enabled: !loginViewModel.inProgress,
              controller: loginViewModel.idController,
            ),
            const SizedBox(height: 8),
            LoginInput(
              icon: Icons.password,
              hint: 'Password',
              obscureText: true,
              enabled: !loginViewModel.inProgress,
              controller: loginViewModel.passwordController,
            ),
            const SizedBox(height: 12),
            LoginButton(
              onSuccess: () {
                showLoginDialog(context, true);
              },
              onFailure: () {
                showLoginDialog(context, false);
              },
            ),
            const SizedBox(height: 12),
            const Spacer(),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50),
              ),
              child: const Text('Create an account.'),
            ),
          ],
        ),
      ),
    );
  }

  void showLoginDialog(BuildContext context, bool success) {
    showDialog(
      context: context,
      builder: (context) {
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
      },
    );
  }
}
