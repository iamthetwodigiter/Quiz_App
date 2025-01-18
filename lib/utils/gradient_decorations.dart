import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

final linearGradient = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Colors.deepPurple,
      CupertinoColors.systemGrey5,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.4, 0.99],
  ),
);

final radialGradient = BoxDecoration(
  gradient: RadialGradient(
    radius: 1.5,
    colors: [
      // const Color.fromARGB(255, 154, 117, 255),
      const Color.fromARGB(255, 148, 217, 252),
      Colors.lightBlueAccent,
    ],
  ),
  borderRadius: BorderRadius.circular(10),
);
