import 'package:flashcard_pets/dialogs/evaluation_score_info.dart';
import 'package:flashcard_pets/models/collection.dart';
import 'package:flashcard_pets/models/flashcard.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/dao/i_dao.dart';
import 'package:flashcard_pets/providers/services/i_game_elements_calculations.dart';
import 'package:flashcard_pets/providers/services/i_json_data_provider.dart';
import 'package:flashcard_pets/providers/services/sm2_calculator.dart';
import 'package:flashcard_pets/screens/review_results_screen.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/loading.dart';
import 'package:flashcard_pets/widgets/media_thumb.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewScreen extends StatefulWidget {
  final Collection collection;
  final List<Flashcard> cardsToReview;
  //Mocked data
  final List<int> _audioFiles = [1, 2];
  final List<int> _imgFiles = [1];
  final String _imgPath = "assets/images/baby_pets/beagle.png";
  ReviewScreen(this.collection, this.cardsToReview, {super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  String? _error;
  int _currentCardIndex = 0;
  late final int _totalCardsNum = widget.cardsToReview.length;
  bool _showingBack = false;
  bool _evaluatedReview = false;
  double _sliderValue = 0;
  bool _isLoading = false;

  void _toggleShowingBack() {
    setState(() {
      _showingBack = !_showingBack;
    });
  }

  void _displayError(String? message) {
    setState(() {
      _error = message;
    });
  }

  void _evaluateRevision(BuildContext context) {
    _displayError(null);

    if (_evaluatedReview == false) {
      //User did not evaluated it.
      _displayError("Avaliar a sua revisão.");
      return;
    }

    //Give user reward for review
    final userDataProvider =
        Provider.of<IJsonDataProvider<User>>(context, listen: false);
    final gameCalcProvider =
        Provider.of<IGameElementsCalculations>(context, listen: false);
    int rewards = gameCalcProvider.calculateRevisionRewards(
        widget.cardsToReview[_currentCardIndex], _sliderValue.round());
    userDataProvider.readData().then((user) {
      if (user == null) return;
      User updatedUser = gameCalcProvider.addGold(user, rewards);
      userDataProvider.writeData(updatedUser);
    });

    //Save card attributes
    final updatedFlashcard = Provider.of<Sm2Calculator>(context, listen: false)
        .calculateNewValues(
            widget.cardsToReview[_currentCardIndex], _sliderValue.round());
    setState(() {
      _isLoading = true;
    });
    Provider.of<IDao<Flashcard>>(context, listen: false)
        .update(updatedFlashcard)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });

    if (_currentCardIndex <= _totalCardsNum - 2) {
      setState(() {
        _currentCardIndex++;
        _showingBack = false;
        _evaluatedReview = false;
        _sliderValue = 0;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ReviewResultsScreen(widget.collection.name, _totalCardsNum),
        ),
      );
    }
  }

  void _showInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const EvaluationScoreInfo();
      },
    );
  }

  void _changeSliderValue(double value) {
    setState(() {
      _evaluatedReview = true;
      _sliderValue = value;
    });
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
    final Color text = Theme.of(context).colorScheme.text;
    final Color error = Theme.of(context).colorScheme.error;

    return Scaffold(
      appBar: ThemedAppBar(widget.collection.name),
      body: ScreenLayout(
        child: _isLoading
            ? const Loading()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const UserStatsHeader(),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "${_currentCardIndex + 1}/$_totalCardsNum",
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
                                        widget.cardsToReview[_currentCardIndex]
                                            .frontContent,
                                        style: bodyEm.copyWith(
                                          color: text,
                                        ),
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
                                          widget
                                              .cardsToReview[_currentCardIndex]
                                              .backContent,
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
                          "Nota da Revisão: ${_sliderValue.round()}",
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
                      value: _sliderValue,
                      onChanged: _changeSliderValue,
                      min: 0,
                      max: 5,
                      divisions: 5,
                      label: "${_sliderValue.round()}",
                    ),
                  if (_showingBack)
                    const SizedBox(
                      height: 8,
                    ),
                  if (_showingBack && (_error != null))
                    Text(
                      _error!,
                      style: body?.copyWith(color: error),
                    ),
                  if (_showingBack && (_error != null))
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
