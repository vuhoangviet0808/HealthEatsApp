import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/auth_remote_ds.dart';
import '../../data/repositories/auth_repo_impl.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/login_form.dart';
import '../../../../core/api/api_client.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context){
    final client   = ApiClient();
    final remote   = AuthRemoteDS(client);
    final repo     = AuthRepoImpl(remote);
    final bloc     = AuthBloc(LoginUC(repo), RegisterUC(repo));
    return BlocProvider(
      create: (_)=>bloc,
      child:  Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: LoginForm(),
        ),
      ),
    );
  }
}
