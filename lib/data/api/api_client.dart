import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:qik_food/defaults/app_constrains.dart';

class Apiclient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;

  late Map<String, String> _mainHeaders;

  Apiclient({required this.appBaseUrl}){
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token = AppConstants.TOKEN;

    _mainHeaders={
      'Content-type' :'application/json; charset=UTF-8',
      'Authorisation': 'Bearer $token',

    };
  }
  Future<Response> getData(String uri,) async {
    try{
      Response response = await get(uri);
      return response;
    }catch(e){
      return Response(statusCode: 1,statusText: e.toString());
    }
  }
}