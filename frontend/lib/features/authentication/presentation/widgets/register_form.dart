import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../../home/presentation/pages/home_page.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _nameC  = TextEditingController();
  final _emailC = TextEditingController();
  final _pwC    = TextEditingController();

  bool _isValidEmail(String e) =>
      RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$').hasMatch(e);
  bool _isValidPw(String p) => p.length >= 6;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (ctx, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(ctx)
              .showSnackBar(SnackBar(content: Text(state.msg)));
        } else if (state is AuthSuccess) {
          ScaffoldMessenger.of(ctx)
              .showSnackBar(const SnackBar(content: Text('Registration success')));
          Navigator.pushAndRemoveUntil(
              ctx,
              MaterialPageRoute(builder: (_) => const HomePage()),
              (_) => false);
        }
      },
      builder: (ctx, state) {
        final loading = state is AuthLoading;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sign up', style: Theme.of(ctx).textTheme.headlineMedium),
            const SizedBox(height: 10),
            TextField(
              controller: _nameC,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailC,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _pwC,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password (min 6)'),
            ),
            const SizedBox(height: 20),
            loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      final email = _emailC.text.trim();
                      final pw   = _pwC.text.trim();
                      final name = _nameC.text.trim();

                      if (name.isEmpty ||
                          !_isValidEmail(email) ||
                          !_isValidPw(pw)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invalid input')));
                        return;
                      }
                      context
                          .read<AuthBloc>()
                          .add(RegisterEvent(name, email, pw));
                    },
                    child: const Text('Register'),
                  ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Already have an account? Login here'),
            ),
          ],
        );
      },
    );
  }
}
