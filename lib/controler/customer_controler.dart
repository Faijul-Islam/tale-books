import 'package:flutter/material.dart';

class CustomerListControler with ChangeNotifier{
  /// this function response for money receipt booking or delivery List add, edit and clear list

  String _tAmount="";
  String get tAmount=> _tAmount;
  setTotalAmount(String amount){
    _tAmount=amount;
    notifyListeners();
  }


  final List<Map<String, dynamic>> _customerList = [];

  List<Map<String, dynamic>> get paymentList => _customerList;

  void addPaymentList(Map<String, dynamic> payment) {
    _customerList.add(payment);
    Future.microtask(() {
      notifyListeners();
    });
  }


  void deletePaymentList(int index) {
    if (index >= 0 && index < _customerList.length) {
      _customerList.removeAt(index);
      Future.microtask(() {
        notifyListeners();
      });
    } else {
    }
  }

  void updatePaymentList(int index, String payAmount,String duAmount
    ) {
    _customerList[index]["pay_amount"] = payAmount;
    _customerList[index]["du_amount"] = duAmount;
    Future.microtask(() {
      notifyListeners();
    });
  }

  void clearPaymentList() {
    _customerList.clear();
    Future.microtask(() {
      notifyListeners();
    });
  }


}