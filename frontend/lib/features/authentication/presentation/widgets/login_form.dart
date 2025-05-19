import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../pages/register_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailC  = TextEditingController();
  final _pwC     = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 18);

    return Center(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (ctx, state) {
              if (state is AuthFailure) {
                ScaffoldMessenger.of(ctx).showSnackBar(
                    SnackBar(content: Text(state.msg)));
              } else if (state is AuthSuccess) {
                Navigator.pushReplacement(
                    ctx, MaterialPageRoute(builder: (_) => const HomePage()));
              }
            },
            builder: (ctx, state) {
              final loading = state is AuthLoading;
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Welcome back!',
                        style: Theme.of(ctx).textTheme.headlineLarge),
                    gap,
                    Text('Please login to continue',
                        style: Theme.of(ctx).textTheme.bodyMedium),
                    gap,
                    TextFormField(
                      controller: _emailC,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) =>
                          (v?.isEmpty ?? true) ? 'Required' : null,
                    ),
                    gap,
                    TextFormField(
                      controller: _pwC,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      obscureText: true,
                      validator: (v) =>
                          (v!.length < 6) ? 'Min 6 characters' : null,
                    ),
                    gap,
                    ElevatedButton(
                      onPressed: loading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                ctx
                                    .read<AuthBloc>()
                                    .add(LoginEvent(_emailC.text, _pwC.text));
                              }
                            },
                      child: loading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                  strokeWidth: 3, color: Colors.white),
                            )
                          : const Text('Login'),
                    ),
                    TextButton(
                      onPressed: loading
                          ? null
                          : () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const RegisterPage())),
                      child: const Text("Don't have an account? Register"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
