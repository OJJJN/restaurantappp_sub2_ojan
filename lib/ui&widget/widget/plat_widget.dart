import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class PlatWidget extends StatelessWidget {
  final WidgetBuilder androidBuilder;
  final WidgetBuilder iosBuilder;
  const PlatWidget({Key? key, required this.androidBuilder, required this.iosBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(defaultTargetPlatform){
      case TargetPlatform.android:
        return androidBuilder(context);
      case TargetPlatform.iOS:
        return iosBuilder(context);
      default:
        return iosBuilder(context);
    }
  }
}
