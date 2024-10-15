import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../common_widget/commn_textfield.dart';
import '../common_widget/common_button.dart';
import '../common_widget/common_card.dart';
import '../common_widget/common_card_data.dart';
import '../common_widget/text_styles.dart';
import '../data/service.dart';

class CustomerListPage extends StatefulWidget {
  const CustomerListPage({Key? key}) : super(key: key);

  @override
  State<CustomerListPage> createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  Stream? userStream;
  getUserData() async {
    userStream = await Server.getUser();
    setState(() {});
  }

  Widget userDetails() {
    return StreamBuilder(
        stream: userStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.docs[index];
                    return CommonCard(
                        widget: Column(
                      children: [
                        CommonCardData(
                            title: "Customer Name", value: data["cus_name"]),
                        CommonCardData(
                            title: "net Wait", value: data["net_wait"]),
                        CommonCardData(title: "Price", value: data["price"]),
                        CommonCardData(
                            title: "Total Amount", value: data["total_amount"]),
                        CommonCardData(
                            title: "Payable Amount", value: data["pay_amount"]),
                        CommonCardData(
                            title: "Due Amount", value: data["du_amount"]),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: () {
                                  duAmount.text = data["du_amount"];
                                  dueAmount =
                                      double.tryParse(data["du_amount"])!;
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(18.0.r))),
                                          contentPadding: EdgeInsets.all(0.sp),
                                          content: Container(
                                            width: 350.w,
                                            height: 250.h,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(19.r),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey
                                                      .withOpacity(.2)),
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 12.w,
                                                      right: 12.w,
                                                      top: 10.h),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      Text(
                                                        "Your Last DuAmount ${data["du_amount"]}",
                                                        style: CustomTextStyles
                                                            .boldText(22.sp,
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      CommonTextField(
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly,
                                                          NumericRangeFormatter(
                                                              min: 0,
                                                              max: double
                                                                  .tryParse(data[
                                                                      "du_amount"])!),
                                                        ],
                                                        inputType: TextInputType
                                                            .number,
                                                        textAlign:
                                                            TextAlign.end,
                                                        redOnly: false,
                                                        controler: payNow,
                                                        hint: "payNoAmount",
                                                        label: "payNoAmount",
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      CommonTextField(
                                                          inputType:
                                                              TextInputType
                                                                  .number,
                                                          controler: disAmount,
                                                          hint:
                                                              "Enter Discount Amount",
                                                          textAlign:
                                                              TextAlign.end,
                                                          redOnly: false),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                InkWell(
                                                  onTap: () async {
                                                    double pAmount =0.0;
                                                    if(payNow.text.isNotEmpty){
                                                      pAmount=double.tryParse(
                                                          payNow.text)!;
                                                    }
                                                    double dAmount =
                                                        (dueAmount - pAmount);
                                                    String date = DateFormat(
                                                            'dd MMMM, yyyy')
                                                        .format(DateTime.now());
                                                    Map<String, dynamic>
                                                        userInf = {
                                                      "cus_id": data["cus_id"],
                                                      "cus_name":
                                                          data["cus_name"],
                                                      "quantity":
                                                          data["quantity"],
                                                      "net_wait":
                                                          data["net_wait"],
                                                      "price": data["price"],
                                                      "total_amount":
                                                          data["total_amount"],
                                                      "pay_amount": payNow.text,
                                                      "du_amount": dAmount
                                                          .toStringAsFixed(2),
                                                      "disCountAmount":
                                                          disAmount.text,
                                                      "date": date,
                                                    };
                                                    await Server.updateUser(
                                                            userInf,
                                                            data["cus_id"])
                                                        .then((value) {
                                                      print("object");
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: Center(
                                                    child: Container(
                                                      //width: 330.w,
                                                      height: 45.h,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFF1B3D79),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        18.r),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        18.r)),
                                                        border: Border.all(
                                                            width: .3,
                                                            color: Theme.of(
                                                                    context)
                                                                .focusColor),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Update",
                                                          style:
                                                              CustomTextStyles
                                                                  .boldText(
                                                            18.sp,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Center(
                                  child: Container(
                                    //width: 330.w,
                                    height: 45.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1B3D79),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(18.r),
                                      ),
                                      border: Border.all(
                                          width: .3,
                                          color: Theme.of(context).focusColor),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Update",
                                        style: CustomTextStyles.boldText(
                                          18.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 6.w,
                            ),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(18.0.r))),
                                          contentPadding: EdgeInsets.all(0.sp),
                                          content: Container(
                                            width: 350.w,
                                            height: 150.h,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(19.r),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey
                                                      .withOpacity(.2)),
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 12.w,
                                                      right: 12.w,
                                                      top: 10.h),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      Text(
                                                        "Are you sure you want to delete?This Customer Delete ",
                                                        style: CustomTextStyles
                                                            .boldText(22.sp,
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: InkWell(
                                                        onTap: () {
                                                          Server.deleteUser(
                                                              data["cus_id"]);
                                                        },
                                                        child: Center(
                                                          child: Container(
                                                            //width: 330.w,
                                                            height: 45.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color(
                                                                  0xFF1B3D79),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        18.r),
                                                              ),
                                                              border: Border.all(
                                                                  width: .3,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .focusColor),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "Yes",
                                                                style:
                                                                    CustomTextStyles
                                                                        .boldText(
                                                                  18.sp,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 6.w,
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Center(
                                                          child: Container(
                                                            //width: 330.w,
                                                            height: 45.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color(
                                                                  0xFF1B3D79),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        18.r),
                                                              ),
                                                              border: Border.all(
                                                                  width: .3,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .focusColor),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "No",
                                                                style:
                                                                    CustomTextStyles
                                                                        .boldText(
                                                                  18.sp,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Center(
                                  child: Container(
                                    //width: 330.w,
                                    height: 45.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1B3D79),
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(18.r),
                                      ),
                                      border: Border.all(
                                          width: .3,
                                          color: Theme.of(context).focusColor),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Delete",
                                        style: CustomTextStyles.boldText(
                                          18.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ));
                  })
              : SizedBox();
        });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  final payNow = TextEditingController();
  final duAmount = TextEditingController();
  final disAmount = TextEditingController();
  double dueAmount = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B3D79),
        title: Text(
          "Customer List Page",
          style: CustomTextStyles.boldText(22.sp, color: Colors.white),
        ),
      ),
      body: userDetails(),
    );
  }
}

// class CustomerListPage extends StatefulWidget {
//   const CustomerListPage({Key? key}) : super(key: key);
//
//   @override
//   State<CustomerListPage> createState() => _CustomerListPageState();
// }
//
// class _CustomerListPageState extends State<CustomerListPage> {
//   final payNow = TextEditingController();
//   double dueAmount = 0.0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF1B3D79),
//         title: Text(
//           "Customer List Page",
//           style: CustomTextStyles.boldText(22.sp, color: Colors.white),
//         ),
//       ),
//       body: StreamBuilder<List<UserListModel>>(
//         stream: Server.getItems(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           if (!snapshot.hasData) {
//             return const Center(child: Text('No data found'));
//           }
//           final users = snapshot.data!;
//           return ListView.builder(
//             itemCount: users.length,
//             itemBuilder: (context, index) {
//               final user = users[index];
//               return CommonCard(
//                 widget: Column(
//                   children: [
//                     CommonCardData(title: "Customer Name", value: user.name),
//                     CommonCardData(title: "Customer ID", value: user.userID),
//                     CommonCardData(title: "net Wait", value: user.netWait),
//                     CommonCardData(title: "Price", value: user.price),
//                     CommonCardData(
//                         title: "Total Amount", value: user.totalAmount),
//                     CommonCardData(
//                         title: "Payable Amount", value: user.paybelAmount),
//                     CommonCardData(title: "Due Amount", value: user.dueAmount),
//                     CommonButton(
//                         buttonText: "update",
//                         onTap: () {
//                           dueAmount = double.tryParse(user.dueAmount)!;
//                           showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return AlertDialog(
//                                   elevation: 10,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(18.0.r))),
//                                   contentPadding: EdgeInsets.all(0.sp),
//                                   content: Container(
//                                     width: 350.w,
//                                     height: 190.h,
//                                     decoration: BoxDecoration(
//                                       color: Theme.of(context)
//                                           .scaffoldBackgroundColor,
//                                       borderRadius: BorderRadius.circular(19.r),
//                                       border: Border.all(
//                                           width: 1,
//                                           color: Colors.grey.withOpacity(.2)),
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.only(
//                                               left: 12.w,
//                                               right: 12.w,
//                                               top: 10.h),
//                                           child: Column(
//                                             children: [
//                                               SizedBox(
//                                                 height: 10.h,
//                                               ),
//                                               CommonTextField(
//                                                 inputFormatters: [
//                                                   FilteringTextInputFormatter
//                                                       .digitsOnly,
//                                                   NumericRangeFormatter(
//                                                       min: 0,
//                                                       max: double.tryParse(
//                                                           user.dueAmount)!),
//                                                 ],
//                                                 inputType: TextInputType.number,
//                                                 textAlign: TextAlign.end,
//                                                 redOnly: false,
//                                                 controler: payNow,
//                                                 hint: "payNoAmount",
//                                                 label: "payNoAmount",
//                                               ),
//                                               SizedBox(
//                                                 height: 10.h,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         const Spacer(),
//                                         InkWell(
//                                           onTap: () {
//                                             double pAmount =
//                                                 double.tryParse(payNow.text)!;
//                                             double dAmount =
//                                                 (dueAmount - pAmount);
//                                             // Server.updateUserData(
//                                             //     index,
//                                             //     payNow.text,
//                                             //     dAmount.toStringAsFixed(2));
//                                             //  updatePaymentList(index, payNow.text,dAmount.toString());
//                                             Navigator.pop(context);
//                                           },
//                                           child: Center(
//                                             child: Container(
//                                               //width: 330.w,
//                                               height: 45.h,
//                                               decoration: BoxDecoration(
//                                                 color: Theme.of(context)
//                                                     .disabledColor,
//                                                 borderRadius: BorderRadius.only(
//                                                     bottomLeft:
//                                                         Radius.circular(18.r),
//                                                     bottomRight:
//                                                         Radius.circular(18.r)),
//                                                 border: Border.all(
//                                                     width: .3,
//                                                     color: Theme.of(context)
//                                                         .focusColor),
//                                               ),
//                                               child: Center(
//                                                 child: Text(
//                                                   "Update",
//                                                   style:
//                                                       CustomTextStyles.boldText(
//                                                     18.sp,
//                                                     color: Colors.white,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               });
//                         }),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
