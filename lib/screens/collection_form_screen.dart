import 'package:flashcard_pets/models/collection.dart';
import 'package:flashcard_pets/models/subject.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/constants/subject_data_provider.dart';
import 'package:flashcard_pets/providers/dao/collection_dao.dart';
import 'package:flashcard_pets/providers/services/user_json_data_provider.dart';
import 'package:flashcard_pets/providers/services/uuid_provider.dart';
import 'package:flashcard_pets/snackbars/error_snackbar.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/loading.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/text_field_wrapper.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionFormScreen extends StatefulWidget {
  final Collection? editingCollection;
  const CollectionFormScreen({this.editingCollection, super.key});

  @override
  State<CollectionFormScreen> createState() => _CollectionFormScreenState();
}

class _CollectionFormScreenState extends State<CollectionFormScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int _selectedItem = 0;

  String? _error;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.editingCollection != null) {
      _nameController.text = widget.editingCollection!.name;
      _descriptionController.text = widget.editingCollection!.description;
      _selectedItem = widget.editingCollection!.subjectCode;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _changeSelectedSubject(int? value) {
    setState(() {
      _selectedItem = value ?? 0;
    });
  }

  void _displayError(String? message) {
    setState(() {
      _error = message;
    });
  }

  bool _isDataValidated(String name, String description, int subjectCode) {
    if (name.isEmpty) {
      _displayError("A coleção precisa ter um nome.");
      return false;
    }

    final List<int> allowedCodes = Provider.of<SubjectDataProvider>(
      context,
      listen: false,
    ).retrieveData().keys.toList();
    if (!allowedCodes.contains(subjectCode)) {
      _displayError("Disciplina inválida.");
      return false;
    }

    return true;
  }

  bool _isBeingEdited() {
    return widget.editingCollection != null;
  }

  Future<void> _register() async {
    _displayError(null);
    String name = _nameController.text.trim();
    String description = _descriptionController.text.trim();
    int subjectCode = _selectedItem;

    if (!_isDataValidated(name, description, subjectCode)) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      if (_isBeingEdited()) {
        widget.editingCollection!.name = name;
        widget.editingCollection!.subjectCode = subjectCode;
        widget.editingCollection!.description = description;
        await Provider.of<CollectionDao>(context, listen: false)
            .update(widget.editingCollection!);
      } else {
        final String uniqueId =
            Provider.of<UuidProvider>(context, listen: false).getUniqueId();

        final Collection newCollection = Collection(
          uniqueId,
          name,
          subjectCode,
          description,
        );

        await Provider.of<CollectionDao>(context, listen: false)
            .insert(newCollection);

        final UserJsonDataProvider userProvider =
            Provider.of<UserJsonDataProvider>(context, listen: false);
        final User? user = await userProvider.readData();
        if (user != null) {
          user.createdCollections++;
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

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final Color text = Theme.of(context).colorScheme.text;
    final Color disabled = Theme.of(context).disabledColor;
    final Color error = Theme.of(context).colorScheme.error;

    final Map<int, Subject> subjects =
        Provider.of<SubjectDataProvider>(context).retrieveData();

    return Scaffold(
      appBar: const ThemedAppBar("Conjunto"),
      body: ScreenLayout(
        child: _isLoading
            ? const Loading()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFieldWrapper(
                    label: "Nome",
                    child: TextField(
                      controller: _nameController,
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      style: body?.copyWith(
                        color: text,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Meu conjunto",
                        hintStyle: body?.copyWith(
                          color: disabled,
                        ),
                        errorText: null,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFieldWrapper(
                    label: "Disciplina",
                    child: SizedBox(
                      width: double.infinity,
                      child: DropdownButton<int>(
                        hint: const Text('Seleciona uma opção'),
                        isExpanded: true,
                        value: _selectedItem,
                        items: subjects.entries.map((entry) {
                          return DropdownMenuItem<int>(
                            value: entry.key,
                            child: Text(
                              entry.value.name,
                              style: body?.copyWith(
                                color: text,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: _changeSelectedSubject,
                        underline: const SizedBox.shrink(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: TextFieldWrapper(
                      label: "Descrição (opcional)",
                      child: Expanded(
                        child: TextField(
                          controller: _descriptionController,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: null,
                          expands: true,
                          scrollPhysics: const BouncingScrollPhysics(),
                          style: body?.copyWith(
                            color: text,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Esse conjunto é...",
                            hintStyle: body?.copyWith(
                              color: disabled,
                            ),
                            errorText: null,
                          ),
                        ),
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
                    onPressed: _register,
                  ),
                ],
              ),
      ),
    );
  }
}
