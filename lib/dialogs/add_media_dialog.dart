// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:flashcard_pets/dialogs/record_audio_dialog.dart';
import 'package:flashcard_pets/models/media.dart';
import 'package:flashcard_pets/providers/dao/media_dao.dart';
import 'package:flashcard_pets/providers/services/base_64_conversor.dart';
import 'package:flashcard_pets/providers/services/uuid_provider.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddMediaDialog extends StatefulWidget {
  List<String> audioFiles;
  List<String> imgFiles;
  AddMediaDialog(this.audioFiles, this.imgFiles, {super.key});

  @override
  State<AddMediaDialog> createState() => _AddMediaDialogState();
}

class _AddMediaDialogState extends State<AddMediaDialog> {
  static const int _maxImageSize = 2 * 1024 * 1024; // 2MB
  static const double _buttonWidth = 200;
  static const double _spaceBetweenButtons = 8;

  String? errorMessage;

  Future<bool> _processImage(XFile image) async {
    final base64Provider = Provider.of<Base64Conversor>(context, listen: false);
    File imageFile = File(image.path);

    if (imageFile.lengthSync() > _maxImageSize) {
      setState(() {
        errorMessage = "Imagem não pode exceder 2mb";
      });
      return false;
    }

    Uint8List imageBytes = imageFile.readAsBytesSync();
    String base64String = base64Provider.bytesToBase64(imageBytes);
    final String uniqueId =
        Provider.of<UuidProvider>(context, listen: false).getUniqueId();
    final Media newMedia = Media(uniqueId, base64String);
    await Provider.of<MediaDao>(context, listen: false).insert(newMedia);

    widget.imgFiles.add(uniqueId);
    return true;
  }

  void _takePic() async {
    _resetErrorMsg();
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    final bool processmentCompleted = await _processImage(image);

    if (!mounted || !processmentCompleted) return;
    Navigator.of(context).pop();
  }

  void _choosePicFile(BuildContext context) async {
    _resetErrorMsg();
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final bool processmentCompleted = await _processImage(image);

    if (!mounted || !processmentCompleted) return;
    Navigator.of(context).pop();
  }

  void _recordAudio() async {
    _resetErrorMsg();
    String? audioString = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const RecordAudioDialog();
      },
    );
    if (audioString == null) return;
    final String uniqueId =
        Provider.of<UuidProvider>(context, listen: false).getUniqueId();
    final Media newMedia = Media(uniqueId, audioString);
    await Provider.of<MediaDao>(context, listen: false).insert(newMedia);
    widget.audioFiles.add(uniqueId);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  void _resetErrorMsg() {
    setState(() {
      errorMessage = null;
    });
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return Column(
      children: [
        ThemedFilledButton(
          label: label,
          onPressed: onPressed,
          width: _buttonWidth,
        ),
        const SizedBox(height: _spaceBetweenButtons),
      ],
    );
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
          _buildButton("Tirar Foto", _takePic),
          _buildButton("Escolher Foto", () => _choosePicFile(context)),
          _buildButton("Gravar Áudio", _recordAudio),
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
