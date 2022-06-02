import 'dart:convert';
import 'dart:async';

import 'package:restaurantappp_sub2/data dan api/respn/resto_detail_rspn.dart';
import 'package:restaurantappp_sub2/data dan api/respn/resto_list_rspn.dart';
import 'package:restaurantappp_sub2/data dan api/respn/resto_list_pencarian.dart';
import 'package:http/http.dart' as http;

class Api {
  static const _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const _endpointList = 'list';

  ///get lost restaurant
  Future<RestoListRspn> getTopHeadLines() async{
    final response = await http.get(Uri.parse(_baseUrl + _endpointList));
    try{
      if(response.statusCode == 200){
        return RestoListRspn.fromJson(json.decode(response.body));
      }else{
        throw Exception('Failed to load top headlines');
      }
    }catch(e){
      rethrow;
    }
  }

  ///get search
  Future<RestoListPencarian> getSearch(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + 'search?q=$query')).timeout(const Duration(seconds: 5));
    try{
      if(response.statusCode == 200){
        return RestoListPencarian.fromJson(json.decode(response.body));
      }else{
        throw Exception('Failed to load result search.');
      }
    } on Error {
      rethrow;
    }
  }

  Future<RestoDetailRspn> getDetails(String id) async{
    final response = await http.get(Uri.parse(_baseUrl + 'detail/$id')).timeout((const Duration(seconds: 5)));
    try{
      if(response.statusCode == 200){
        return RestoDetailRspn.fromJson(json.decode(response.body));
      }else{
        throw Exception('Failed to load details.');
      }
    }on Error {
      rethrow;
    }
  }
}