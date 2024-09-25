import 'package:flashcard_pets/models/collection.dart';
import 'package:flashcard_pets/providers/dao/i_dao.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/media_thumb.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/text_field_wrapper.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardFormScreen extends StatefulWidget {
  //Mocked data
  final List<int> _audioFiles = [1, 2];
  final List<int> _imgFiles = [1];
  final String _imgPath = "assets/images/baby_pets/beagle.png";
  CardFormScreen({super.key});

  @override
  State<CardFormScreen> createState() => _CardFormScreenState();
}

class _CardFormScreenState extends State<CardFormScreen> {
  List<Collection> _collections = [];
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    _loadCollections();
  }

  Future<void> _loadCollections() async {
    final collectionDao = Provider.of<IDao<Collection>>(context, listen: false);
    final collections = await collectionDao.readAll();

    setState(() {
      _collections = collections;
      if (_collections.isNotEmpty) {
        _selectedItem = _collections.first.id;
      }
    });
  }

  void _registerCard(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _changeSelectedCollection(String? value) {
    setState(() {
      _selectedItem = value ?? _collections.first.id;
    });
  }

  void _addMedia() {
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
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color text = Theme.of(context).colorScheme.text;

    return Scaffold(
      appBar: const ThemedAppBar("Cartão"),
      body: ScreenLayout(
        child: SingleChildScrollView(
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
                          margin: const EdgeInsets.symmetric(horizontal: 2),
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
