import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:restaurantappp_sub2/ui&widget/ui/home_page.dart';

enum DotType{
  square, circle, diamond, icon
}

class SplashScreen extends StatefulWidget{
  static const String routeName = "/splashScreen";

  final Color dot1;
  final Color dot2;
  final Color dot3;
  final Duration duration;
  final DotType dotType;
  final Icon dotIcon;

  const SplashScreen({
    this.dot1 = Colors.grey,
    this.dot2 = Colors.grey,
    this.dot3 = Colors.grey,
    this.duration = const Duration(milliseconds: 1000),
    this.dotType = DotType.circle,
    this.dotIcon = const Icon(Icons.blur_on),
  });

  @override
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late Animation<double> animation_1;
  late Animation<double> animation_2;
  late Animation<double> animation_3;
  late AnimationController controller;

  startTime()async{
    var _duration = const Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  }

  @override
  void initState() {
    super.initState();
    startTime();
    controller = AnimationController(vsync: this, duration: widget.duration);
    animation_1 = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: controller, curve: const Interval(0.0, 0.70, curve: Curves.linear),));
    animation_2 = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: controller, curve: const Interval(0.1, 0.80, curve: Curves.linear),));
    animation_3 = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: controller, curve: const Interval(0.2, 0.90, curve: Curves.linear),));
    controller.addListener(() {
      setState(() {

      });
    });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.fastfood_rounded, size: 100,),
              const SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(opacity: (animation_1.value <= 0.4 ? 2.5 * animation_1.value : (animation_1.value > 0.40 && animation_1.value <= 0.60) ? 1.0 : 2.5 - (2.5 * animation_1.value)),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Dot(
                        radius: 10.0,
                        color: widget.dot1,
                        type: widget.dotType,
                        icon: widget.dotIcon,
                      ),
                    ),
                  ),
                  Opacity(opacity: (animation_2.value <= 0.4 ? 2.5 * animation_2.value : (animation_2.value > 0.40 && animation_2.value <= 0.60) ? 1.0 : 2.5 - (2.5 * animation_2.value)),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Dot(
                        radius: 10.0,
                        color: widget.dot2,
                        type: widget.dotType,
                        icon: widget.dotIcon,

                      ),
                    ),
                  ),
                  Opacity(opacity: (animation_3.value <= 0.4 ? 2.5 * animation_3.value : (animation_3.value > 0.40 && animation_3.value <= 0.60) ? 1.0 : 2.5 - (2.5 * animation_3.value)),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Dot(
                        radius: 10.0,
                        color: widget.dot3,
                        type: widget.dotType,
                        icon: widget.dotIcon,

                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}

class Dot extends StatelessWidget{
  final double? radius;
  final Color? color;
  final DotType? type;
  final Icon? icon;

  const Dot({this.radius, this.color, this.type, this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: type == DotType.icon ? Icon(icon!.icon, color: color, size: 1.3 * radius!,) : Transform.rotate(angle: type == DotType.diamond ? pi/4 : 0.0,
        child: Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(color: color, shape: type == DotType.circle? BoxShape.circle : BoxShape.rectangle),
        ),
      ),
    );
  }
}