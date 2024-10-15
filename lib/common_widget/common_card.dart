import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CommonCard extends StatelessWidget {
  final Widget widget;
  const CommonCard({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.w,right:10.w,top: 12.h,bottom:12.h),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1B3D79).withOpacity(.1),
        // border: Border.all(
        //   width: 1.w,
        //   color: Colors.grey.withOpacity(.2),
        // ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            offset: const Offset(
              0.4,
              0.4,
            ),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          )
        ],
      ),
      child: widget,
    );
  }
}
