import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart'; // Add this import
import 'package:permission_handler/permission_handler.dart';

class RecordAudioDialog extends StatefulWidget {
  const RecordAudioDialog({super.key});

  @override
  State<RecordAudioDialog> createState() => _RecordAudioDialogState();
}

class _RecordAudioDialogState extends State<RecordAudioDialog> {
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  FlutterSoundPlayer _player = FlutterSoundPlayer(); // Add this line
  bool _isRecording = false;
  bool _isPlaying = false; // Add this line
  bool _hasRecorded = false; // Add this line

  @override
  void initState() {
    super.initState();
    requestPermissions();
    _initializeRecorder();
    _initializePlayer(); // Add this line
  }

  Future<void> requestPermissions() async {
    await Permission.microphone.request();
  }

  Future<void> _initializeRecorder() async {
    await _recorder.openRecorder();
  }

  Future<void> _initializePlayer() async {
    // Add this method
    await _player.openPlayer();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _player.closePlayer(); // Add this line
    super.dispose();
  }

  Future<void> startRecording() async {
    await _recorder.startRecorder(toFile: 'audio.aac');
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> stopRecording() async {
    await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
      _hasRecorded = true; // Add this line
    });
  }

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

  @override
  Widget build(BuildContext context) {
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color warning = Theme.of(context).colorScheme.warning;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color text = Theme.of(context).colorScheme.text;

    return AlertDialog(
      title: Text(
        "Gravar Áudio",
        style: h2?.copyWith(
          color: secondary,
        ),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(_isRecording ? Icons.stop : Icons.mic),
            onPressed: _isRecording ? stopRecording : startRecording,
            color: _isRecording ? Colors.red : Colors.green,
            iconSize: 48,
          ),
          if (_hasRecorded && !_isRecording) // Update this condition
            IconButton(
              icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
              onPressed: _isPlaying ? stopPlaying : startPlaying,
              color: _isPlaying ? Colors.red : Colors.blue,
              iconSize: 48,
            ),
        ],
      ),
    );
  }
}
