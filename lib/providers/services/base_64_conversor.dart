import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

class Base64Conversor with ChangeNotifier {
  String bytesToBase64(Uint8List bytes) {
    return base64Encode(bytes);
  }

  Uint8List base64ToBytes(String base64String) {
    return base64Decode(base64String);
  }
}
