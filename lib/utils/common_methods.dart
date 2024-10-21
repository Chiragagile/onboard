import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onboard/utils/colors.dart';

GetStorage getStorage = GetStorage();
var size = Get.width;

Widget textWidget(
    {required String text,
      TextOverflow? textOverFlow,
      FontWeight? fontWeight,
      double? fontSize,
      Color? textColor,
      double? bottomPadding,
      double? topPadding,
      double? leftPadding,
      TextAlign? textAlign,
      double? rightPadding}) {
  return Padding(
    padding: EdgeInsets.only(
        bottom: bottomPadding ?? 0,
        right: rightPadding ?? 0,
        left: leftPadding ?? 0,
        top: topPadding ?? 0),
    child: Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        overflow: textOverFlow ?? TextOverflow.visible,
        color: textColor ?? Get.context!.theme.cardColor,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize ?? 16.0,
      ),
    ),
  );
}

GetSnackBar snackBarWidget(
    {icon, iconColor, titleColor, required title, required message}) {
  return GetSnackBar(
    barBlur: 1.0,
    titleText: textWidget(text: title, textColor: titleColor ?? primaryColor),
    messageText: textWidget(text: message, textColor: whiteColor),
    backgroundColor: blackTextColor,
    duration: const Duration(seconds: 2),
    icon: Icon(icon ?? Icons.info, color: iconColor),
  );
}

Widget mediumSpace() {
  return SizedBox(
    height: Get.width * 0.1,
    width: Get.width * 0.1,
  );
}

Widget smallMediumSpace() {
  return SizedBox(
    height: Get.width * 0.07,
    width: Get.width * 0.07,
  );
}

Widget smallSpace() {
  return SizedBox(
    width: Get.width * 0.05,
    height: Get.width * 0.05,
  );
}



Widget normalTextFormFieldWithBorder({
  TextEditingController? controller,
  FocusNode? focusNode,
  required String label,
  Color? color,
  Color? hintColor,
  VoidCallback? onEditingComplete,
  bool? obscureText,
  FormFieldValidator<String>? validator,
  ValueChanged<String>? onFieldSubmitted,
  TextInputAction? textInputAction,
  Widget? icon,
  List<TextInputFormatter>? inputFormatter,
  GestureTapCallback? onTap,
  bool? readOnly,
  FontWeight? labelFontWeight,
  int? maxLength
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      textWidget(text:label,),
      const SizedBox(height: 5),
      TextFormField(
        autofocus: false,
        onTap: onTap ?? () {},
        readOnly: readOnly ?? false,
        controller: controller,
        keyboardType: TextInputType.text,
        style: TextStyle(color: color ?? blackTextColor),
        onEditingComplete: onEditingComplete,
        obscureText: obscureText ?? false,
        validator: validator,
        inputFormatters: inputFormatter,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: textInputAction ?? TextInputAction.next,
        obscuringCharacter: '*',
        maxLength: maxLength,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
      //    labelText: label,
          labelStyle: TextStyle(color: color ?? greyColor),
       //   hintText: "Enter $label",
     //     hintStyle: TextStyle(color: hintColor ?? greyColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size * 0.02),
            borderSide: const BorderSide(color: greyColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size * 0.02),
            borderSide: const BorderSide(color: greyColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size * 0.02),
            borderSide: const BorderSide(color: greyColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size * 0.02),
            borderSide: const BorderSide(color: greyColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size * 0.02),
            borderSide: const BorderSide(color: Colors.red),
          ),
          errorStyle: const TextStyle(
            color: Colors.red
          ),
        ),
      ),
    ],
  );
}

Widget mobileTextFormFieldWithBorder(
    {controller,
      title,
      focusNode,
      label,
      color,
      hintColor,
      onEditingComplete,
      obscureText,
      validator,
      onFieldSubmitted,
      textInputAction,
      readOnly,
      icon,
      onChanged}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      textWidget(text: label),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
        autofocus: false,
        readOnly: readOnly ?? false,
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(color: color ?? blackTextColor),
        onEditingComplete: onEditingComplete,
        obscureText: obscureText ?? false,
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10)
        ],
        textInputAction: textInputAction ?? TextInputAction.next,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
            //    labelText: label,
            labelStyle: TextStyle(color: color ?? greyColor),
            //   hintText: "Enter $label",
            //     hintStyle: TextStyle(color: hintColor ?? greyColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(size * 0.02),
              borderSide: const BorderSide(color: greyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(size * 0.02),
              borderSide: const BorderSide(color: greyColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(size * 0.02),
              borderSide: const BorderSide(color: greyColor),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(size * 0.02),
              borderSide: const BorderSide(color: greyColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(size * 0.02),
              borderSide: const BorderSide(color: Colors.red),
            ),
            errorStyle: const TextStyle(
                color: Colors.red
            )
        ),
            )
    ],
  );
}

