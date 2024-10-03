import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class SyncDialog extends StatelessWidget {
  //MockedData
  final int localLevel = 14;
  final int localGold = 14;
  final int localReviews = 34;
  final DateTime localLastTimeUsedApp = DateTime.now(); //dia
  final int? remoteLevel = 14;
  final int? remoteGold = 14;
  final int? remoteReviews = 34;
  final DateTime? remoteLastTimeUsedApp = DateTime.now();
  SyncDialog({super.key});

  void _cancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  void _chooseLocal(BuildContext context) {
    //...
  }

  void _chooseRemote(BuildContext context) {
    //...
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final TextStyle h4 = Theme.of(context).textTheme.headlineSmallEm;
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color primary = Theme.of(context).colorScheme.primary;

    return AlertDialog(
      title: Text(
        "Quais Dados Deseja Manter?",
        style: h2?.copyWith(
          color: secondary,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: secondary,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Dados Locais",
                        style: h3?.copyWith(
                          color: secondary,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "LVL",
                            style: h4.copyWith(
                              color: secondary,
                            ),
                          ),
                          Text(
                            " $localLevel",
                            style: body,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            "assets/images/custom_icons/coin.svg",
                            width: 30,
                            height: 30,
                          ),
                          Text(
                            " $localGold",
                            style: body,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Revisões",
                            style: body?.copyWith(
                              color: secondary,
                            ),
                          ),
                          Text(
                            " $localReviews",
                            style: body,
                          ),
                        ],
                      ),
                      Text(
                        "Atualizado em",
                        style: body?.copyWith(
                          color: secondary,
                        ),
                      ),
                      Text(
                        " ${_formatDate(localLastTimeUsedApp)}",
                        style: body,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                if ((remoteGold != null) &&
                    (remoteLastTimeUsedApp != null) &&
                    (remoteLevel != null) &&
                    (remoteReviews != null))
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: secondary,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Dados na Nuvem",
                          style: h3?.copyWith(
                            color: secondary,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "LVL",
                              style: h4.copyWith(
                                color: secondary,
                              ),
                            ),
                            Text(
                              " $remoteLevel",
                              style: body,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              "assets/images/custom_icons/coin.svg",
                              width: 30,
                              height: 30,
                            ),
                            Text(
                              " $remoteGold",
                              style: body,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Revisões",
                              style: body?.copyWith(
                                color: secondary,
                              ),
                            ),
                            Text(
                              " $remoteReviews",
                              style: body,
                            ),
                          ],
                        ),
                        Text(
                          "Atualizado em",
                          style: body?.copyWith(
                            color: secondary,
                          ),
                        ),
                        Text(
                          " ${_formatDate(remoteLastTimeUsedApp!)}",
                          style: body,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ThemedFilledButton(
                  label: "Local",
                  onPressed: () {
                    _chooseLocal(context);
                  }),
              SizedBox(
                width: 16,
              ),
              ThemedFilledButton(
                  label: "Nuvem",
                  onPressed: () {
                    _chooseRemote(context);
                  })
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            _cancel(context);
          },
          child: Text(
            "Cancelar",
            style: bodyEm.copyWith(
              color: primary,
            ),
          ),
        ),
      ],
    );
  }
}
