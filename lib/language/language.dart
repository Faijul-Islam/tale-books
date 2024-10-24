import 'package:get/get.dart';

class Language extends Translations {
  @override
  Map<String,Map<String,String>>get keys =>{
    'en_US':{
      "login":"Login",
      "customerAdd":"Customer add",
      "customerList":"Customer List",
    },
    'bn_BD':{
      "login":"লগইন করুন",
      "customerAdd":"গ্রাহক যোগ করুন",
      "customerList":"গ্রাহক তালিকা",
    },
  };
}