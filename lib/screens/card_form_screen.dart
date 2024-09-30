import 'package:flashcard_pets/models/collection.dart';
import 'package:flashcard_pets/models/flashcard.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/dao/collection_dao.dart';
import 'package:flashcard_pets/providers/dao/flashcard_dao.dart';
import 'package:flashcard_pets/providers/services/i_id_provider.dart';
import 'package:flashcard_pets/providers/services/i_json_data_provider.dart';
import 'package:flashcard_pets/snackbars/error_snackbar.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/loading.dart';
import 'package:flashcard_pets/widgets/media_thumb.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/text_field_wrapper.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardFormScreen extends StatefulWidget {
  final String? preSelectedCollectionId;
  final Flashcard? editingFlashcard;
  //Mocked data
  final List<int> _audioFiles = [1, 2];
  final List<int> _imgFiles = [1];
  final String _imgPath = "assets/images/baby_pets/beagle.png";
  CardFormScreen(
      {this.preSelectedCollectionId, this.editingFlashcard, super.key});

  @override
  State<CardFormScreen> createState() => _CardFormScreenState();
}

class _CardFormScreenState extends State<CardFormScreen> {
  List<Collection> _collections = [];
  String? _selectedItem;

  final TextEditingController _frontController = TextEditingController();
  final TextEditingController _backController = TextEditingController();

  bool _isLoading = false;

  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCollections();
    if (widget.editingFlashcard != null) {
      _frontController.text = widget.editingFlashcard!.frontContent;
      _backController.text = widget.editingFlashcard!.backContent;
      _selectedItem = widget.editingFlashcard!.collectionId;
    }
  }

  Future<void> _loadCollections() async {
    final collectionDao = Provider.of<CollectionDao>(context, listen: false);
    final collections = await collectionDao.readAll();

    setState(() {
      _collections = collections;
      if (_collections.isNotEmpty) {
        _selectedItem = (widget.editingFlashcard != null)
            ? widget.editingFlashcard!.collectionId
            : widget.preSelectedCollectionId ?? _collections.first.id;
      }
    });
  }

  bool _isBeingEdited() {
    return widget.editingFlashcard != null;
  }

  Future<void> _registerCard(BuildContext context) async {
    _displayError(null);
    String front = _frontController.text.trim();
    String back = _backController.text.trim();
    String collectionCode = _selectedItem ?? _collections.first.id;

    if (!_isDataValidated(front, back, collectionCode)) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      if (_isBeingEdited()) {
        widget.editingFlashcard!.collectionId = _selectedItem!;
        widget.editingFlashcard!.frontContent = front;
        widget.editingFlashcard!.backContent = back;
        await Provider.of<FlashcardDao>(context, listen: false)
            .update(widget.editingFlashcard!);
      } else {
        final String uniqueId =
            Provider.of<IIdProvider>(context, listen: false).getUniqueId();

        final Flashcard newFlashcard = Flashcard(
          uniqueId,
          collectionCode,
          front,
          back,
          DateTime.now(),
        );

        await Provider.of<FlashcardDao>(context, listen: false)
            .insert(newFlashcard);

        final IJsonDataProvider<User> userProvider =
            Provider.of<IJsonDataProvider<User>>(context, listen: false);
        final User? user = await userProvider.readData();
        if (user != null) {
          user.createdCards++;
          userProvider.writeData(user);
        }
      }

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                const ErrorSnackbar("Ocorreu algum erro. Tente novamente."),
            backgroundColor: Theme.of(context).colorScheme.bright,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  bool _isDataValidated(String front, String back, String collectionCode) {
    if (front.isEmpty) {
      _displayError("O cartão precisa ter um conteúdo de frente.");
      return false;
    }

    if (back.isEmpty) {
      _displayError("O cartão precisa ter um conteúdo de verso.");
      return false;
    }

    bool isValidCollection =
        _collections.any((collection) => collection.id == collectionCode);

    if (!isValidCollection) {
      _displayError("Código de coleção inválido.");
      return false;
    }

    return true;
  }

  void _changeSelectedCollection(String? value) {
    setState(() {
      _selectedItem = value ?? _collections.first.id;
    });
  }

  void _addMedia() {
    //...
  }

  void _displayError(String? message) {
    setState(() {
      _error = message;
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
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color text = Theme.of(context).colorScheme.text;
    final Color error = Theme.of(context).colorScheme.error;

    return Scaffold(
      appBar: const ThemedAppBar("Cartão"),
      body: ScreenLayout(
        child: _isLoading
            ? const Loading()
            : SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height - 100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFieldWrapper(
                        label: "Conjunto",
                        child: SizedBox(
                          width: double.infinity,
                          child: DropdownButton<String>(
                            hint: const Text('Seleciona uma opção'),
                            isExpanded: true,
                            value: _selectedItem,
                            items: _collections.map((Collection item) {
                              return DropdownMenuItem<String>(
                                value: item.id,
                                child: Text(
                                  item.name,
                                  style: body?.copyWith(
                                    color: text,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: _changeSelectedCollection,
                            underline: const SizedBox.shrink(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFieldWrapper(
                        label: "Frente",
                        child: TextField(
                          controller: _frontController,
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          style: body?.copyWith(
                            color: text,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            errorText: null,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: TextFieldWrapper(
                          label: "Verso",
                          child: Expanded(
                            child: TextField(
                              controller: _backController,
                              textInputAction: TextInputAction.newline,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              minLines: null,
                              expands: true,
                              scrollPhysics: const BouncingScrollPhysics(),
                              style: body?.copyWith(
                                color: text,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                errorText: null,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFieldWrapper(
                        label: "Mídia(Opcional)",
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ..._buildAudioMediaWidgets(),
                              ..._buildImgMediaWidgets(),
                              Container(
                                width: 50,
                                height: 50,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.add),
                                  color: Colors.white,
                                  onPressed: _addMedia,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      if (_error != null)
                        Text(
                          _error!,
                          style: body?.copyWith(
                            color: error,
                          ),
                        ),
                      if (_error != null)
                        const SizedBox(
                          height: 8,
                        ),
                      ThemedFilledButton(
                          label: "Cadastrar",
                          onPressed: () {
                            _registerCard(context);
                          }),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
