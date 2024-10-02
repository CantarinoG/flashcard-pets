import 'dart:typed_data';
import 'package:flashcard_pets/models/media.dart';
import 'package:flashcard_pets/providers/dao/media_dao.dart';
import 'package:flashcard_pets/providers/services/base_64_conversor.dart';
import 'package:flashcard_pets/dialogs/display_image_media.dart';
import 'package:flashcard_pets/widgets/loading.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MediaThumbImg extends StatelessWidget {
  final String imgId;
  final bool canDelete;
  final void Function(String imgToDelete) onDelete;

  const MediaThumbImg(this.imgId, this.onDelete,
      {this.canDelete = true, super.key});

  void _onTap(BuildContext context) async {
    final bool? shouldDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DisplayImageMedia(imgId, canDelete: canDelete);
      },
    );
    if (shouldDelete != null && shouldDelete) {
      onDelete(imgId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaDao = Provider.of<MediaDao>(context, listen: false);
    final base64Conversor =
        Provider.of<Base64Conversor>(context, listen: false);

    return FutureBuilder<Media?>(
      future: mediaDao.read(imgId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return NoItemsPlaceholder("Nenhum dado encontrado.");
        }

        final Media media = snapshot.data!;
        final Uint8List imgBytes =
            base64Conversor.base64ToBytes(media.fileString);
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
      },
    );
  }
}
