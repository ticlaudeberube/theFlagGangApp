import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:theflaggangapp/constants/routes.dart';
import 'package:theflaggangapp/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Sign in'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration:
                const InputDecoration(hintText: 'Enter your email here'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration:
                const InputDecoration(hintText: 'Enter your  password here'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email, password: password);

                final user = FirebaseAuth.instance.currentUser;
                if (user?.emailVerified ?? false) {
                  if (context.mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      notesRoute,
                      (route) => false,
                    );
                  }
                } else {
                  if (context.mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyEmailRoute,
                      (_) => false,
                    );
                  }
                }
              } on FirebaseAuthException catch (e) {
                if (context.mounted) {
                  switch (e.code) {
                    case 'user-not-found':
                      await showErrorDialog(context, 'No user found.');
                      break;
                    case 'wrong-password':
                      await showErrorDialog(context, 'Wrong crecentials.');
                      break;
                    default:
                      await showErrorDialog(context, 'Error: ${e.code}');
                  }
                }
              } catch (e) {
                if (context.mounted) {
                  await showErrorDialog(context, e.toString());
                }
              }
            },
            child: const Text('Sign in'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              child: const Text('Not regidtered yet? Register here'))
        ],
      ),
    );
  }
}
