import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart'; import '../bloc/auth_event.dart'; import '../bloc/auth_state.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../pages/register_page.dart';
// import 'register_form.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override _LoginFormState createState()=>_LoginFormState();
}
class _LoginFormState extends State<LoginForm>{
  final _emailC=TextEditingController(); final _pwC=TextEditingController();
  @override Widget build(BuildContext ctx){
    return BlocConsumer<AuthBloc,AuthState>(
      listener: (c,s){
        if(s is AuthFailure){
          ScaffoldMessenger.of(c).showSnackBar(SnackBar(content: Text(s.msg)));
        }else if(s is AuthSuccess){
          Navigator.pushReplacement(c,MaterialPageRoute(builder:(_)=> const HomePage()));
        }
      },
      builder:(c,s)=>Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children:[
          Text("Welcome back!",style:Theme.of(ctx).textTheme.headlineMedium),
          const SizedBox(height:10),
          Text("Please login to continue",style:Theme.of(ctx).textTheme.bodyMedium),
          TextField(controller:_emailC,decoration:const InputDecoration(labelText:'Email')),
          const SizedBox(height:10),
          TextField(controller:_pwC,decoration:const InputDecoration(labelText:'Password'),obscureText:true),
          const SizedBox(height:20),
          if(s is AuthLoading) const CircularProgressIndicator()
          else ElevatedButton(onPressed:(){
            ctx.read<AuthBloc>().add(LoginEvent(_emailC.text,_pwC.text));
          },child:const Text('Login')),
          TextButton(
              onPressed:()=>Navigator.push(ctx,MaterialPageRoute(builder:(_)=>const RegisterPage())),
              child:const Text("Don't have an account? Register here"))
        ]));
  }
}