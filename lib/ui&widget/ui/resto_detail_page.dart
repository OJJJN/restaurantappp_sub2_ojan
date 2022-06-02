import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantappp_sub2/data dan api/panggil makanan dll/drink.dart';
import 'package:restaurantappp_sub2/data dan api/panggil makanan dll/food.dart';
import 'package:restaurantappp_sub2/data dan api/panggil makanan dll/resto.dart';
import 'package:restaurantappp_sub2/data dan api/respn/resto_detail_rspn.dart';
import 'package:restaurantappp_sub2/provider/resto_detail_provider.dart';
import 'package:restaurantappp_sub2/cons/resultstate.dart';
import 'package:restaurantappp_sub2/ui&widget/widget/plat_widget.dart';

class RestoDetailPage extends StatefulWidget {
  static const routeName = '/detail_page';
  final String restaurant;
  const RestoDetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<RestoDetailPage> createState() => _RestoDetailPageState();
}

class _RestoDetailPageState extends State<RestoDetailPage> {

  @override
  void initState() {
    Future.microtask(() {
      RestoDetailProvider provider = Provider.of<RestoDetailProvider>(
        context,
        listen: false,
      );
      provider.getDetails(widget.restaurant);
    });
    super.initState();
  }


  Widget _buildDetails(BuildContext context){
    return Scaffold(
        body: Consumer<RestoDetailProvider>(
          builder: (context, provider, _) {
            ResultState<RestoDetailRspn> state = provider.state;
            switch (state.status) {
              case Status.loading:
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Loading'),
                  ),
                  body: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case Status.error:
                return Scaffold(
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(
                        16.0,
                      ),
                      child: Text(
                        state.message!,
                      ),
                    ),
                  ),
                );
              case Status.hasData:
                {
                  Restaurant restaurant = state.data!.restaurant;
                  return Scaffold(
                    body: NestedScrollView(
                      headerSliverBuilder: (context, isScroller) {
                        return [
                          SliverAppBar(
                            pinned: true,
                            expandedHeight: 200,
                            iconTheme: const IconThemeData(
                              color: Colors.white,
                            ),
                            flexibleSpace: FlexibleSpaceBar(
                              background: Hero(
                                tag: restaurant.id,
                                child: Image.network(
                                  restaurant.mediumPictureUrl,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              title: Text(
                                restaurant.name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              centerTitle: true,
                              titlePadding: const EdgeInsets.only(
                                bottom: 16.0,
                              ),
                            ),
                          ),
                        ];
                      },
                      body: ListView(
                        padding: const EdgeInsets.all(8.0,),
                        children: [
                          Text(restaurant.description),
                          const Divider(height: 12.0, color: Colors.grey,),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined),
                              Text('${restaurant.address}, '),
                              Text(restaurant.city),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star_border),
                              Text(restaurant.rating.toString()),
                            ],
                          ),
                          const Divider(
                            height: 12.0,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Foods'),
                                _buildFoodMenu(context, restaurant.menus.foods),
                                const Divider(
                                  height: 12.0,
                                  color: Colors.grey,
                                ),
                                const Text('Drinks'),
                                _buildDrinkMenu(context, restaurant.menus.drinks),
                                const Divider(
                                  height: 12.0,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
            }
          },
        )
    );
  }

  Widget _buildFoodMenu(BuildContext context, List<Food> foods){
    return Column(
      children: [
        const SizedBox(height: 8,),
        SizedBox(height: 65,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: foods.length,
              itemBuilder: (context, index){
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(foods[index].name)
                      ],
                    ),
                  ),
                );
              }
          ),
        )
      ],
    );
  }

  Widget _buildDrinkMenu(BuildContext context, List<Drink> drinks){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8,),
        SizedBox(height: 65,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: drinks.length,
              itemBuilder: (context, index){
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(drinks[index].name)
                      ],
                    ),
                  ),
                );
              }
          ),
        )
      ],
    );
  }

  Widget _buildAndroid(BuildContext context){
    return _buildDetails(context);

  }

  Widget _buildIos(BuildContext context){
    return _buildDetails(context);
  }

  @override
  Widget build(BuildContext context) {
    return PlatWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
