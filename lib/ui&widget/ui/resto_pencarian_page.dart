import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantappp_sub2/data dan api/panggil makanan dll/resto.dart';
import 'package:restaurantappp_sub2/data dan api/respn/resto_list_pencarian.dart';
import 'package:restaurantappp_sub2/provider/resto_pencarian_provider.dart';
import 'package:restaurantappp_sub2/cons/resultstate.dart';
import 'package:restaurantappp_sub2/ui&widget/widget/card.dart';
import 'package:restaurantappp_sub2/ui&widget/widget/plat_widget.dart';

class RestaurantSearch extends StatefulWidget {
  static const routeName = 'page_search';
  const RestaurantSearch({Key? key}) : super(key: key);

  @override
  _RestaurantSearchState createState() => _RestaurantSearchState();
}

class _RestaurantSearchState extends State<RestaurantSearch> {

  Widget _buildList(){
    Timer? _debounce;
    return Scaffold(
      appBar: AppBar(title: const Text('Cari Resto'),),
      body: Column(
        children: [
          Flexible(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                      label: Text('Cari Resto Disini!'),
                      hintText: 'Masukkan Nama Resto',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))
                      )
                  ),
                  onChanged: (text){
                    if(_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      if(text.isNotEmpty){
                        RestoPencarianProvider provider = Provider.of(context, listen: false);
                        provider.fetchSearchRestaurant(text);
                      }
                    });
                  },
                ),
              )
          ),
          Flexible(
              flex: 1,
              child: Consumer<RestoPencarianProvider>(
                builder: (context, provider, _){
                  ResultState<RestoListPencarian> state = provider.state;
                  switch (state.status){
                    case Status.loading:
                      return const Center(child: CircularProgressIndicator(),);
                    case Status.error:
                      return Center(child: Padding(padding: const EdgeInsets.all(16),
                        child: Text(state.message!),
                      ),);
                    case Status.hasData: {
                      {
                        List<Restaurant> restaurants = state.data!.restaurant;
                        if(restaurants.isEmpty){
                          return const Center(
                            child: Text('Yang Kamu Cari Ga Ada Nih !!'),
                          );
                        }else{
                          return CardCs(restaurant: restaurants);
                        }
                      }
                    }
                  }
                },
              )
          )
        ],
      ),
    );
  }

  Widget _buildIos(BuildContext context){
    return Scaffold(
      body: _buildList(),
    );
  }

  Widget _buildAndroid(BuildContext context){
    return Scaffold(
      body: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos
    );
  }
}