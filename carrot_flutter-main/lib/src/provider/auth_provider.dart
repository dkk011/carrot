import 'provider.dart';

class AuthProvider extends Provider {
  Future<Map> requestPhoneCode(String phone) async {
    final response = await post('/auth/phone', {'phone': phone});
    return response.body;
  }

  Future<Map> verifyPhoneNumber(String code) async {
    final response = await put('/auth/phone', {'code': code});
    return response.body;
  }

  Future<Map> login(String phone, String password) async {
    final response = await post('/auth/login', {
      'phone': phone,
      'password': password,
    });
    return response.body;
  }

  Future<Map> register(String phone, String password, String name,
      [int? profile]) async {
    final response = await post('/auth/register', {
      'phone': phone,
      'password': password,
      'name': name,
      'profile': profile,
    });
    return response.body;
  }
}
