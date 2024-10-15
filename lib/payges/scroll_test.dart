import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tale_book/common_widget/commn_textfield.dart';

import '../common_widget/text_styles.dart';

class ScrollTest extends StatefulWidget {
  const ScrollTest({Key? key}) : super(key: key);

  @override
  State<ScrollTest> createState() => _ScrollTestState();
}

class _ScrollTestState extends State<ScrollTest> {
  final fabricKye=GlobalKey();
  final paymentKye=GlobalKey();
  void initState() {
    scroll();
    pScroll();
    super.initState();
  }
  scroll(){
    if (fabricKye.currentContext != null) {
      Scrollable.ensureVisible(fabricKye.currentContext!);
    }
  }
  pScroll(){
    if (paymentKye.currentContext != null) {
      Scrollable.ensureVisible(paymentKye.currentContext!);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap:(){
                    scroll();
                  },
                  child: Container(
                    padding:
                    EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h, bottom: 8.h),
                    margin: EdgeInsets.only(left: 6.w, top: 4.h,bottom: 6.h),
                    decoration: BoxDecoration(
                      color:Colors.blue,
                      border: Border.all(
                        color: Colors.indigo,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.remove_red_eye,color: Colors.white,),
                          SizedBox(width: 12.w,),
                          Text("fabric",
                            style:CustomTextStyles.semiBoldText(16.sp,color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap:(){
                    pScroll();
                  },
                  child: Container(
                    padding:
                    EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h, bottom: 8.h),
                    margin: EdgeInsets.only(left: 6.w, top: 4.h,bottom: 6.h),
                    decoration: BoxDecoration(
                      color:Colors.blue,
                      border: Border.all(
                        color: Colors.indigo,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.remove_red_eye,color: Colors.white,),
                          SizedBox(width: 12.w,),
                          Text("payment",
                            style:CustomTextStyles.semiBoldText(16.sp,color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
             CommonContainer(key: paymentKye),
             const CommonContainer(),
             const CommonContainer(),
            CommonFabric(key: fabricKye)
          ],
        ),
      ),
    );
  }
}
class CommonContainer extends StatelessWidget {
  const CommonContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1500.h,
      color: Colors.greenAccent,
    );
  }
}
class CommonFabric extends StatelessWidget {
  const CommonFabric({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      color: Colors.red,
    );
  }
}
