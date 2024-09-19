import 'package:flashcard_pets/widgets/gift_notification.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';

class NotificationsDialog extends StatelessWidget {
  //Mocked data
  final List<int> _notifications = [1, 1];
  NotificationsDialog({super.key});

  void _goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _receiveAll(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: _notifications.isEmpty
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const NoItemsPlaceholder(
                    "Você não possui nenhuma notificação de amigos no momento. Volte mais tarde."),
                ThemedFilledButton(
                    label: "Voltar",
                    onPressed: () {
                      _goBack(context);
                    }),
              ],
            )
          : SizedBox(
              width: 600,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ThemedFilledButton(
                    label: "Receber Todos",
                    onPressed: () {
                      _receiveAll(context);
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 150,
                      maxHeight: 600,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _notifications.length,
                      itemBuilder: (context, index) {
                        return const GiftNotification();
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
