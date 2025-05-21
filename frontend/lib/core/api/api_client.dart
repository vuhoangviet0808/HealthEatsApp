import 'dart:convert';
import 'package:http/http.dart' as http;

/// Trả về bản ghi (record) có `status` và `data`
///   • status : mã HTTP
///   • data   : Map<String,dynamic> (luôn là Map, rỗng nếu server trả List/null)
class ApiClient {
  static const _jsonHeader = {'Content-Type': 'application/json'};

  Future<({Map<String, dynamic> data, int status})> post(
      String url, Map<String, dynamic> body) async {
    final res = await http.post(
      Uri.parse(url),
      headers: _jsonHeader,
      body: jsonEncode(body),
    );

    Map<String, dynamic> map;
    try {
      final decoded = jsonDecode(res.body);
      map = decoded is Map<String, dynamic> ? decoded : <String, dynamic>{};
    } catch (_) {
      map = <String, dynamic>{};
    }

    return (status: res.statusCode, data: map);
  }

  // TODO: thêm get/put/delete khi cần
}
