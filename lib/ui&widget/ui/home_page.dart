import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantappp_sub2/common/styles.dart';
import 'package:restaurantappp_sub2/data dan api/panggil makanan dll/resto.dart';
import 'package:restaurantappp_sub2/data dan api/respn/resto_list_rspn.dart';
import 'package:restaurantappp_sub2/provider/resto_provider.dart';
import 'package:restaurantappp_sub2/ui&widget/ui/resto_pencarian_page.dart';
import 'package:restaurantappp_sub2/cons/resultstate.dart';
import 'package:restaurantappp_sub2/ui&widget/widget/card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/restaurants';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant',),
        bottom: PreferredSize(
          child: Container(
            padding: const EdgeInsets.only(
              left: 14.0,
              bottom: 12.0,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              'Rekomendasi Resto Untuk Kamu!!',
              style: myTextTheme.subtitle2!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          preferredSize: const Size.fromHeight(10.0),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(
                context,
                RestaurantSearch.routeName,
              );
            },
          ),

        ],
      ),
      body: Consumer<RestoProvider>(
        builder: (context, provider, _) {
          ResultState<RestoListRspn> state = provider.state;
          switch (state.status) {
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.error:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(
                    16.0,
                  ),
                  child: Text(
                    state.message!,
                  ),
                ),
              );
            case Status.hasData:
              {
                List<Restaurant> restaurants = state.data!.restaurants;
                if (restaurants.isEmpty) {
                  return const Center(
                    child: Text('Resto Tidak Ada.'),
                  );
                } else {
                  return CardCs(restaurant: restaurants,
                  );
                }
              }
          }
        },
      ),
    );
  }
}