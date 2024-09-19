import 'package:flashcard_pets/screens/review_results_screen.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/media_thumb.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  //Mocked data
  final String _collectionName = "Cálculo I";
  final int _currentCard = 1;
  final int _numCards = 8;
  final String _frontContent = "Como calcular uma derivada?";
  final String _backContent =
      " Para calcular uma derivada, basta lorem ipsum lorem ipsum lorem ipsum lorem ipsum.";
  final List<int> _audioFiles = [1, 2];
  final List<int> _imgFiles = [1];
  final String _imgPath = "assets/images/baby_pets/beagle.png";
  ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  bool _showingBack = false;

  void _toggleShowingBack() {
    setState(() {
      _showingBack = !_showingBack;
    });
  }

  void _evaluateRevision(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ReviewResultsScreen(),
      ),
    );
  }

  void _showInfo() {
    //...
  }

  void _changeSliderValue(double value) {
    //...
  }

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
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color bright = Theme.of(context).colorScheme.bright;

    return Scaffold(
      appBar: ThemedAppBar(widget._collectionName),
      body: ScreenLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const UserStatsHeader(),
            const SizedBox(
              height: 16,
            ),
            Text(
              "${widget._currentCard}/${widget._numCards}",
              style: h2?.copyWith(
                color: secondary,
              ),
            ),
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
                                  widget._frontContent,
                                  style: bodyEm,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                if (_showingBack) const Divider(),
                                const SizedBox(
                                  height: 8,
                                ),
                                if (_showingBack)
                                  Text(
                                    widget._backContent,
                                    style: body,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        if (_showingBack)
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
            if (_showingBack)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Nota da Revisão",
                    style: h3?.copyWith(
                      color: secondary,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  IconButton.filled(
                    onPressed: _showInfo,
                    icon: const Icon(Icons.info_outline),
                  ),
                ],
              ),
            if (_showingBack)
              const SizedBox(
                height: 8,
              ),
            if (_showingBack)
              Slider(
                value: 4,
                onChanged: _changeSliderValue,
                min: 0,
                max: 5,
                label: "5",
              ),
            if (_showingBack)
              const SizedBox(
                height: 8,
              ),
            ThemedFilledButton(
                label: _showingBack ? "Confirmar" : "Ver Resposta",
                onPressed: _showingBack
                    ? () {
                        _evaluateRevision(context);
                      }
                    : _toggleShowingBack),
          ],
        ),
      ),
    );
  }
}
