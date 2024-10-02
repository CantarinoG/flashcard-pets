import 'package:flashcard_pets/dialogs/display_audio_media.dart';
import 'package:flutter/material.dart';

class MediaThumbAudio extends StatelessWidget {
  final String base64AudioString;
  final void Function(String audioToDelete) onDelete;
  final bool canDelete;
  const MediaThumbAudio(this.base64AudioString, this.onDelete,
      {this.canDelete = true, super.key});

  void _onTap(BuildContext context) async {
    final bool? shouldDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DisplayAudioMedia(base64AudioString, canDelete: canDelete);
      },
    );
    if (shouldDelete != null && shouldDelete) {
      onDelete(base64AudioString);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;

    return Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: primary,
            width: 2,
          ),
        ),
        child: IconButton(
          icon: const Icon(Icons.mic),
          color: Colors.white,
          onPressed: () {
            _onTap(context);
          },
        ));
  }
}
