import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:restaurantappp_sub2/data dan api/api/api.dart';
import 'package:restaurantappp_sub2/data dan api/respn/resto_list_pencarian.dart';
import 'package:restaurantappp_sub2/cons/resultstate.dart';

class RestoPencarianProvider extends ChangeNotifier{
  final Api api;

  RestoPencarianProvider({required this.api});

  ResultState<RestoListPencarian> _state = ResultState(
      status: Status.hasData,
      message: null,
      data: RestoListPencarian(
        error: false,
        founded: 0,
        restaurant: [],
      )
  );

  ResultState<RestoListPencarian> get state => _state;


  Future<dynamic> fetchSearchRestaurant(String keyword) async{
    try{
      _state = ResultState(status: Status.loading, message: null, data: null);
      notifyListeners();
      final RestoListPencarian restoListPencarian = await api.getSearch(keyword);
      _state = ResultState(
          status: Status.hasData,
          message: null,
          data: restoListPencarian);
      notifyListeners();
      return _state;
    } on TimeoutException{
      _state = ResultState(status: Status.error, message: 'Request time out', data: null);
      notifyListeners();
      return _state;
    }on SocketException{
      _state = ResultState(status: Status.error, message: '', data: null);
      notifyListeners();
      return _state;
    } on Error catch (e){
      _state = ResultState(status: Status.error, message: e.toString(), data: null);
      notifyListeners();
      return _state;
    }
  }
}