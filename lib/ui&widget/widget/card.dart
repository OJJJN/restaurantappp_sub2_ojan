import 'package:flutter/material.dart';
import 'package:restaurantappp_sub2/data dan api/panggil makanan dll/resto.dart';
import 'package:restaurantappp_sub2/common/navigation.dart';
import 'package:restaurantappp_sub2/ui&widget/ui/resto_detail_page.dart';

class CardCs extends StatefulWidget {
  final List<Restaurant> restaurant;
  const CardCs({Key? key, required this.restaurant}) : super(key: key);

  @override
  _CardCsState createState() => _CardCsState();
}

class _CardCsState extends State<CardCs> {

  Widget _buildItemList(BuildContext context , Restaurant restaurant){
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Hero(
        tag: restaurant.id,
        child: Image.network(restaurant.mediumPictureUrl),
      ),
      onTap: () => {
        Navigation.intentWithData(RestoDetailPage.routeName, restaurant.id),
      },
      title: Text(restaurant.name, overflow: TextOverflow.ellipsis,),
      subtitle: Column(
        children: [
          Row(
            children: [
              Text(restaurant.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
            ],
          ),
          Row(
            children: [
              Text(restaurant.city)
            ],
          ),
          Row(
            children: [
              Text(restaurant.rating.toString()),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.restaurant.length,
      separatorBuilder: (context, index){
        return const Divider(height: 2, color: Colors.grey,);
      },
      itemBuilder: (context, index){
        Restaurant restaurant = widget.restaurant[index];
        return _buildItemList(context, restaurant);
      },
    );
  }
}