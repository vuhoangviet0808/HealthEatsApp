import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_client.dart';
import '../../../../../core/constants/endpoints.dart';
import '../models/user_model.dart';

class AuthRemoteDS {
  final ApiClient _client;
  const AuthRemoteDS(this._client);

  Future<Either<String, UserModel>> login(String email, String pw) async {
    final res = await _client.post(loginUrl, {'email': email, 'password': pw});
    if (res.status == 200) {
      return right(UserModel.fromJson(res.data));
    }
    return left(res.data['message'] ?? 'Login failed');
  }

  Future<Either<String, void>> register(
      String name, String email, String pw) async {
    final r =
        await _client.post(registerUrl, {'username': name, 'email': email, 'password': pw});
    if (r.status == 201) return right(null);
    return left(r.data['message'] ?? 'Register failed');
  }
}
