import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  String hint;
  TextEditingController controller;
  Function? validateListener;
  List<TextInputFormatter>? inputFormatter;
  TextInputType? keyboardType;
  String? labelText;
  TextInputAction? keyboardAction;
  double? textSize;
  Widget? suffixIcon;
  Function? onTapListener;
  bool? hidePasswordText;
  Function? onFieldSubmitted;
  Function? onFieldChanged;
  bool? isEnabled;

  InputField(
      {Key? key,
      this.hint = "",
      required this.controller,
      this.validateListener,
      this.inputFormatter,
      this.labelText,
      this.keyboardType,
      this.keyboardAction,
      this.textSize,
      this.suffixIcon,
      this.onTapListener,
      this.hidePasswordText,
      this.onFieldSubmitted,
      this.onFieldChanged,
      this.isEnabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
        validator: (value) => validateListener?.call(),
        keyboardType: keyboardType ?? TextInputType.text,
        enabled: isEnabled,
        textInputAction: keyboardAction ?? TextInputAction.next,
        inputFormatters:
            inputFormatter ?? [FilteringTextInputFormatter.singleLineFormatter],
        controller: controller,
        onFieldSubmitted: ((value) => onFieldSubmitted?.call()),
        onChanged: ((value) => onFieldChanged?.call()),
        obscureText: hidePasswordText ?? false,
        onTap: onTapListener?.call(),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          fillColor: Colors.white,
          filled: true,
          labelStyle: TextStyle(
              fontSize: textSize != null && textSize! > 0.0 ? textSize : 14.0),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          labelText: labelText,
        ),
      );
}

// ignore: must_be_immutable
class DisplayDataField extends StatelessWidget {
  String value;
  String labelTxt;

  DisplayDataField({Key? key, this.value = "", this.labelTxt = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: TextEditingController()..text = value,
        decoration: InputDecoration(
          enabled: false,
          labelText: labelTxt,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
        ),
      );
}
