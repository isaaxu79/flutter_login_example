import 'dart:convert';
import 'package:http/http.dart' as http;

class URLS{
  static const String BASE_URL = 'http://192.168.0.14:3333';
}

class ApiService {
  static Future<bool> login(body) async {
    final response = await http.post('${URLS.BASE_URL}/login', body: body);
    if (response.statusCode == 200){
      return true;
    }else{
      return false;
    }

  }
}