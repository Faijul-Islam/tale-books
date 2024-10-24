import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../payges/home_page.dart';

class LoginController extends GetxController{
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  late CollectionReference userCollection;
  @override
  void onInit() {
    userCollection=firestore.collection("users");
    super.onInit();
  }

  addUser(userName,userPhone)async{
    try{
      // Check if the user with the same phone number exists
      var querySnapshot = await userCollection
          .where("userPhone", isEqualTo: userPhone)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        // User already exists, navigate to the home page
        Get.snackbar("Info", "User already exists", colorText: Colors.blue);
        Get.offAll(() => const HomePage());
      }else{
        DocumentReference doc=userCollection.doc();
        final userJson={
          "userId":doc.id,
          "userName":userName,
          "userPhone":userPhone,
        };
        doc.set(userJson);
        Get.snackbar("success", "User added Successfully",colorText:Colors.green);
        Get.offAll(() => const HomePage());
      }

    }catch(e){
      Get.snackbar("Error", e.toString(),colorText:Colors.red);
    }
  }
}

