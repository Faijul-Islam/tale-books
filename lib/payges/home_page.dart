import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tale_book/common_widget/text_styles.dart';
import 'package:tale_book/payges/scroll_test.dart';
import 'package:tale_book/payges/total_calculation.dart';
import 'dart:math' as m;
import 'cost_entry.dart';
import 'customer_list_page.dart';
import 'genarale_user_add_page.dart';
import 'mesegees_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  checkConnection()async{
    // final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult.contains(ConnectivityResult.mobile)) {}
    // else if (connectivityResult.contains(ConnectivityResult.wifi)) {}
    // else if (connectivityResult.contains(ConnectivityResult.ethernet)) {}
    // else if (connectivityResult.contains(ConnectivityResult.vpn)) {}
    // else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {}
    // else if (connectivityResult.contains(ConnectivityResult.other)) {}
    // else if (connectivityResult.contains(ConnectivityResult.none)) {}
  }




  Duration _timeRemaining = const Duration(seconds: 0);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _getTimeRemaining();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _getTimeRemaining() {
    final now = DateTime.now();
    final eightAm = DateTime(now.year, now.month, now.day, 11, 30);
    final sevenAm = DateTime(now.year, now.month, now.day, 10, 20);

    if (now.isBefore(eightAm)) {
      _timeRemaining = eightAm.difference(now);
    } else if (now.isAfter(sevenAm) && now.isBefore(eightAm)) {
      // Handle scenario where current time is between 7:00 AM and 8:00 AM
      _timeRemaining = Duration(seconds: 0); // Already within work hours
    } else {
      // Reset for the next day if it's past 8:00 AM
      _timeRemaining = Duration(hours: 24 - now.hour, minutes: 60 - now.minute);
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(
        Duration(seconds: 1),
        (_) => setState(() {
              _getTimeRemaining();
            }));
  }

  @override
  Widget build(BuildContext context) {
    final String formattedTime =
        '${_timeRemaining.inHours.toString().padLeft(2, '0')}:${(_timeRemaining.inMinutes % 60).toString().padLeft(2, '0')}:${(_timeRemaining.inSeconds % 60).toString().padLeft(2, '0')}';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF1B3D79),
        title: Text(
          "TaleBook",
          style: CustomTextStyles.boldText(22.sp, color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              commonMenu(() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const UserEntryPage()));
              }, "Customer add(গ্রাহক যোগ করুন)"),
              commonMenu(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const CustomerListPage()));
              }, "Customer List(গ্রাহক তালিকা"),
            ],
          ),
          Row(
            children: [
              commonMenu(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const TotalCalculation()));
              }, "Total love&lose"),
              commonMenu(() {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ChatScreen()));
              }, "customer coating"),
            ],
          ),
          Row(
            children: [
              commonMenu(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>  ChatList()));
              }, "Cat App"),
              commonMenu(() {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => CostEntry()));
              }, "Cost Entry"),

            ],
          ),
          Row(
            children: [
              commonMenu(()async {
                checkConnection();
              }, "Cat App"),
              commonMenu(() {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const ScrollTest()));
              }, "test"),

            ],
          ),
        ],
      ),
    );
  }

  commonMenu(VoidCallback onTap, String mName) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(8.sp),
        padding: EdgeInsets.all(12.sp),
        // height: 92.h,
        width: 164.w,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              offset: const Offset(
                1.0,
                1.0,
              ),
              blurRadius: 1.0,
              spreadRadius: 0.0,
            )
          ],
          color: const Color(0xFF1B3D79).withOpacity(.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              mName,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}

///Flutter Folks
///Created by: Md. Abdur Rouf
///Created at: Sep 4, 2021

class AnimatedButton extends StatefulWidget {
  final VoidCallback? onComplete;
  const AnimatedButton({Key? key, this.onComplete}) : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    //Init the animation and it's event handler
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete?.call();
          controller.reset();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onLongPressStart(LongPressStartDetails details) {
    controller.reset();
    controller.forward();
  }

  void _onLongPressEnd(LongPressEndDetails details) {
    controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.4,
      child: ClipRRect(
        child: GestureDetector(
          onLongPressStart: _onLongPressStart,
          onLongPressEnd: _onLongPressEnd,
          child: AnimatedBuilder(
              animation: controller,
              builder: (context, snapshot) {
                return SizedBox(
                  height: 100,
                  child: CustomPaint(
                    painter: ArcShapePainter(
                      progress: animation.value,
                      radius: MediaQuery.of(context).size.width,
                      color: Colors.pink,
                      strokeWidth: 6,
                    ),
                    //Logo and text
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //Logo
                        Image.asset(
                          "assets/bkash_logo.png",
                          color: Colors.white,
                          height: 72,
                          width: 72,
                        ),
                        //Text
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Tap and hold to confirm",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

//Arc shape painter
class ArcShapePainter extends CustomPainter {
  //Define constructor parameters
  late double progress;
  late double radius;
  late Color color;
  late double strokeWidth;

  //Define private variables
  late Paint _linePaint;
  late Paint _solidPaint;
  late Path _path;

  //Create constructor and initialize private variables
  ArcShapePainter(
      {required this.color,
      this.progress = .5,
      this.radius = 400,
      this.strokeWidth = 4}) {
    _linePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    _solidPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //First define the cord length and bound the angle
    var cordLength = size.width + 4;
    if (radius <= (cordLength * .2) + 6) radius = (cordLength * .2) + 6;
    if (radius >= 600) radius = 600;

    //Define required angles
    var arcAngle = m.asin((cordLength * .5) / radius) * 2;
    var startAngle = (m.pi + m.pi * .5) - (arcAngle * .5);
    var progressAngle = arcAngle * progress;

    //Define center of the available screen
    Offset center = Offset((cordLength * .5) - 2, radius + 8);

    //Draw the line arc
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        progressAngle, false, _linePaint);

    //Draw the solid arc path
    _path = Path();
    _path.arcTo(Rect.fromCircle(center: center, radius: radius), startAngle,
        arcAngle, true);
    _path.lineTo(size.width, size.height);
    _path.lineTo(0, size.height);
    _path.close();

    //Draw some shadow over the solid arc
    canvas.drawShadow(_path.shift(Offset(0, 1)), color.withAlpha(100), 3, true);

    //Draw the solid arc using path
    canvas.drawPath(_path.shift(Offset(0, 12)), _solidPaint);
  }

  @override
  bool hitTest(Offset position) {
    //Accept long pressing only for the solid arc
    return _path.contains(position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Make it conditionally return for release build
    // For now I am making always true
    return true;
  }
}