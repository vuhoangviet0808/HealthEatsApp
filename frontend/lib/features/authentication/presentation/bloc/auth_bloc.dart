import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart'; import 'auth_state.dart';
import '../../domain/usecases/login.dart'; import '../../domain/usecases/register.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  final LoginUC loginUC; final RegisterUC regUC;
  AuthBloc(this.loginUC, this.regUC):super(AuthInitial()){
    on<LoginEvent>((e,emit)async{
      emit(AuthLoading());
      final res = await loginUC(e.email,e.pw);
      res.fold((l)=>emit(AuthFailure(l)), (r)=>emit(AuthSuccess()));
    });
    on<RegisterEvent>((e,emit)async{
      emit(AuthLoading());
      final r = await regUC(e.name,e.email,e.pw);
      r.fold((l)=>emit(AuthFailure(l)), (_)=>emit(AuthSuccess()));
    });
  }
}
