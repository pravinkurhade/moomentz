import 'package:flutter/material.dart';

class Navigation {
  static back(BuildContext context) {
    Navigator.pop(context);
  }

  static intent(BuildContext context, String nameRouted) {
    Navigator.pushNamed(context, nameRouted);
  }

  static intentWithoutBack(
      BuildContext context, String nameRouted, Object argumentClass) {
    Navigator.pushReplacementNamed(context, nameRouted,
        arguments: argumentClass);
  }

  static intentWithClearAllRoutes(BuildContext context, String nameRouted) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(nameRouted, (Route<dynamic> route) => false);
  }

  static intentWithData(
      BuildContext context, String nameRouted, Object argumentClass) {
    Navigator.pushNamed(context, nameRouted, arguments: argumentClass);
  }

  static intentWithDataReplaced(
      BuildContext context, String nameRouted, Object argumentClass) {
    Navigator.pushReplacementNamed(context, nameRouted,
        arguments: argumentClass);
  }

  static intentWithDatawithLIst(
      BuildContext context, String nameRouted, Object argumentClass) {
    Navigator.pushNamed(context, nameRouted, arguments: argumentClass);
  }
}
