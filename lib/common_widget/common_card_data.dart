

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tale_book/common_widget/text_styles.dart';
/// this class refers a custom Card data  widget
/// it is a common card data pattern used in all cards
/// it takes a [title] and a [value] for an item

class CommonCardData extends StatelessWidget {
  final String title, value;
  const CommonCardData(
      {Key? key,required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h,left:0.w,right: 2.w,top: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: CustomTextStyles.mediumText(12.sp,color: Colors.grey),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              ":",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}
