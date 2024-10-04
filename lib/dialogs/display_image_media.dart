import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/providers/services/base_64_conversor.dart';
import 'package:flashcard_pets/providers/dao/media_dao.dart';
import 'package:flashcard_pets/models/media.dart';
import 'package:flashcard_pets/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayImageMedia extends StatefulWidget {
  final String imgId;
  final bool canDelete;

  const DisplayImageMedia(this.imgId, {this.canDelete = true, super.key});

  @override
  DisplayImageMediaState createState() => DisplayImageMediaState();
}

class DisplayImageMediaState extends State<DisplayImageMedia> {
  String? _imageString;

  @override
  void initState() {
    super.initState();
    _loadImageString();
  }

  Future<void> _loadImageString() async {
    final mediaDao = Provider.of<MediaDao>(context, listen: false);
    final Media? media = await mediaDao.read(widget.imgId);
    if (media != null) {
      setState(() {
        _imageString = media.fileString;
      });
    }
  }

  void _cancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _delete(BuildContext context) {
    Navigator.of(context).pop(true);
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
        "Exibir imagem",
        style: h2?.copyWith(
          color: secondary,
        ),
      ),
      content: _imageString == null
          ? const Loading()
          : Image.memory(
              Provider.of<Base64Conversor>(context)
                  .base64ToBytes(_imageString!),
              fit: BoxFit.contain,
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
