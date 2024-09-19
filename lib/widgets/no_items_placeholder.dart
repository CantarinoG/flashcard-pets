import 'package:flutter/material.dart';

class NoItemsPlaceholder extends StatelessWidget {
  final String message;
  const NoItemsPlaceholder(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: body,
            textAlign: TextAlign.center,
          ),
          FractionallySizedBox(
            widthFactor: 0.7,
            child: Image.asset('assets/images/no_items_placeholder_image.png'),
          ),
        ],
      ),
    );
  }
}
