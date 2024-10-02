import 'dart:typed_data';
import 'package:flashcard_pets/providers/services/base_64_conversor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MediaThumbImg extends StatelessWidget {
  final String base64ImgString;
  const MediaThumbImg(this.base64ImgString, {super.key});

  void _onTap() {}

  @override
  Widget build(BuildContext context) {
    final Uint8List imgBytes =
        Provider.of<Base64Conversor>(context).base64ToBytes(base64ImgString);

    final Color primary = Theme.of(context).colorScheme.primary;

    return InkWell(
      onTap: _onTap,
      radius: 12,
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: primary,
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.memory(
            imgBytes,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
