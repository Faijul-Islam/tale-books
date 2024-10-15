// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tale_book/common_widget/text_styles.dart';

class CommonButton extends StatelessWidget {
  CommonButton({Key? key, required this.buttonText, required this.onTap})
      : super(key: key);
  String buttonText;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          width: 344.w,
          height: 50.h,
          padding: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
            color: const Color(0xFF1B3D79),
            borderRadius: BorderRadius.circular(33.r),
            //border: Border.all(width: .3, color: Theme.of(context).focusColor),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                offset: const Offset(
                  0.4,
                  0.4,
                ),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              )
            ],
          ),
          child: Center(
            child: Text(
              buttonText,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.boldText(
                18.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
