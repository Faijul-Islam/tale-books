
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:tale_book/common_widget/common_card.dart';

import '../common_widget/commn_textfield.dart';
import '../common_widget/common_button.dart';
import '../common_widget/text_styles.dart';
import '../controler/customer_controler.dart';
import '../data/service.dart';

class UserEntryPage extends StatefulWidget {
  const UserEntryPage({Key? key}) : super(key: key);

  @override
  State<UserEntryPage> createState() => _UserEntryPageState();
}

class _UserEntryPageState extends State<UserEntryPage> {
  final nameCon = TextEditingController();
  final idCon = TextEditingController();
  final quantityCon = TextEditingController();
  final waitCon = TextEditingController();
  final priceCon = TextEditingController();
  final paymentAmountCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var searchModel = Provider.of<CustomerListControler>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:const Color(0xFF1B3D79),
        title: Text("Add Customer",
        style:CustomTextStyles.boldText(22.sp,color: Colors.white) ,
        ),
      ),
      body:ListView(
        children: [
          SizedBox(
            height:14.h,
          ),
          CommonCard(
              widget:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height:2.h,
                  ),
                  Text(
                    "Enter Customer Name(গ্রাহকের নাম লিখুন)",
                    style: CustomTextStyles.boldText(16.sp,) ,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  CommonTextField(
                      controler: nameCon,
                      hint: "Enter Name",
                      textAlign: TextAlign.start,
                      redOnly: false
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Enter quantity(পিস লিখুন)",
                    style:CustomTextStyles.boldText(16.sp,) ,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  CommonTextField(
                      inputType: TextInputType.number,
                      controler: quantityCon,
                      hint: "Enter quantity",
                      textAlign: TextAlign.start,
                      redOnly: false
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Enter wait(নেটওয়েট লিখুন)",
                    style:CustomTextStyles.boldText(16.sp,) ,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  CommonTextField(
                    inputType: TextInputType.number,
                    controler: waitCon,
                    hint: "Enter wait",
                    textAlign: TextAlign.start,
                    redOnly: false,
                    onChange: (String value){
                      if(waitCon.text.isNotEmpty&&priceCon.text.isNotEmpty){
                        double price=double.tryParse(priceCon.text)!;
                        double netWait=double.tryParse(value)!;
                        double totalAmount=(price * netWait );
                        searchModel.setTotalAmount(totalAmount.toStringAsFixed(2));
                      }

                    },
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Enter price(মূল্য লিখুন)",
                    style:CustomTextStyles.boldText(16.sp,) ,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  CommonTextField(
                    inputType: TextInputType.number,
                    controler: priceCon,
                    hint: "Enter price",
                    textAlign: TextAlign.start,
                    redOnly: false,
                    onChange: (String value){
                      if(waitCon.text.isNotEmpty&&priceCon.text.isNotEmpty){
                        double price=double.tryParse(value)!;
                        double netWait=double.tryParse(waitCon.text)!;
                        double totalAmount=(price * netWait );
                        searchModel.setTotalAmount(totalAmount.toStringAsFixed(2));
                      }
                    },
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Your Total Amount(আপনার মোট পরিমাণ)(${searchModel.tAmount})",
                    style:CustomTextStyles.boldText(16.sp,) ,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Enter payable amount(জমাক্রিত টাকার পরিমাণ লিখুন)",
                    style:CustomTextStyles.boldText(16.sp,) ,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  CommonTextField(
                      inputType: TextInputType.number,
                      controler: paymentAmountCon,
                      hint: "Enter payable amount",
                      textAlign: TextAlign.start,
                      redOnly: false
                  ),
                ],
              )
          ),
          SizedBox(
            height: 12.h,
          ),
          CommonButton(
              buttonText: "Submit",
              onTap: ()async{
                if(nameCon.text.isNotEmpty){
                  if(quantityCon.text.isNotEmpty){
                    if(waitCon.text.isNotEmpty){
                      if(priceCon.text.isNotEmpty){
                        double price=double.tryParse(priceCon.text)!;
                        double netWait=double.tryParse(waitCon.text)!;
                        double payAmount=0.0;
                        if(paymentAmountCon.text.isNotEmpty){
                          payAmount=double.tryParse(paymentAmountCon.text)!;
                        }
                        double totalAmount=(price * netWait );
                        double duAmount=(totalAmount-payAmount);
                        String date= DateFormat('dd MMMM, yyyy').format(DateTime.now());
                        String id=randomAlphaNumeric(5);
                        Map<String,dynamic> userInf={
                          "cus_id": id,
                          "cus_name": nameCon.text,
                          "quantity": quantityCon.text,
                          "net_wait": waitCon.text,
                          "price":priceCon.text,
                          "total_amount": totalAmount.toStringAsFixed(2),
                          "pay_amount": paymentAmountCon.text,
                          "du_amount":duAmount.toStringAsFixed(2),
                          "disCountAmount":"0.0",
                          "date":date,
                        };
                        await Server.addUser(userInf, id).then((value){
                          const snackdemo = SnackBar(
                            content: Text('User added successfully'),
                            backgroundColor: Colors.red,
                            elevation: 10,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(5),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                        });
                        Server.setUser(
                            idCon.text,
                            nameCon.text,
                            quantityCon.text,
                            waitCon.text,
                            priceCon.text,
                            totalAmount.toStringAsFixed(2),
                            paymentAmountCon.text,
                            duAmount.toStringAsFixed(2),
                            date
                        );
                        Navigator.pop(context);
                      }else{
                        const snackdemo = SnackBar(
                          content: Text('Please enter rate'),
                          backgroundColor: Colors.red,
                          elevation: 10,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(5),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                      }
                    }else{
                      const snackdemo = SnackBar(
                        content: Text('Please enter net wait'),
                        backgroundColor: Colors.red,
                        elevation: 10,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                    }
                  }else{
                    const snackdemo = SnackBar(
                      content: Text('Please enter quantity'),
                      backgroundColor: Colors.red,
                      elevation: 10,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(5),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                  }
                }
                else{
                  const snackdemo = SnackBar(
                    content: Text('Please enter customer name'),
                    backgroundColor: Colors.red,
                    elevation: 10,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(5),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                }
              }
          )
        ],
      ),

    );
  }
}
