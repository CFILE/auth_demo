import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class RestApi{

   Future request(String url,Map<String,dynamic>? data) async {
    String apiUrl="http://45.10.110.181:8080/api/v1/$url";
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "charset": "utf-8"
    };
    var body = json.encode(data);
    try{
      http.Response response= await http.post(Uri.parse(apiUrl), headers: requestHeaders,  body: body).timeout(const Duration(seconds: 20),onTimeout : () {
        return http.Response('Error', 408);
      });
      if(response.statusCode == 200) {
        return json.decode(utf8.decode(response.bodyBytes));
      }else{
        return null;
      }
    } on SocketException {
      return {"error":"no_connect"};
    }

  }


}