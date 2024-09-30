import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';

class AddMediaDialog extends StatelessWidget {
  const AddMediaDialog({super.key});

  void _takePic() {
    //...
  }

  void _choosePicFile() {
    //...
  }

  void _recordAudio() {
    //...
  }

  void _chooseAudioFile() {
    //...
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    return AlertDialog(
      title: Text(
        "Adicionar Mídia",
        style: h2?.copyWith(
          color: secondary,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ThemedFilledButton(
            label: "Tirar Foto",
            onPressed: _takePic,
            width: 200,
          ),
          const SizedBox(
            height: 8,
          ),
          ThemedFilledButton(
            label: "Escolher Foto",
            onPressed: _choosePicFile,
            width: 200,
          ),
          const SizedBox(
            height: 8,
          ),
          ThemedFilledButton(
            label: "Gravar Áudio",
            onPressed: _recordAudio,
            width: 200,
          ),
          const SizedBox(
            height: 8,
          ),
          ThemedFilledButton(
            label: "Escolher Áudio",
            onPressed: _chooseAudioFile,
            width: 200,
          ),
        ],
      ),
    );
  }
}
