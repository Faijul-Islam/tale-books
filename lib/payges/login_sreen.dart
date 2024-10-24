import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tale_book/common_widget/commn_textfield.dart';
import 'package:tale_book/common_widget/common_button.dart';
import 'package:tale_book/common_widget/text_styles.dart';

import '../config/colors.dart';
import '../config/images.dart';
import '../controler/login/login_controler.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userName=TextEditingController();
  final userPhone=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        builder: (loginCont){
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Container(
                  height: 300.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.login),
                      fit: BoxFit.cover, // or any other fit style
                    ),
                  ),
                ),
                SizedBox(height: 12.h,),
                Align(
                  alignment: Alignment.center,
                  child: Text("Login this app",
                    style: CustomTextStyles.boldText(22,color: CustomColors.primary),
                  ),
                ),
                SizedBox(height: 20.h,),
                CommonTextField(
                    controler: userName,
                    hint: "Enter User Name",
                    textAlign: TextAlign.start,
                    redOnly: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter user name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12.h,),
                CommonTextField(
                  inputType: TextInputType.number,
                    controler: userPhone,
                    hint: "Enter User Phone",
                    textAlign: TextAlign.start,
                    redOnly: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter user phone";
                    } else if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                      return "Please enter a valid phone number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 60.h,),
                CommonButton(
                    buttonText: "Login",
                    onTap: (){
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, add the user
                        loginCont.addUser(userName.text, userPhone.text);
                      }
                    }
                ),
              ],
            ),
          ),
        ),
      );
    });

  }
}
