import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameC   = TextEditingController();
  final _emailC  = TextEditingController();
  final _pwC     = TextEditingController();

  bool _validEmail(String e) =>
      RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$').hasMatch(e);

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
                ScaffoldMessenger.of(ctx).showSnackBar(
                    const SnackBar(content: Text('Registration successful!')));
                Navigator.pushAndRemoveUntil(
                    ctx,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (_) => false);
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
                    Text('Create account',
                        style: Theme.of(ctx).textTheme.headlineLarge),
                    gap,
                    TextFormField(
                      controller: _nameC,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (v) =>
                          (v?.isEmpty ?? true) ? 'Required' : null,
                    ),
                    gap,
                    TextFormField(
                      controller: _emailC,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (v) =>
                          _validEmail(v ?? '') ? null : 'Invalid email',
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
                                ctx.read<AuthBloc>().add(RegisterEvent(
                                    _nameC.text, _emailC.text, _pwC.text));
                              }
                            },
                      child: loading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                  strokeWidth: 3, color: Colors.white),
                            )
                          : const Text('Register'),
                    ),
                    TextButton(
                      onPressed: loading ? null : () => Navigator.pop(context),
                      child: const Text('Already have an account? Login'),
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
