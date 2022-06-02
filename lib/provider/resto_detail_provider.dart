import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurantappp_sub2/data dan api/api/api.dart';
import 'package:restaurantappp_sub2/data dan api/respn/resto_detail_rspn.dart';
import 'package:restaurantappp_sub2/cons/resultstate.dart';

class RestoDetailProvider extends ChangeNotifier{
  final Api api;

  RestoDetailProvider({required this.api});

  ResultState<RestoDetailRspn> _state = ResultState(status: Status.loading, message: null, data: null);
  ResultState<RestoDetailRspn> get state => _state;

  Future<ResultState> getDetails(String id) async {
    try {
      _state = ResultState(status: Status.loading, message: null, data: null);
      notifyListeners();
      final RestoDetailRspn restoDetailRspn = await api.getDetails(id);
      _state = ResultState(status: Status.hasData, message: null, data: restoDetailRspn);
      notifyListeners();
      return _state;
    } on TimeoutException {
      _state = ResultState(
          status: Status.error, message: 'timeoutExceptionMessage', data: null);
      notifyListeners();
      return _state;
    } on SocketException {
      _state = ResultState(
          status: Status.error, message: 'socketExceptionMessage', data: null);
      notifyListeners();
      return _state;
    } on Error catch (e) {
      _state =
          ResultState(status: Status.error, message: e.toString(), data: null);
      notifyListeners();
      return _state;
    }
  }
}