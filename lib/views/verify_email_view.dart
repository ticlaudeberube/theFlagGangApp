import 'package:flutter/material.dart';
import 'package:theflaggangapp/constants/routes.dart';
import 'package:theflaggangapp/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          const Text(
              "We've sent you an email verification. Please open it to verify your email."),
          const Text(
              "If you haven't received the email, press the button below to resend it."),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            },
            child: const Text('Send Verification Email'),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              }
            },
            child: const Text('Restart'),
          )
        ],
      ),
    );
  }
}
