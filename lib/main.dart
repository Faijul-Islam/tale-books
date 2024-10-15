import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:tale_book/payges/home_page.dart';

import 'controler/customer_controler.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCGj4TMPcbt1uFOReYSUZDUvViuKLLBez0",
        appId: "1:977561027553:android:5bdd9311f84edd8d5408a0",
        messagingSenderId: "977561027553 ",
        projectId: "poltrebook-fa672"
    )
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CustomerListControler()),

      //MoneyReceiptEditBloc
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:const PoultryBook(),
    );
  }
}

class PoultryBook extends StatelessWidget {
  const PoultryBook({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //========== initialized the screen utility =========
    //========== handles pixel perfect sizes ============
    //---------------------------------------------------

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const HomePage();
      },
    );
  }
}
