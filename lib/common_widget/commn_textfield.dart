// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {Key? key,
      required this.controler,
      required this.hint,
      this.label,
      this.iconData,
      this.prefixIcon,
      this.inputType,
      this.onChange,
        this.inputFormatters,
      required this.textAlign,
      required this.redOnly,
      this.onTap})
      : super(key: key);
  final TextEditingController controler;
  final String hint;
  final String? label;
  final Widget? iconData;
  final Widget? prefixIcon;
  final TextInputType? inputType;
  final Function(String)? onChange;
  final TextAlign textAlign;
  final bool redOnly;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      //margin: EdgeInsets.only(left: 4.w,right: 4.w,),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
         border: Border.all(color:const Color(0xFF4494CE).withOpacity(0.1), width: 1.w),
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: SizedBox(
        height: 44.h,
        child: TextFormField(
          onTap: onTap,
          inputFormatters:inputFormatters,
          keyboardType: inputType,
          autocorrect: false,
          controller: controler,
          readOnly: redOnly,
          onChanged: onChange,
          textAlign: textAlign,
          // focusNode: _focusNode,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
            labelText: label,
            labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
            suffixIcon: iconData,
            prefixIcon: prefixIcon,
            //fillColor: Theme.of(context).scaffoldBackgroundColor,
            //border: InputBorder.none,
            fillColor:Theme.of(context).colorScheme.background,
            // const Color(0xFFEEF3F7)
            contentPadding:
            EdgeInsets.only(left: 12.w, top: 0.h, bottom: 0.h,right: 12.w),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(28.0.r)),
                borderSide: BorderSide.none
            ),
            // disabledBorder: OutlineInputBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(28.0.r)),
            //     borderSide: BorderSide(
            //         color: Theme.of(context).focusColor, width: .1.w)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(28.0.r)),
                borderSide: BorderSide(color: Colors.blue, width: .1.w)),
            filled: true,
            //  labelText: widget.title,
          ),
          // validator: widget.validator,
          // onSaved: (String newValue) {},
        ),
      ),
    );
  }
}
/// this class use for controler length validation
// class NumericRangeFormatter extends TextInputFormatter {
//
//   final double min;
//   final double max;
//
//   NumericRangeFormatter({required this.min, required this.max});
//
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue,
//       TextEditingValue newValue,
//       ) {
//     if (newValue.text.isEmpty) {
//       return newValue;
//     }
//
//     final newValueNumber = double.tryParse(newValue.text);
//
//     if (newValueNumber == null) {
//       return oldValue;
//     }
//
//     if (newValueNumber < min) {
//       return newValue.copyWith(text: min.toString());
//     } else if (newValueNumber > max) {
//       return newValue.copyWith(text: max.toString());
//     } else {
//       return newValue;
//     }
//   }
// }

class NumericRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;

  NumericRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final newValueNumber = double.tryParse(newValue.text);

    if (newValueNumber == null) {
      return oldValue;
    }

    // Allow decimal numbers
    if (newValue.text == '.') {
      return newValue.copyWith(text: '0.');
    }

    // Handle the case when the value is out of range
    if (newValueNumber < min) {
      return newValue.copyWith(text: min.toString());
    } else if (newValueNumber > max) {
      return newValue.copyWith(text: max.toString());
    } else {
      return newValue;
    }
  }
}


class CommonTextFields extends StatelessWidget {
  const CommonTextFields(
      {Key? key,
      required this.controler,
      required this.hint,
      this.label,
      this.iconData,
      this.prefixIcon,
      this.inputType,
      this.onChange,
        this.inputFormatters,
      required this.textAlign,
      required this.redOnly,
      this.onTap})
      : super(key: key);
  final TextEditingController controler;
  final String hint;
  final String? label;
  final Widget? iconData;
  final Widget? prefixIcon;
  final TextInputType? inputType;
  final Function(String)? onChange;
  final TextAlign textAlign;
  final bool redOnly;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.h,
      child: TextFormField(
        onTap: onTap,
        inputFormatters:inputFormatters,
        keyboardType: inputType,
        autocorrect: false,
        controller: controler,
        readOnly: redOnly,
        onChanged: onChange,
        textAlign: textAlign,
        // focusNode: _focusNode,
        style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
          labelText: label,
          suffixIcon: iconData,
          prefixIcon: prefixIcon,
         // fillColor: Theme.of(context).scaffoldBackgroundColor,
        //  border: InputBorder.none,
          fillColor:Theme.of(context).scaffoldBackgroundColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0.r)),
              borderSide: BorderSide.none
          ),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0.r)),
              borderSide: BorderSide(
                  color: Theme.of(context).focusColor, width: .1.w)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0.r)),
              borderSide: BorderSide(color: Colors.blue, width: .1.w)),
          filled: true,
          contentPadding:
              EdgeInsets.only(bottom: 0.0.h, left: 10.0.w, right: 10.0.w,top: -16),
          //  labelText: widget.title,
        ),
        // validator: widget.validator,
        // onSaved: (String newValue) {},
      ),
    );
  }
}