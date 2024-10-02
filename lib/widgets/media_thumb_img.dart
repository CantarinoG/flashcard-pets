import 'dart:typed_data';
import 'package:flashcard_pets/providers/services/base_64_conversor.dart';
import 'package:flashcard_pets/dialogs/display_image_media.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MediaThumbImg extends StatelessWidget {
  final String base64ImgString;
  final bool canDelete;
  final void Function(String imgToDelete) onDelete;

  const MediaThumbImg(this.base64ImgString, this.onDelete,
      {this.canDelete = true, super.key});

  void _onTap(BuildContext context) async {
    final bool? shouldDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DisplayImageMedia(base64ImgString, canDelete: canDelete);
      },
    );
    if (shouldDelete != null && shouldDelete) {
      onDelete(base64ImgString);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Uint8List imgBytes =
        Provider.of<Base64Conversor>(context).base64ToBytes(base64ImgString);

    final Color primary = Theme.of(context).colorScheme.primary;

    return InkWell(
      onTap: () => _onTap(context),
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
