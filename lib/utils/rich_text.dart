import 'package:flutter/material.dart';

RichText styledRichText({
  required String keyText,
  required String valueText,
  Color valueColor = Colors.deepPurple,
}) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: '$keyText: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        TextSpan(
          text: valueText,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            color: valueColor,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}
