import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:restaurantappp_sub2/common/navigation.dart';
import 'package:restaurantappp_sub2/common/styles.dart';
import 'package:restaurantappp_sub2/data dan api/api/api.dart';
import 'package:restaurantappp_sub2/provider/resto_detail_provider.dart';
import 'package:restaurantappp_sub2/provider/resto_provider.dart';
import 'package:restaurantappp_sub2/provider/resto_pencarian_provider.dart';
import 'package:restaurantappp_sub2/ui&widget/ui/home_page.dart';
import 'package:restaurantappp_sub2/ui&widget/ui/resto_pencarian_page.dart';
import 'package:restaurantappp_sub2/ui&widget/ui/resto_detail_page.dart';
import 'package:restaurantappp_sub2/ui&widget/ui/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Api _api = Api();

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider<RestoProvider>(
          create: (_) => RestoProvider(api: _api)),
      ChangeNotifierProvider<RestoPencarianProvider>(
        create: (_) => RestoPencarianProvider(api: _api),
      ),
      ChangeNotifierProvider<RestoDetailProvider>(
          create: (_) =>
              RestoDetailProvider(api: _api)),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: myTextTheme,
          appBarTheme: AppBarTheme(titleTextStyle: myTextTheme.headline6)),
      navigatorKey: navigatorKey,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomePage.routeName: (context) => HomePage(),
        RestaurantSearch.routeName: (context) => const RestaurantSearch(),
        RestoDetailPage.routeName: (context) => RestoDetailPage(
          restaurant:
          ModalRoute.of(context)?.settings.arguments as String,
        ),
      },
    ),
  );
}