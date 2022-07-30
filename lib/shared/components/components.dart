import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fox_delivery/styles/Themes.dart';

Widget myDivider(
    {required Color color,
    double paddingVertical = 8.0,
    double paddingHorizontal = 8.0}) {
  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: paddingVertical, horizontal: paddingHorizontal),
    child: Container(
      height: 2,
      color: color,
    ),
  );
}

void navigateAndFinish({required context, required widget}) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return widget;
  }));
}

void showToast({
  required String msg,
  Color color = Colors.white,
  Color textColor = Colors.black,
}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: textColor,
      fontSize: 16.0);
}

Widget defaultButton({
  double width = double.infinity,
  double height = 55,
  Color backgroundColor = Colors.blue,
  double borderRadius = 5.0,
  required String text,
  bool isUpperCase = false,
  Color TextColor = Colors.black,
  required fun,
}) {
  return Container(
    width: width,
    height: height,
    child: MaterialButton(
      onPressed: fun,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(
          color: TextColor,
          fontSize: 15,
        ),
      ),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      color: backgroundColor,
    ),
  );
}

Widget defaultTextButton(
    {required String text,
    required fun,
    double fontSize = 14,
    Color textColor = Colors.blue,
    FontWeight weight = FontWeight.w300}) {
  return TextButton(
      onPressed: fun,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: weight,
        ),
      ));
}

Widget textFormField({
  required BuildContext? context,
  required TextEditingController controller,
  bool isPassword = false,
  String validation = "",
  required String label,
  required TextInputType type,
  TextStyle? style,
  IconData? prefixIcon,
  double? paddingInside,
  IconData? suffixIcon,
  void Function()? fun,
  double borderRadius = 5.0,

}){
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    validator: (String? value) {
      if (value!.isEmpty) {
        return validation;
      }
    },
    decoration: InputDecoration(
        label: Text(
          label,
          style: style,
        ),
        prefixIcon: Icon(prefixIcon, color: defaultColor,),
        suffixIcon: IconButton(
          onPressed:  fun,
          icon: Icon(suffixIcon==null?suffixIcon = null: suffixIcon = suffixIcon, color: defaultColor),
        ),
        contentPadding: paddingInside != null ? EdgeInsets.symmetric(vertical: paddingInside) : null,
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context!).scaffoldBackgroundColor
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide:  BorderSide(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Theme.of(context).scaffoldBackgroundColor))),
  );
}

Widget buttonBuilder({
  required fun,
  double height = 50,
  double width = double.infinity,
  double elevation = 10,
  required String text,
  bool isUpper = false,
  Color textColor = Colors.white,

}){
  return Container(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
    ),
    child: MaterialButton(
      elevation: elevation,
      color: defaultColor,
      height: height,
      minWidth: width,
      onPressed: fun,
      child: Text(isUpper?text.toUpperCase():text,
        style: TextStyle(
            color: textColor
        ),),
    ),
  );

}
