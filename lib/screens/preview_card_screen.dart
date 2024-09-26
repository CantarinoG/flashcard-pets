import 'package:flashcard_pets/models/flashcard.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/media_thumb.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';

class PreviewCardScreen extends StatefulWidget {
  final Flashcard flashcard;
  //Mocked data
  final List<int> _audioFiles = [1, 2];
  final List<int> _imgFiles = [1];
  final String _imgPath = "assets/images/baby_pets/beagle.png";
  PreviewCardScreen(this.flashcard, {super.key});

  @override
  State<PreviewCardScreen> createState() => _PreviewCardScreenState();
}

class _PreviewCardScreenState extends State<PreviewCardScreen> {
  List<Widget> _buildAudioMediaWidgets() {
    return widget._audioFiles.map((int img) {
      return MediaThumb();
    }).toList();
  }

  List<Widget> _buildImgMediaWidgets() {
    return widget._imgFiles.map((int img) {
      return MediaThumb(
        imgPath: widget._imgPath,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;

    final Color bright = Theme.of(context).colorScheme.bright;
    final Color text = Theme.of(context).colorScheme.text;

    return Scaffold(
      appBar: const ThemedAppBar(""),
      body: ScreenLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const UserStatsHeader(),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 4,
                  color: bright,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  widget.flashcard.frontContent,
                                  style: bodyEm.copyWith(
                                    color: text,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  widget.flashcard.backContent,
                                  style: body,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ..._buildAudioMediaWidgets(),
                              ..._buildImgMediaWidgets(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}