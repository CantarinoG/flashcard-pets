import 'dart:io';
import 'dart:typed_data';

import 'package:flashcard_pets/providers/services/base_64_conversor.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddMediaDialog extends StatefulWidget {
  List<String> audioFiles;
  List<String> imgFiles;
  AddMediaDialog(this.audioFiles, this.imgFiles, {super.key});

  @override
  State<AddMediaDialog> createState() => _AddMediaDialogState();
}

class _AddMediaDialogState extends State<AddMediaDialog> {
  String? errorMessage;

  void _takePic() {
    //...
  }

  void _choosePicFile(BuildContext context) async {
    final base64Provider = Provider.of<Base64Conversor>(context, listen: false);

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    File imageFile = File(image.path);
    if (imageFile.lengthSync() > (5 * 1024 * 1024)) {
      setState(() {
        errorMessage = "Imagem não pode exceder 5mb";
      });
      return;
    }

    Uint8List imageBytes = imageFile.readAsBytesSync();
    String base64String = base64Provider.bytesToBase64(imageBytes);
    widget.imgFiles.add(base64String);
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
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color error = Theme.of(context).colorScheme.error;

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
            onPressed: () {
              _choosePicFile(context);
            },
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
          const SizedBox(
            height: 8,
          ),
          if (errorMessage != null)
            Text(
              errorMessage!,
              style: body?.copyWith(
                color: error,
              ),
            ),
        ],
      ),
    );
  }
}
