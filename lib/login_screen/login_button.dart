import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_viewmodel.dart';


class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    this.onSuccess,
    this.onFailure,
  });

  final VoidCallback? onSuccess;
  final VoidCallback? onFailure;

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<LoginViewModel>(context);
    return Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed: viewModel.enableLogin && !viewModel.inProgress ? () async {
              var result = await viewModel.login();
              if (result) {
                onSuccess?.call();
              } else {
                onFailure?.call();
              }
            } : null,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // 라운드 모서리 반지름 값
              ),
              side: const BorderSide(width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
                children: [
                  if (viewModel.inProgress) const SizedBox(height: 12, width: 12),
                  const SizedBox(width: 12),
                  const Text('Sign in'),
                  const SizedBox(width: 12),
                  if (viewModel.inProgress) const SizedBox(height: 12, width: 12, child: CircularProgressIndicator()),
                ],
              )
          ),
        ),
      ],
    );
  }
}
