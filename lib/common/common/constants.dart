import 'package:flutter/material.dart';

import 'colors.dart';

final ButtonStyle raisedButtonStyleYellow = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  primary: yellow,
  minimumSize: Size(88, 50),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
);

final ButtonStyle raisedButtonStyleBlue = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: blue,
  minimumSize: Size(88, 50),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
);

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: Colors.blue,
  minimumSize: Size(500, 45),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);

final OutlineInputBorder border = OutlineInputBorder(
// width: 0.0 produces a thin "hairline" border
  borderRadius: BorderRadius.circular(15.0),
  borderSide: const BorderSide(color: Colors.white, width: 0.0),
);

final kMessageContainerDecoration = BoxDecoration(
  border: Border.all(color: Colors.blue, width: 2.0),
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kSendButtonTextStyle = TextStyle(
  color: Colors.blue,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);
