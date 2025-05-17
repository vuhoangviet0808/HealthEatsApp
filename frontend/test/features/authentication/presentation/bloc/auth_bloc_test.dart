// ignore_for_file: avoid_redundant_argument_values
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:frontend/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:frontend/features/authentication/presentation/bloc/auth_event.dart';
import 'package:frontend/features/authentication/presentation/bloc/auth_state.dart';
import 'package:frontend/features/authentication/domain/usecases/login.dart';
import 'package:frontend/features/authentication/domain/usecases/register.dart';
import 'package:frontend/features/authentication/domain/entities/user.dart';

/// Tạo mock cho 2 use-case
@GenerateMocks([LoginUC, RegisterUC])
import 'auth_bloc_test.mocks.dart';

void main() {
  late MockLoginUC mockLogin;
  late MockRegisterUC mockRegister;

  const u = User(username: 'alice', email: 'alice@mail.com');

  setUp(() {
    mockLogin    = MockLoginUC();
    mockRegister = MockRegisterUC();
  });

  group('AuthBloc-Login', () {
    blocTest<AuthBloc, AuthState>(
      '→ emits [Loading, Success] khi login thành công',
      build: () {
        when(mockLogin.call('alice@mail.com', '123'))
            .thenAnswer((_) async => right(u));
        return AuthBloc(mockLogin, mockRegister);
      },
      act: (bloc) => bloc.add(const LoginEvent('alice@mail.com', '123')),
      expect: () => [                           // <─ SỬA
        isA<AuthLoading>(),
        isA<AuthSuccess>(),
      ],
      verify: (_) {
        verify(mockLogin.call('alice@mail.com', '123')).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      '→ emits [Loading, Failure] khi login sai mật khẩu',
      build: () {
        when(mockLogin.call(any, any))
            .thenAnswer((_) async => left('Invalid credentials'));
        return AuthBloc(mockLogin, mockRegister);
      },
      act: (bloc) => bloc.add(const LoginEvent('a@mail.com', 'wrong')),
      expect: () => <Matcher>[
        isA<AuthLoading>(),
        predicate<AuthFailure>((f) => f.msg == 'Invalid credentials'),
      ],
    );
  });

  group('AuthBloc-Register', () {
    blocTest<AuthBloc, AuthState>(
      '→ emits [Loading, Success] khi register OK',
      build: () {
        when(mockRegister.call('bob', 'bob@mail.com', '123456'))
            .thenAnswer((_) async => right(null));
        return AuthBloc(mockLogin, mockRegister);
      },
      act: (bloc) =>
          bloc.add(const RegisterEvent('bob', 'bob@mail.com', '123456')),
       expect: () => [
         isA<AuthLoading>(),           // ← dùng matcher mới
         isA<AuthSuccess>(),
        ],
      verify: (_) {
        verify(mockRegister.call('bob', 'bob@mail.com', '123456')).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      '→ emits [Loading, Failure] khi email đã tồn tại',
      build: () {
        when(mockRegister.call(any, any, any))
            .thenAnswer((_) async => left('Email exists'));
        return AuthBloc(mockLogin, mockRegister);
      },
      act: (bloc) =>
          bloc.add(const RegisterEvent('bob', 'dup@mail.com', '123456')),
      expect: () => <Matcher>[
        isA<AuthLoading>(),
        predicate<AuthFailure>((f) => f.msg == 'Email exists'),
      ],
    );
  });
}
