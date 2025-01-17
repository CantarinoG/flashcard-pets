import 'dart:io';
import 'package:flashcard_pets/providers/services/base_64_conversor.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:provider/provider.dart';

class RecordAudioDialog extends StatefulWidget {
  const RecordAudioDialog({super.key});

  @override
  State<RecordAudioDialog> createState() => _RecordAudioDialogState();
}

class _RecordAudioDialogState extends State<RecordAudioDialog> {
  // Audio components
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();

  // State variables
  bool _isRecording = false;
  bool _isPlaying = false;
  bool _hasRecorded = false;
  String? _base64Audio;

  @override
  void initState() {
    super.initState();
    _initializeAudio();
  }

  Future<void> _initializeAudio() async {
    await requestPermissions();
    await _initializeRecorder();
    await _initializePlayer();
  }

  Future<void> requestPermissions() async {
    await Permission.microphone.request();
  }

  Future<void> _initializeRecorder() async {
    await _recorder.openRecorder();
  }

  Future<void> _initializePlayer() async {
    await _player.openPlayer();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _player.closePlayer();
    super.dispose();
  }

  // Recording methods
  Future<void> startRecording() async {
    await _recorder.startRecorder(toFile: 'audio.aac');
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> stopRecording() async {
    String? path = await _recorder.stopRecorder();
    if (path != null) {
      final bytes = File(path).readAsBytesSync();
      if (!mounted) return;
      _base64Audio = Provider.of<Base64Conversor>(context, listen: false)
          .bytesToBase64(bytes);
    }
    setState(() {
      _isRecording = false;
      _hasRecorded = true;
    });
  }

  // Playback methods
  Future<void> startPlaying() async {
    await _player.startPlayer(fromURI: 'audio.aac');
    setState(() {
      _isPlaying = true;
    });
  }

  Future<void> stopPlaying() async {
    await _player.stopPlayer();
    setState(() {
      _isPlaying = false;
    });
  }

  // Dialog actions
  void _confirmRecording() {
    Navigator.of(context).pop(_base64Audio);
  }

  void _cancelRecording() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildRecordButton() {
      return IconButton(
        icon: Icon(_isRecording ? Icons.stop : Icons.mic),
        onPressed: _isRecording ? stopRecording : startRecording,
        color: _isRecording ? Colors.red : Colors.green,
        iconSize: 48,
      );
    }

    Widget buildPlayButton() {
      return IconButton(
        icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
        onPressed: _isPlaying ? stopPlaying : startPlaying,
        color: _isPlaying ? Colors.red : Colors.blue,
        iconSize: 48,
      );
    }

    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color primary = Theme.of(context).colorScheme.primary;

    return AlertDialog(
      title: Text(
        "Gravar Áudio",
        style: h2?.copyWith(color: secondary),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildRecordButton(),
          if (_hasRecorded && !_isRecording) buildPlayButton(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _cancelRecording,
          child: Text('Cancelar', style: bodyEm.copyWith(color: primary)),
        ),
        if (_hasRecorded)
          TextButton(
            onPressed: _confirmRecording,
            child: Text('Confirmar', style: bodyEm.copyWith(color: primary)),
          ),
      ],
    );
  }
}
