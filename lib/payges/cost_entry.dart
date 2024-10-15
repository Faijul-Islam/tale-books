import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tale_book/common_widget/commn_textfield.dart';
import 'package:tale_book/common_widget/common_button.dart';

class CostEntry extends StatefulWidget {
  const CostEntry({Key? key}) : super(key: key);

  @override
  State<CostEntry> createState() => _CostEntryState();
}

class _CostEntryState extends State<CostEntry> {
  final costTitle=TextEditingController();
  final costAmount=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cost entry "),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CommonTextField(
              controler: costTitle,
              hint: "Enter cost Title",
              textAlign: TextAlign.left,
              redOnly: false
          ),
          CommonTextField(
              controler: costTitle,
              hint: "Enter cost Title",
              textAlign: TextAlign.left,
              redOnly: false
          ),
          CommonButton(buttonText: "Submit", onTap: (){
            String date= DateFormat('dd MMMM, yyyy').format(DateTime.now());
          })
        ],
      ),
    );
  }
}
