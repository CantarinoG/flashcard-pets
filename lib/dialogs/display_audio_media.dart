import 'dart:typed_data';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/providers/services/base_64_conversor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sound/flutter_sound.dart';

class DisplayAudioMedia extends StatefulWidget {
  final String base64AudioString;

  const DisplayAudioMedia(this.base64AudioString, {super.key});

  @override
  _DisplayAudioMediaState createState() => _DisplayAudioMediaState();
}

class _DisplayAudioMediaState extends State<DisplayAudioMedia> {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player.openPlayer();
  }

  @override
  void dispose() {
    _player.closePlayer();
    super.dispose();
  }

  void _cancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _delete(BuildContext context) {
    Navigator.of(context).pop(true);
  }

  Future<void> _playPause() async {
    if (_isPlaying) {
      await _player.stopPlayer();
    } else {
      final Uint8List audioBytes =
          Provider.of<Base64Conversor>(context, listen: false)
              .base64ToBytes(widget.base64AudioString);
      await _player.startPlayer(
        fromDataBuffer: audioBytes,
        codec: Codec.aacADTS,
      );
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color error = Theme.of(context).colorScheme.error;

    return AlertDialog(
      title: Text(
        "Reproduzir áudio",
        style: h2?.copyWith(
          color: secondary,
        ),
      ),
      content: IconButton(
        onPressed: _playPause,
        icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
        color: _isPlaying ? error : primary,
        iconSize: 48,
      ),
      actions: [
        TextButton(
          onPressed: () {
            _cancel(context);
          },
          child: Text(
            "Voltar",
            style: bodyEm.copyWith(
              color: primary,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            _delete(context);
          },
          child: Text(
            "Excluir",
            style: bodyEm.copyWith(color: error),
          ),
        ),
      ],
    );
  }
}
