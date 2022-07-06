import 'package:flutter/material.dart';

void showSnackBar(
    {required String message,
      required BuildContext context,
      Duration? duration})
{
  var snack =  SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(20),
    duration: duration ?? const Duration(milliseconds: 1000),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    content: Text(
      message,
      textScaleFactor: 1,
      style: const TextStyle(color: Colors.white,),
    ),
    backgroundColor: Colors.black.withAlpha(200),
  );
  ScaffoldMessenger.of(context).showSnackBar(snack);
}
