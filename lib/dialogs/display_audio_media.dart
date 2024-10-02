import 'dart:typed_data';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/providers/services/base_64_conversor.dart';
import 'package:flashcard_pets/providers/dao/media_dao.dart';
import 'package:flashcard_pets/models/media.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sound/flutter_sound.dart';

class DisplayAudioMedia extends StatefulWidget {
  final String audioId;
  final bool canDelete;

  const DisplayAudioMedia(this.audioId, {this.canDelete = true, super.key});

  @override
  _DisplayAudioMediaState createState() => _DisplayAudioMediaState();
}

class _DisplayAudioMediaState extends State<DisplayAudioMedia> {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isPlaying = false;
  String? _audioString;

  @override
  void initState() {
    super.initState();
    _player.openPlayer();
    _loadAudioString();
  }

  Future<void> _loadAudioString() async {
    final mediaDao = Provider.of<MediaDao>(context, listen: false);
    final Media? media = await mediaDao.read(widget.audioId);
    if (media != null) {
      setState(() {
        _audioString = media.fileString;
      });
    }
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
      if (_audioString != null) {
        final Uint8List audioBytes =
            Provider.of<Base64Conversor>(context, listen: false)
                .base64ToBytes(_audioString!);
        await _player.startPlayer(
          fromDataBuffer: audioBytes,
          codec: Codec.aacADTS,
        );
      }
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
        if (widget.canDelete)
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
