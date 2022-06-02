import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurantappp_sub2/data dan api/api/api.dart';
import 'package:restaurantappp_sub2/data dan api/respn/resto_list_rspn.dart';
import 'package:restaurantappp_sub2/cons/resultstate.dart';

class RestoProvider extends ChangeNotifier{
  final Api api;
  RestoProvider({required this.api}){
    _fetchAllRestaurant();
  }

  ResultState <RestoListRspn> _state = ResultState(status: Status.loading, message: null, data: null);

  ResultState<RestoListRspn> get state => _state;


  Future<dynamic> _fetchAllRestaurant() async{
    try{
      _state = ResultState(status: Status.loading, message: null, data: null);
      notifyListeners();
      final RestoListRspn restoListRspn = await api.getTopHeadLines();
      _state = ResultState(status: Status.hasData, message: null, data: restoListRspn);
      notifyListeners();
      return _state;
    }on TimeoutException{
      _state = ResultState(status: Status.error, message: 'Ga Ada Jaringan Nih!!, please try again!', data: null);
      notifyListeners();
      return _state;
    } on SocketException{
      _state = ResultState(status: Status.error, message: 'Kamu Ga Punya Internet!!, please check your internet!', data: null);
      notifyListeners();
      return _state;
    }on Error catch (e){
      _state = ResultState(status: Status.error, message: e.toString(), data: null);
      notifyListeners();
      return _state;
    }
  }
}