Widget emailTextFormFieldWithBorder(
    {controller,
      focusNode,
      label,
      color,
      hintColor,
      onEditingComplete,
      obscureText,
      validator,
      onFieldSubmitted,
      textInputAction,
      icon,
      onTap,
      readOnly}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    textWidget(text: label),
    const SizedBox(
      height: 5,
    ),
    TextFormField(
      autofocus: false,
      onTap: onTap ?? () {},
      readOnly: readOnly ?? false,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: color ?? blackTextColor),
      onEditingComplete: onEditingComplete,
      obscureText: obscureText ?? false,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction ?? TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
          //    labelText: label,
          labelStyle: TextStyle(color: color ?? greyColor),
          //   hintText: "Enter $label",
          //     hintStyle: TextStyle(color: hintColor ?? greyColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size * 0.02),
            borderSide: const BorderSide(color: greyColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size * 0.02),
            borderSide: const BorderSide(color: greyColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size * 0.02),
            borderSide: const BorderSide(color: greyColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size * 0.02),
            borderSide: const BorderSide(color: greyColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size * 0.02),
            borderSide: const BorderSide(color: Colors.red),
          ),
          errorStyle: const TextStyle(
              color: Colors.red
          )
      ),
    )
  ]);
}

Widget customDropDown({title, list, onChanged, val}) {
  List<DropdownMenuItem> items = List.generate(
      list.length,
          (index) => DropdownMenuItem(
        value: list[index],
        child: textWidget(text: list[index]),
      ));
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      textWidget(text: title),
      const SizedBox(
        height: 5,
      ),
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size * 0.02),
            border: Border.all(color: greyColor)),
        height: size * 0.14,
        width: size * 0.90,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButton(
            underline: const SizedBox(),
            isExpanded: true,
            items: items,
            onChanged: onChanged,
            dropdownColor: whiteColor,
            style: const TextStyle(color: greyColor),
            icon: Icon(
              Icons.arrow_drop_down,
              color: Theme.of(Get.context!).primaryColor,
              size: 25,
            ),
            value: val,
            hint: textWidget(
              text: title,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget numericTextFormFieldWithBorder(
    {controller,
      focusNode,
      label,
      color,
      hintColor,
      onEditingComplete,
      obscureText,
      validator,
      onFieldSubmitted,
      textInputAction,
      icon,
      length,
      suffixText,
      showEnter = true,
      width,
      inputFormatter,
      readOnly}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    textWidget(text: label),
    const SizedBox(
      height: 10,
    ),
    TextFormField(
      autofocus: false,
      readOnly: readOnly ?? false,
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(color: color ?? blackTextColor),
      onEditingComplete: onEditingComplete,
      obscureText: obscureText ?? false,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction ?? TextInputAction.next,
      inputFormatters: inputFormatter,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
          //    labelText: label,
          labelStyle: TextStyle(color: color ?? greyColor),
          //   hintText: "Enter $label",
          //     hintStyle: TextStyle(color: hintColor ?? greyColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size * 0.02),
            borderSide: const BorderSide(color: greyColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size * 0.02),
            borderSide: const BorderSide(color: greyColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size * 0.02),
            borderSide: const BorderSide(color: greyColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size * 0.02),
            borderSide: const BorderSide(color: greyColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size * 0.02),
            borderSide: const BorderSide(color: Colors.red),
          ),
          errorStyle: const TextStyle(
              color: Colors.red
          )
      ),
    )
  ]);
}

Widget customRaisedButton(
    {required text,
      width,
      fontSize,
      height,
      radius,
      onPressed,
      textColor,
      fontWeight,
      color,
      borderColor}) {
  return GestureDetector(
    onTap: onPressed ?? () {},
    child: Card(
      elevation: 1,
      color: color ?? primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 20),
      ),
      child: Container(
        width: width ?? Get.width * 0.9,
        height: height ?? 50,
        decoration: BoxDecoration(
            color: color ?? whiteColor,
            borderRadius: BorderRadius.circular(radius ?? 20),
            border: Border.all(color: borderColor ?? Colors.transparent)),
        child: Center(
            child: textWidget(
                text: text,
                fontWeight: fontWeight,
                fontSize: fontSize,
                textColor: textColor ?? blackTextColor)),
      ),
    ),
  );
}